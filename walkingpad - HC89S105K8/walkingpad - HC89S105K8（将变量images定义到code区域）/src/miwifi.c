#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#include "miwifi.h"
#include "declare.h"
#include "sensor.h"
#include "beep.h"
#include "run_mode.h"
#include "eeprom.h"
#include "image.h"
#include "displaydriver.h"
#include "newtype.h"
#include "key.h"
#include "time.h"

 eulong mean;
 euchar idx1;
 euchar idx2;

#define BUFF_LEN 100
#define WAIT_WIFI_FEEDBACK_TIME 250

#define START_WITH(s0, s1) strncmp(s0, s1, sizeof(s1) - 1) == 0

//communication status
 static enum {
    COMMU_STATE_MCU2WIFI_UNASSIGN,
    COMMU_STATE_MCU2WIFI_TRANSMIT,
    COMMU_STATE_MCU2WIFI_RECEIVE
} commu_mcu2wifi_state;

 static enum {
    MCU_WIFI_NO_COMMAND,
    MCU_WIFI_MODEL_QUERY,
    MCU_WIFI_MODEL_SETTING,
    MCU_WIFI_VERSION,
    MCU_WIFI_RESTORE,
    MCU_WIFI_PROPS,
    MCU_WIFI_GET_DOWN,
    MCU_WIFI_RESULT,
    MCU_WIFI_ERROR,
    MCU_WIFI_NET,
    MCU_WIFI_STORE_MP,
    MCU_WIFI_STORE_POINT,
    MCU_WIFI_STORE_OFFLINE,
    MCU_WIFI_FACTORY,
    MCU_WIFI_ERROR_ID,
    MCU_BLE_CONFIG_DUMP,
    MCU_BLE_CONFIG_SET,
    MCU_WIFI_TIME
} mcu2wifi_cmd,
    wifi2mcu_cmd;

 bool flag_mode_changed;
 uchar commu_wifi_flag;
 static uchar mcu2wifi_txd[BUFF_LEN], mcu2wifi_rxd[BUFF_LEN], ack_str[BUFF_LEN] = {0};
 static uchar commu_mcu2wifi_cnt;
 static uchar command_mcu2wifi_size;
 static uchar cnt_mcu2wifi_tra2, cnt_mcu2wifi_rec2;
 static uchar transmit_delay;
static volatile bool recvorder;
 uint button_id;
 ulong server_time;

 euint user_time_minute;  //running time count in minute
 euchar user_time_second; //running time count in sencod
euint user_distance;           //running distance integral,in 0.01km
eulong user_calories;          //running calories integral,in 0.1km

 net_state_t net_state;
 struct_mp_t store_mp;
 struct_point_t store_point;

static const uchar code MODEL[] = "model";
static const uchar code MODEL_NAME[] = "ksmb.walkingpad.v1";

const uchar code FW_VERSION[] = "0043";

static const uchar code OK[] = "ok";

static void process_net_state(const char *str)
{
    if (START_WITH(str, "offline"))
        net_state = NET_STATE_OFFLINE;
    else if (START_WITH(str, "local"))
        net_state = NET_STATE_LOCAL;
    else if (START_WITH(str, "cloud"))
        net_state = NET_STATE_CLOUD;
    else if (START_WITH(str, "updating"))
        net_state = NET_STATE_UPDATING;
    else if (START_WITH(str, "uap"))
        net_state = NET_STATE_UAP;
    else if (START_WITH(str, "unprov"))
        net_state = NET_STATE_UNPROV;
}

static uchar parse_speed(uchar *ptr)
{
    int temp;
    if (ptr[0] == '"')
        ptr += 1;

    temp = atoi(ptr);
    temp *= 10;
    ptr = strchr(ptr, '.');
    if (ptr != 0 && isdigit(ptr[1]))
    {
        temp += ptr[1] - '0';
        if (ptr[2] >= '5' && ptr[2] <= '9')
            temp++;
    }

    if (temp < 0)
        temp = 0;

    return (uchar)(temp * 3);
}

static void clear_offline_data(void)
{
    store_point.offline_dist = 0;
    store_point.offline_energy = 0;
    store_point.offline_steps = 0;
    store_point.offline_time = 0;
    eeprom_write_int(EEPROM_ADDR_OFFLINE_DIST, 0);
    eeprom_write_long(EEPROM_ADDR_OFFLINE_ENERGY, 0);
    eeprom_write_int(EEPROM_ADDR_OFFLINE_STEPS, 0);
    eeprom_write_int(EEPROM_ADDR_OFFLINE_TIME, 0);
}

static char *append_str(char *ptr, const char *str)
{
    return ptr + sprintf(ptr, "\"%s\" ", str);
}

static char *append_int(char *str, const uint n)
{
    return str + sprintf(str, "%d ", n);
}

static char *append_long(char *str, const ulong n)
{
    return str + sprintf(str, "%ld ", n);
}

static char *append_speed(char *str, const uchar sp)
{
    return str + sprintf(str, "%d.%d ", (uint)sp / 30, ((uint)sp % 30) / 3);
}

static ulong get_store_time(void)
{
    static ulong store_time;
    ulong temp = server_time + clock() / CLOCKS_PER_SEC;
    if (temp > store_time)
        store_time = temp;
    else
        store_time++;
    return store_time;
}

