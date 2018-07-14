#ifndef __MIWIFI_H
#define __MIWIFI_H
#include "newtype.h"


#define FLAG_WIFI_RESTORE     ((uchar)1)
#define FLAG_WIFI_STORE_MP    ((uchar)2)
#define FLAG_WIFI_STORE_POINT ((uchar)4)
#define FLAG_WIFI_FACTORY     ((uchar)8)
#define FLAG_WIFI_ERROR_ID    ((uchar)16)
#define FLAG_WIFI_STORE_OFFLINE     ((uchar)32)
#define FLAG_WIFI_SET_TIME    ((uchar)64)

#define set_wifi_flag(flag)     commu_wifi_flag |= flag
#define clear_wifi_flag(flag)   commu_wifi_flag &= ~flag
#define has_wifi_flag(flag)     (commu_wifi_flag & flag)

@near euchar commu_wifi_flag;

typedef enum
{
    NET_STATE_UNKNOWN,
    NET_STATE_OFFLINE,     // 连接中(或掉线)
    NET_STATE_LOCAL,       // 连上路由器但未连上服务器
    NET_STATE_CLOUD,       // 连上小米云服务器
    NET_STATE_UPDATING,    // 固件升级中
    NET_STATE_UAP,         // uap模式等待连接
    NET_STATE_UNPROV       // 关闭wifi(一小时未快连)
} net_state_t;

@near extern net_state_t net_state;

typedef struct
{
    uint dur;
    uint km;
    uint time;
} struct_mp_t;

@near extern struct_mp_t store_mp;

typedef struct
{
    uint dist;
    uint predist;
    ulong energy;
    uint preenergy;
    uint steps;
    uint presteps;
    uint time;
    uint pretime;
    uchar presp;
    uint state;
    uint offline_dist;
    ulong offline_energy;
    uint offline_steps;
    uint offline_time;
} struct_point_t;

@near extern struct_point_t store_point;

@near ebool flag_mode_changed;

@near euint button_id;

@near eulong server_time;
#define IS_TIME_SET (server_time > 0)

void commu_wifi(void);
void commu_uart(void);

#endif