#ifdef MIwifi
void commu_wifi(void)
{
    static uchar props_time_second;
    static uchar props_mode;
    static uchar props_speed;
    static uint props_dist;
    static uint props_step;
    static int error_code;
    int temp;
    uchar *ptr0;
    char *ptr1;
    uchar *ptr2;
     eulong user_total_distance;
     extern display_seg_t display_seg;
    //  ebool flag_motor_params_changed;
     euchar error_id;
     extern clock_t error_time;
     extern user_state_t userstate;

    if (commu_mcu2wifi_state == COMMU_STATE_MCU2WIFI_TRANSMIT)
    {
        if (has_wifi_flag(FLAG_WIFI_RESTORE))
            mcu2wifi_cmd = MCU_WIFI_RESTORE;
        else if (has_wifi_flag(FLAG_WIFI_FACTORY))
            mcu2wifi_cmd = MCU_WIFI_FACTORY;
        else if (mcu2wifi_cmd == MCU_WIFI_NO_COMMAND)
        {
            if (has_wifi_flag(FLAG_WIFI_ERROR_ID))
            {
                clear_wifi_flag(FLAG_WIFI_ERROR_ID);
                mcu2wifi_cmd = MCU_WIFI_ERROR_ID;
            }
            else if (has_wifi_flag(FLAG_WIFI_STORE_OFFLINE))
            {
                set_wifi_flag(FLAG_WIFI_STORE_POINT);
                mcu2wifi_cmd = MCU_WIFI_STORE_OFFLINE;
            }
            else if (has_wifi_flag(FLAG_WIFI_STORE_POINT))
            {
                // clear_wifi_flag(FLAG_WIFI_STORE_POINT);
                mcu2wifi_cmd = MCU_WIFI_STORE_POINT;
            }
            else if (has_wifi_flag(FLAG_WIFI_STORE_MP))
            {
                clear_wifi_flag(FLAG_WIFI_STORE_MP);
                mcu2wifi_cmd = MCU_WIFI_STORE_MP;
            }
            else if (net_state == NET_STATE_UNKNOWN)
            {
                mcu2wifi_cmd = MCU_WIFI_NET;
            }
            else if ((props_time_second != user_time_second || props_speed != machine_speed_target || props_mode != runmode) && net_state == NET_STATE_CLOUD)
            {
                mcu2wifi_cmd = MCU_WIFI_PROPS;
            }
            else if (net_state == NET_STATE_CLOUD && (!IS_TIME_SET || has_wifi_flag(FLAG_WIFI_SET_TIME)))
            {
                clear_wifi_flag(FLAG_WIFI_SET_TIME);
                mcu2wifi_cmd = MCU_WIFI_TIME;
            }
            else
            {
                transmit_delay++;
                if (transmit_delay > 24)
                {
                    transmit_delay = 0;
                    mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
                }
                else
                    return;
            }
        }
        else
        {
            transmit_delay = 0;
        }

        if (wifi2mcu_cmd == MCU_WIFI_NO_COMMAND)
        {
            mcu2wifi_txd[0] = '\0';
            switch (mcu2wifi_cmd)
            {
            case MCU_WIFI_GET_DOWN:
                strcpy(mcu2wifi_txd, "get_down");
                break;
            case MCU_WIFI_RESULT:
                //sprintf(mcu2wifi_txd, "result %s", ack_str[0] == '\0' ? "\"ok\"" : ack_str);
                if(ack_str[0] == '\0') sprintf(mcu2wifi_txd, "result %s", "\"ok\"");
                else sprintf(mcu2wifi_txd, "result %s", ack_str);
                break;
            case MCU_WIFI_PROPS:
                ptr0 = mcu2wifi_txd + sprintf(mcu2wifi_txd, "props ");
                if (user_time_second != props_time_second)
                {
                    props_time_second = user_time_second;
                    ptr0 += sprintf(ptr0, "time %d ", user_time_minute * 60 + user_time_second);
                }
                if (machine_speed_target != props_speed)
                {
                    if (machine_speed_target == 0 || props_speed == 0)
                    {
                        ptr0 += sprintf(ptr0, "state \"%s\" ", machine_speed_target > 0 ? "run" : "stop");
                    }
                    props_speed = machine_speed_target;
                    ptr0 += sprintf(ptr0, "speed ");
                    ptr0 = append_speed(ptr0, machine_speed_target);
                }
                if (runmode != props_mode)
                {
                    if (runmode == RUN_MODE_STANDBY || props_mode == RUN_MODE_STANDBY)
                    {
                        ptr0 += sprintf(ptr0, "power \"%s\" ", runmode == RUN_MODE_STANDBY ? "off" : "on");
                    }
                    props_mode = runmode;
                    ptr0 += sprintf(ptr0, "mode %d type \"%s\" ", (uint)runmode, runmode == RUN_MODE_FIXED ? "fixed" : "auto");
                }
                if (user_distance != props_dist)
                {
                    props_dist = user_distance;
                    ptr0 += sprintf(ptr0, "dist %ld cal %ld ", (ulong)user_distance * 10, user_calories * 10);
                }
                if (user_steps_total != props_step)
                {
                    props_step = user_steps_total;
                    ptr0 += sprintf(ptr0, "step %d ", user_steps_total);
                }
                break;
            case MCU_WIFI_STORE_MP:
                sprintf(mcu2wifi_txd, "store mp %d %d %d", store_mp.dur, store_mp.km, store_mp.time);
                break;
            case MCU_WIFI_STORE_POINT:
                sprintf(mcu2wifi_txd, "store point \"_override_time\" %ld %d %d %d %d %d %d %d %d %d", get_store_time(), store_point.dist, store_point.predist, store_point.preenergy, store_point.steps, store_point.presteps, store_point.time, store_point.pretime, (uint)store_point.presp, store_point.state);
                break;
            case MCU_WIFI_STORE_OFFLINE:
                sprintf(mcu2wifi_txd, "store point \"_override_time\" %ld %d %d %ld %d %d %d %d %d %d", get_store_time(), store_point.offline_dist, store_point.offline_dist, store_point.offline_energy, store_point.offline_steps, store_point.offline_steps, store_point.offline_time, store_point.offline_time, 0, 0);
                clear_offline_data();
                break;
            case MCU_WIFI_MODEL_QUERY:
                strcpy(mcu2wifi_txd, MODEL);
                break;
            case MCU_WIFI_MODEL_SETTING:
                sprintf(mcu2wifi_txd, "%s %s", MODEL, MODEL_NAME);
                break;
            case MCU_WIFI_VERSION:
                sprintf(mcu2wifi_txd, "mcu_version %s", FW_VERSION);
                break;
            case MCU_WIFI_RESTORE:
                strcpy(mcu2wifi_txd, "restore");
                break;
            case MCU_WIFI_ERROR:
                if (error_code == -5001)
                    ptr0 = "command";
                else
                    ptr0 = "error";
                sprintf(mcu2wifi_txd, "error \"unknown %s\" %d", ptr0, error_code);
                error_code = 0;
                break;
            case MCU_WIFI_NET:
                strcpy(mcu2wifi_txd, "net");
                break;
            case MCU_WIFI_FACTORY:
                strcpy(mcu2wifi_txd, "factory");
                break;
            case MCU_WIFI_ERROR_ID:
                sprintf(mcu2wifi_txd, "event error %d", (uint)error_id);
                break;
            case MCU_BLE_CONFIG_DUMP:
                strcpy(mcu2wifi_txd, "ble_config dump");
                break;
            case MCU_BLE_CONFIG_SET:
                sprintf(mcu2wifi_txd, "ble_config set 331 %s", FW_VERSION);
                break;
            case MCU_WIFI_TIME:
                strcpy(mcu2wifi_txd, "time posix");
                break;
            default: //error
                break;
            }

            commu_mcu2wifi_state = COMMU_STATE_MCU2WIFI_RECEIVE; //switch to receive
            command_mcu2wifi_size = (uchar)strlen(mcu2wifi_txd);
            mcu2wifi_txd[command_mcu2wifi_size++] = '\r';
            wifi2mcu_cmd = mcu2wifi_cmd;
            mcu2wifi_cmd = MCU_WIFI_NO_COMMAND;
            //txd enable
            cnt_mcu2wifi_tra2=0;
            SBUF = mcu2wifi_txd[cnt_mcu2wifi_tra2++];
        }
    }
    else if (commu_mcu2wifi_state == COMMU_STATE_MCU2WIFI_RECEIVE)
    {
        if (recvorder == 1)
        {
            transmit_delay = 0;
            recvorder = 0;
            switch (wifi2mcu_cmd)
            {
            case MCU_WIFI_GET_DOWN:
                ack_str[0] = '\0';
                if (START_WITH(mcu2wifi_rxd, "down"))
                {
                    ptr0 = mcu2wifi_rxd + 5;

                    if (START_WITH(ptr0, "none")) //
                    {
                        break;
                    }
                    else if (START_WITH(ptr0, "get_prop"))
                    {
                        for (ptr0 += sizeof("get_prop") - 1 + 2, ptr1 = ack_str, ptr2 = ptr0 + strlen(ptr0); ptr0 < ptr2;)
                        {
                            if (START_WITH(ptr0, "mode"))
                            {
                                ptr0 += 7; // strlen("mode\",\"")
                                ptr1 = append_int(ptr1, runmode);
                            }
                            else if (START_WITH(ptr0, "time"))
                            {
                                ptr0 += 7;
                                ptr1 = append_int(ptr1, user_time_minute * 60u + user_time_second);
                            }
                            else if (START_WITH(ptr0, "sp"))
                            {
                                if (START_WITH(ptr0, "speed"))
                                    ptr0 += 8;
                                else
                                    ptr0 += 5;
                                if (runmode == RUN_MODE_AUTO || machine_speed_target == 0 || tutorial_state >= TUTORIAL_STEP3_BEGIN)
                                {
                                    temp = machine_speed_target;
                                }
                                else
                                {
                                    temp = fixed_mode_speed;
                                }
                                ptr1 = append_speed(ptr1, temp);
                            }
                            else if (START_WITH(ptr0, "dist"))
                            {
                                ptr0 += 7;
                                ptr1 = append_long(ptr1, (ulong)user_distance * 10);
                            }
                            else if (START_WITH(ptr0, "cal"))
                            {
                                ptr0 += 6;
                                ptr1 = append_long(ptr1, user_calories * 10);
                            }
                            else if (START_WITH(ptr0, "step"))
                            {
                                ptr0 += 7;
                                ptr1 = append_int(ptr1, user_steps_total);
                            }
                            else if (START_WITH(ptr0, "all"))
                            {
                                sprintf(ack_str, "\"mode:%d\",\"time:%d\",\"sp:%d.%d\",\"dist:%ld\",\"cal:%ld\",\"step:%d\"",
                                        (uint)runmode,
                                        user_time_minute * 60 + user_time_second,
                                        (uint)machine_speed_target / 30,
                                        (uint)(machine_speed_target % 30) / 3,
                                        (ulong)user_distance * 10,
                                        user_calories * 10,
                                        user_steps_total);
                                break;
                            }
                            else if (START_WITH(ptr0, "button_id"))
                            {
                                ptr0 += 12;
                                ptr1 = append_int(ptr1, button_id);
                                button_id = KEY_NONE;
                            }
                            else if (START_WITH(ptr0, "start_speed"))
                            {
                                ptr0 += 14;
                                ptr1 = append_speed(ptr1, fixed_start_speed);
                            }
                            else if (START_WITH(ptr0, "goal"))
                            {
                                ptr0 += 7;
                                ptr1 = append_int(ptr1, goal_type);
                                ptr1 = append_int(ptr1, goal_value);
                            }
                            else if (START_WITH(ptr0, "max"))
                            {
                                ptr0 += 6;
                                ptr1 = append_speed(ptr1, speed_limit_max);
                            }
                            else if (START_WITH(ptr0, "sensitivity"))
                            {
                                ptr0 += 14;
                                ptr1 = append_int(ptr1, acceleration_param);
                            }
                            else if (START_WITH(ptr0, "error_id"))
                            {
                                ptr0 += 11;
                                ptr1 = append_int(ptr1, error_id);
                            }
                            else if (START_WITH(ptr0, "log"))
                            {
                                sprintf(ack_str, "\"{%d,%d,%ld,%ld,%ld,%ld,%d,%d,%d,%ld}\"\r",
                                        (uint)user_speed_target,
                                        (uint)machine_speed_target,
                                        tension,
                                        tension2,
                                        tension_bias,
                                        tension2_bias,
                                        user_request & 0xff,
                                        machine_current_motor,
                                        machine_volt_motor,
                                        user_total_distance);
                                break;
                            } /*
                            else if (START_WITH(ptr0, "s0"))
                            {
                                ptr0 += 5;
                                ptr1 += sprintf(ptr1, "%ld ", tension_bias);
                            }
                            else if (START_WITH(ptr0, "s1"))
                            {
                                ptr0 += 5;
                                ptr1 += sprintf(ptr1, "%ld ", tension2_bias);
                            }
                            else if (START_WITH(ptr0, "current"))
                            {
                                ptr0 += 10;
                                ptr1 += sprintf(ptr1, "%d ", (uint)machine_current_motor);
                            }
                            else if (START_WITH(ptr0, "volt"))
                            {
                                ptr0 += 7;
                                ptr1 += sprintf(ptr1, "%d ", (uint)machine_volt_motor);
                            }
                            else if (START_WITH(ptr0, "total_dist"))
                            {
                                ptr0 += 13;
                                ptr1 += sprintf(ptr1, "%ld ", user_total_distance);
                            }
                            else if (START_WITH(ptr0, "rating_volt"))
                            {
                                ptr0 += 14;
                                ptr1 += sprintf(ptr1, "%d ", (uint)dc_motor_rating_volt);
                            }
                            else if (START_WITH(ptr0, "rating_f1"))
                            {
                                ptr0 += 12;
                                ptr1 += sprintf(ptr1, "%d ", (uint)dc_motor_rating_f1);
                            }
                            else if (START_WITH(ptr0, "startup_volt"))
                            {
                                ptr0 += 15;
                                ptr1 += sprintf(ptr1, "%d ", (uint)dc_motor_startup_volt);
                            }*/
                            else if (START_WITH(ptr0, "auto"))
                            {
                                ptr0 += 7;
                                ptr1 = append_int(ptr1, flag_auto);
                            }
                            else if (START_WITH(ptr0, "disp"))
                            {
                                ptr0 += 7;
                                ptr1 = append_int(ptr1, flag_disp);
                            }
                            else if (START_WITH(ptr0, "initial"))
                            {
                                ptr0 += 10;
                                ptr1 = append_int(ptr1, eeprom_rdchar(EEPROM_ADDR_INSURE_BINDED) | (eeprom_rdchar(EEPROM_ADDR_TUTORIAL_FINISH) << 1));
                            }
                            else if (START_WITH(ptr0, "lock"))
                            {
                                ptr0 += 7;
                                ptr1 = append_int(ptr1, eeprom_rdchar(EEPROM_ADDR_RUNMODE) == RUN_MODE_LOCK);
                            }
                            else if (START_WITH(ptr0, "offline"))
                            {
                                ptr0 += 11;
                                ptr1 = append_int(ptr1, store_point.offline_dist);
                            }
                            else if (START_WITH(ptr0, "userstate"))
                            {
                                ptr0 += 12;
                                ptr1 = append_int(ptr1, userstate);
                            }
                            else if (START_WITH(ptr0, "type"))
                            {
                                ptr0 += 7;
                                ptr1 = append_str(ptr1, runmode == RUN_MODE_FIXED ? "fixed" : "auto");
                            }
                            else if (START_WITH(ptr0, "state"))
                            {
                                ptr0 += 8;
                                ptr1 = append_str(ptr1, machine_speed_target == 0 ? "stop" : "run");
                            }
                            else if (START_WITH(ptr0, "power"))
                            {
                                ptr0 += 8;
                                ptr1 = append_str(ptr1, runmode == RUN_MODE_STANDBY ? "off" : "on");
                            }
                            else
                            {
                                ptr1 += sprintf(ptr1, "-1");
                                break;
                            }
                        }
                    }
                    else if (START_WITH(ptr0, "set_"))
                    {
                        ptr0 += sizeof("set_") - 1;
                        if (START_WITH(ptr0, "mode"))
                        {
                            ptr0 += sizeof("mode") - 1 + 1;
                            temp = ptr0[0] - '0';
                            if (temp != runmode &&
                                temp >= RUN_MODE_AUTO &&
                                temp <= RUN_MODE_NEW)
                            {
                                if (eeprom_rdchar(EEPROM_ADDR_RUNMODE) != RUN_MODE_LOCK || temp == RUN_MODE_STANDBY)
                                    runmode = temp;
                                else
                                    runmode = RUN_MODE_LOCK;
                                flag_mode_changed = 1;
                                beep(BEEP_KEY);
                                if (runmode == RUN_MODE_NEW)
                                    tutorial_state = TUTORIAL_BEGIN;
                            }

                            append_int(ack_str, runmode);
                        }
                        else if (START_WITH(ptr0, "speed"))
                        {
                            display_seg = DISPLAY_SPEED_TEMP;

                            ptr0 += sizeof("speed") - 1 + 1;
                            fixed_mode_speed = parse_speed(ptr0);
                            if (fixed_mode_speed == 0 && runmode == RUN_MODE_AUTO)
                                stepdown_flag = STEPDOWN_STOP;
                            else if (fixed_mode_speed > speed_limit_max)
                            {
                                fixed_mode_speed = speed_limit_max;
                                display_seg = DISPLAY_LIMIT;
                            }
                            // if (fixed_mode_speed > 0)
                            //     eeprom_wrchar(EEPROM_ADDR_FIXED_SPEED, fixed_mode_speed);

                            append_speed(ack_str, fixed_mode_speed);
                            beep(BEEP_KEY);
                        }
                        else if (START_WITH(ptr0, "type"))
                        {
                            ptr0 += sizeof("type") + 1;
                            if (runmode == RUN_MODE_LOCK)
                            {
                            }
                            else if (runmode == RUN_MODE_STANDBY && eeprom_rdchar(EEPROM_ADDR_RUNMODE) == RUN_MODE_LOCK)
                            {
                                runmode = RUN_MODE_LOCK;
                                beep(BEEP_KEY);
                            }
                            else if (START_WITH(ptr0, "auto"))
                            {
                                if (runmode != RUN_MODE_AUTO)
                                {
                                    runmode = RUN_MODE_AUTO;
                                    flag_mode_changed = 1;
                                    beep(BEEP_KEY);
                                }
                            }
                            else if (START_WITH(ptr0, "fixed"))
                            {
                                if (runmode != RUN_MODE_FIXED)
                                {
                                    runmode = RUN_MODE_FIXED;
                                    flag_mode_changed = 1;
                                    beep(BEEP_KEY);
                                }
                            }
                            else
                                error_code = -5001;
                        }
                        else if (START_WITH(ptr0, "state"))
                        {
                            ptr0 += sizeof("state") + 1;
                            if (START_WITH(ptr0, "stop"))
                            {
                                if (userstate != USER_STATE_SLEEP)
                                {
                                    stepdown_flag = STEPDOWN_STOP;
                                    beep(BEEP_KEY);
                                }
                            }
                            else if (START_WITH(ptr0, "run"))
                            {
                                if (userstate == USER_STATE_READY)
                                {
                                    stepdown_flag = STEPDOWN_START;
                                    beep(BEEP_KEY);
                                }
                            }
                            else
                                error_code = -5001;
                        }
                        else if (START_WITH(ptr0, "power"))
                        {
                            ptr0 += sizeof("power") + 1;
                            if (START_WITH(ptr0, "on"))
                            {
                                if (runmode == RUN_MODE_STANDBY)
                                {
                                    key_id = KEY_MODE_PRESS;
                                    key_id_done = 0;
                                }
                            }
                            else if (START_WITH(ptr0, "off"))
                            {
                                if (runmode != RUN_MODE_STANDBY)
                                {
                                    runmode = RUN_MODE_STANDBY;
                                    beep(BEEP_KEY);
                                }
                            }
                            else
                                error_code = -5001;
                        }
                        else if (START_WITH(ptr0, "max"))
                        {
                            ptr0 += sizeof("max") - 1 + 1;
                            speed_limit_max = parse_speed(ptr0);
                            if (speed_limit_max > SPEED_TARGET_MAX)
                                speed_limit_max = SPEED_TARGET_MAX;
                            else if (speed_limit_max < SPEED_TARGET_MIN1)
                                speed_limit_max = SPEED_TARGET_MIN1;
                            append_speed(ack_str, speed_limit_max);
                            eeprom_wrchar(EEPROM_ADDR_SPEED_LIMIT, speed_limit_max);
                            if (fixed_start_speed > speed_limit_max)
                            {
                                fixed_start_speed = speed_limit_max;
                                eeprom_wrchar(EEPROM_ADDR_FIXED_SPEED, temp);
                            }
                            if (max_speed_unlocked == 0)
                            {
                                max_speed_unlocked = 1;
                                eeprom_wrchar(EEPROM_ADDR_MAX_SPEED_UNLOCKED, 1);
                            }
                            display_seg = DISPLAY_LIMIT;
                            beep(BEEP_KEY);
                        }
                        else if (START_WITH(ptr0, "sensitivity"))
                        {
                            ptr0 += sizeof("sensitivity") - 1 + 1;
                            temp = atoi(ptr0);
                            if (temp >= 1 && temp <= 3)
                            {
                                acceleration_param = (uchar)temp;
                            }
                            append_int(ack_str, acceleration_param);
                            eeprom_wrchar(EEPROM_ADDR_ACC_PARAM, acceleration_param);
                            beep(BEEP_KEY);
                        }
                        else if (START_WITH(ptr0, "cali"))
                        {
                            ptr0 += sizeof("cali");
                            temp = atoi(ptr0);
                            if (temp == 1)
                            {
                                key_id = KEY_MODE_UP_LONG_PRESS;
                                key_id_done = 0;
                            }
                            else if (temp == 0 && runmode == RUN_MODE_CHECK)
                            {
                                stepdown_flag = STEPDOWN_STOP;
                                beep(BEEP_KEY);
                            }
                            append_int(ack_str, temp);
                        }
                        else if (START_WITH(ptr0, "goal"))
                        {
                            ptr0 += sizeof("goal");
                            if (ptr0[0] >= '0' && ptr0[0] <= '2' && ptr0[1] == ',')
                            {
                                temp = ptr0[0] - '0';
                                if (goal_type != temp)
                                {
                                    goal_type = temp;
                                    eeprom_wrchar(EEPROM_ADDR_GOAL_TYPE, goal_type);
                                    goal_status = GOAL_CHANGED;
                                }
                                temp = atoi(ptr0 + 2);
                                if (goal_value != temp)
                                {
                                    goal_value = temp;
                                    eeprom_write_int(EEPROM_ADDR_GOAL_VALUE, goal_value);
                                    goal_status = GOAL_CHANGED;
                                }
                            }
                            sprintf(ack_str, "%d %d", (uint)goal_type, goal_value);
                            beep(BEEP_KEY);
                        }
                        else if (START_WITH(ptr0, "start_speed"))
                        {
                            ptr0 += sizeof("start_speed");
                            temp = parse_speed(ptr0);
                            if (temp <= SPEED_TARGET_MAX && temp >= SPEED_TARGET_MIN1 && temp != fixed_start_speed)
                            {
                                if (temp > speed_limit_max)
                                {
                                    temp = speed_limit_max;
                                    display_seg = DISPLAY_LIMIT;
                                }
                                fixed_start_speed = temp;
                                eeprom_wrchar(EEPROM_ADDR_FIXED_SPEED, temp);
                            }
                            append_speed(ack_str, fixed_start_speed);
                            beep(BEEP_KEY);
                        }
                        /*else if (START_WITH(ptr0, "rating_volt"))
                        {
                            ptr0 += sizeof("rating_volt") - 1 + 1;
                            temp = atoi(ptr0);
                            if (temp < DC_MOTOR_RATING_VOLT_MIN || temp > DC_MOTOR_RATING_VOLT_MAX)
                            {
                                dc_motor_rating_volt = DC_MOTOR_RATING_VOLT_DEFAULT;
                            }
                            else
                            {
                                dc_motor_rating_volt = temp;
                            }
                            eeprom_wrchar(EEPROM_ADDR_RATING_VOLT, dc_motor_rating_volt);
                            sprintf(ack_str, "%d", (uint)dc_motor_rating_volt);
                            flag_motor_params_changed = 1;
                        }*/
                        else if (START_WITH(ptr0, "auto"))
                        {
                            ptr0 += sizeof("auto") - 1 + 1;
                            temp = ptr0[0] - '0';
                            if (temp >= 0 && temp <= 1 && temp != flag_auto)
                            {
                                flag_auto = temp;
                                eeprom_wrchar(EEPROM_ADDR_AUTO, temp);
                            }
                            append_int(ack_str, flag_auto);
                            beep(BEEP_KEY);
                        }
                        else if (START_WITH(ptr0, "disp"))
                        {
                            ptr0 += sizeof("disp") - 1 + 1;
                            temp = atoi(ptr0);
                            if (temp > 0 && temp <= 0x1F && temp != flag_disp)
                            {
                                flag_disp = (uchar)temp;
                                eeprom_wrchar(EEPROM_ADDR_DISP, flag_disp);
                            }
                            append_int(ack_str, flag_disp);
                            beep(BEEP_KEY);
                        }
                        else if (START_WITH(ptr0, "insure"))
                        {
                            ptr0 += sizeof("insure") - 1 + 1;
                            temp = ptr0[0] - '0';
                            if (temp == 1)
                            {
                                eeprom_wrchar(EEPROM_ADDR_INSURE_BINDED, temp);
                            }
                            append_int(ack_str, temp);
                        }
                        else if (START_WITH(ptr0, "lock"))
                        {
                            ptr0 += sizeof("lock") - 1 + 1;
                            if (machine_speed_target == 0)
                            {
                                temp = ptr0[0] - '0';
                                runmode = temp == 1 ? RUN_MODE_LOCK : RUN_MODE_FIXED;
                                flag_mode_changed = 1;
                            }
                            append_int(ack_str, runmode == RUN_MODE_LOCK);
                            beep(BEEP_KEY);
                        }
                        else if (START_WITH(ptr0, "offline"))
                        {
                            ptr0 += sizeof("offline") - 1 + 1;
                            temp = ptr0[0] - '0';
                            if (temp == 0)
                            {
                                clear_offline_data();
                            }
                            else if (store_point.offline_dist > 0)
                            {
                                set_wifi_flag(FLAG_WIFI_STORE_OFFLINE);
                            }
                            append_int(ack_str, temp);
                            beep(BEEP_KEY);
                        }
                        else
                        {
                            error_code = -5001;
                        }
                    }
                    else if (START_WITH(ptr0, "speed"))
                    {
                        ptr0 += sizeof("speed"); // speed_up, speed_down
                        if (START_WITH(ptr0, "up"))
                        {
                            key_id = KEY_UP_PRESS;
                            key_id_done = 0;
                        }
                        else if (START_WITH(ptr0, "down"))
                        {
                            key_id = KEY_DOWN_PRESS;
                            key_id_done = 0;
                        }
                    }
                    else if (START_WITH(ptr0, "tutorial"))
                    {
                        ptr0 += sizeof("tutorial") - 1 + 1;
                        temp = atoi(ptr0);
                        if (temp >= TUTORIAL_BEGIN && temp <= TUTORIAL_FINISH)
                            tutorial_state = temp;
                        append_int(ack_str, tutorial_state);
                    }
                    else if (START_WITH(ptr0, "MIIO_mcu_version_req"))
                    {
                        mcu2wifi_cmd = MCU_WIFI_VERSION;
                        break;
                    }
                    else if (START_WITH(ptr0, "MIIO_model_req"))
                    {
                        mcu2wifi_cmd = MCU_WIFI_MODEL_SETTING;
                        break;
                    }
                    else if (START_WITH(ptr0, "MIIO_net_change"))
                    {
                        ptr0 += sizeof("MIIO_net_change") - 1 + 1;
                        process_net_state(ptr0);
                        break;
                    }
                    else if (START_WITH(ptr0, "update_fw"))
                    {
                        if (machine_speed_target > 0)
                            break;
                        eeprom_wrchar(EEPROM_ADDR_FLAG_UPDATE, 1);
                        disp_matrix_all(0x00);
                        disp_text_up("UPDA");
                        disp_text_down("TING");
                        DisplayDriverProcessLED();
                        //WWDG->CR |= 0x80;
                        //WWDG->CR &= (uchar)~0x40;
                     	IAP_CMD=0xF00F;		//命令寄存器---解锁
                     	IAP_CMD=0x7887;		//命令寄存器---重读代码选项
                    }
                    else
                    {
                        error_code = -5001;
                    }
                    mcu2wifi_cmd = error_code == 0 ? MCU_WIFI_RESULT : MCU_WIFI_ERROR;
                }
                else if (START_WITH(mcu2wifi_rxd, "error"))
                {
                }
                break;
            case MCU_WIFI_STORE_POINT:
                clear_wifi_flag(FLAG_WIFI_STORE_POINT);
            case MCU_WIFI_RESULT:
            case MCU_WIFI_PROPS:
            case MCU_WIFI_STORE_MP:
            case MCU_WIFI_ERROR_ID:
                if (START_WITH(mcu2wifi_rxd, OK))
                    mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
                break;
            case MCU_WIFI_STORE_OFFLINE:
                clear_wifi_flag(FLAG_WIFI_STORE_POINT);
                clear_wifi_flag(FLAG_WIFI_STORE_OFFLINE);
                mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
                break;
            case MCU_WIFI_MODEL_QUERY:
                if (START_WITH(mcu2wifi_rxd, MODEL_NAME))
                    mcu2wifi_cmd = MCU_WIFI_VERSION;
                else
                    mcu2wifi_cmd = MCU_WIFI_MODEL_SETTING;
                break;
            case MCU_WIFI_MODEL_SETTING:
                if (START_WITH(mcu2wifi_rxd, OK))
                    mcu2wifi_cmd = MCU_WIFI_VERSION;
                else
                    mcu2wifi_cmd = MCU_WIFI_MODEL_SETTING;
                break;
            case MCU_WIFI_VERSION:
                if (START_WITH(mcu2wifi_rxd, OK))
                    mcu2wifi_cmd = MCU_BLE_CONFIG_DUMP;
                else
                    mcu2wifi_cmd = MCU_WIFI_VERSION;
                break;
            case MCU_WIFI_RESTORE:
                if (START_WITH(mcu2wifi_rxd, OK))
                {
                    clear_wifi_flag(FLAG_WIFI_RESTORE);
                    net_state = NET_STATE_UNKNOWN;
                    mcu2wifi_cmd = MCU_BLE_CONFIG_DUMP;
                }
                else
                    mcu2wifi_cmd = MCU_WIFI_RESTORE;
                break;
            case MCU_WIFI_NET:
                process_net_state(mcu2wifi_rxd);
                break;
            case MCU_WIFI_FACTORY:
                //if (START_WITH(mcu2wifi_rxd, OK))
                {
                    clear_wifi_flag(FLAG_WIFI_FACTORY);
                    mcu2wifi_cmd = MCU_WIFI_NET;
                }
                break;
            case MCU_BLE_CONFIG_DUMP:
                if (START_WITH(mcu2wifi_rxd, "[\"product id\":331,")) // ["product id":331,"version":1.5.1_0015]
                {
                    ptr0 = strstr(mcu2wifi_rxd, FW_VERSION);
                    if (ptr0 != NULL)
                    {
                        mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
                        break;
                    }
                }
                mcu2wifi_cmd = MCU_BLE_CONFIG_SET;
                break;
            case MCU_BLE_CONFIG_SET:
                if (START_WITH(mcu2wifi_rxd, OK))
                    mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
                else
                    mcu2wifi_cmd = MCU_BLE_CONFIG_SET;
            case MCU_WIFI_TIME:
                server_time = atol(mcu2wifi_rxd);
                if (server_time > 1517212762ul)
                {
                    server_time -= clock() / CLOCKS_PER_SEC;
                    if (error_id == 0)
                    {
                        error_id = eeprom_rdchar(EEPROM_ADDR_ERROR_ID);
                        if (error_id > 0)
                        {
                            error_time = eeprom_read_long(EEPROM_ADDR_ERROR_TIME);
                            mcu2wifi_cmd = MCU_WIFI_ERROR_ID;
                            break;
                        }
                    }
                }
                else
                {
                    server_time = 0;
                }
                mcu2wifi_cmd = MCU_WIFI_GET_DOWN;
            default:
                break;
            }

            wifi2mcu_cmd = MCU_WIFI_NO_COMMAND;
            commu_mcu2wifi_state = COMMU_STATE_MCU2WIFI_TRANSMIT; //switch to transmit
            commu_mcu2wifi_cnt = 0;
        }
        else
        {
            if (commu_mcu2wifi_cnt >= WAIT_WIFI_FEEDBACK_TIME) //when no feedback for 0.3s, go to transmit state
            {
                commu_mcu2wifi_state = COMMU_STATE_MCU2WIFI_TRANSMIT;
                mcu2wifi_cmd = wifi2mcu_cmd;
                wifi2mcu_cmd = MCU_WIFI_NO_COMMAND;
                commu_mcu2wifi_cnt = 0;
            }
            else
            {
                commu_mcu2wifi_cnt++; //in 20ms
            }
        }
    }
    else
    {
        if (waiting == 0)
        {
            transmit_delay = 0;
            commu_mcu2wifi_state = COMMU_STATE_MCU2WIFI_TRANSMIT;
            mcu2wifi_cmd = MCU_WIFI_MODEL_QUERY;
        }
    }
}

#else
void commu_uart(void)
{
    if (cnt_mcu2wifi_tra2 == 0)
    {
        sprintf(mcu2wifi_txd, "{%d,\t%d,\t%ld,\t%ld,\t%ld,\t%ld,\t%d,\t%d,\t%d,\t%ld}\r\n",
                (uint)user_speed_target,
                (uint)machine_speed_target,
                tension,
                tension2,
                //mean_value[0],
                //mean_value[1],
                tension_bias,
                tension2_bias,
                user_request & 0xff,
                //machine_current_motor & 0xff,
                //machine_volt_motor & 0xff,
                idx1 & 0xff,
                idx2 & 0xff,
                mean);
        command_mcu2wifi_size = (uchar)strlen(mcu2wifi_txd);
        //txd enable
        cnt_mcu2wifi_tra2=0;
        SBUF = mcu2wifi_txd[cnt_mcu2wifi_tra2++];             
    }
    else
    {
        beep(BEEP_KEY);
    }
} //commu_uart
#endif

void UART1_Rpt(void) interrupt UART1_VECTOR
{
   if (S1RI==1) 
   {
       mcu2wifi_rxd[cnt_mcu2wifi_rec2] = SBUF;
       if (mcu2wifi_rxd[cnt_mcu2wifi_rec2] == '\r')
       {
           mcu2wifi_rxd[cnt_mcu2wifi_rec2] = '\0';
           recvorder = 1;
           cnt_mcu2wifi_rec2 = 0;
       }
       else if (mcu2wifi_rxd[cnt_mcu2wifi_rec2] != '\0')
       {
           cnt_mcu2wifi_rec2++;
           if (cnt_mcu2wifi_rec2 >= BUFF_LEN)
           {
               cnt_mcu2wifi_rec2 = 0;
           }
       }
       S1RI = 0;      /* clear reception flag for next reception */				
   }
   if(S1TI==1)
   {
       if (cnt_mcu2wifi_tra2 < command_mcu2wifi_size)
       {
           SBUF = mcu2wifi_txd[cnt_mcu2wifi_tra2++];
       }
       else
       {
           cnt_mcu2wifi_tra2 = 0;
       }
       S1TI = 0;       /* if emission occur */
   }
}

