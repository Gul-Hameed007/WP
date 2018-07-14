# ST Visual Debugger Generated MAKE File, based on walkingpad_dev.stp

ifeq ($(CFG), )
CFG=Release
$(warning ***No configuration specified. Defaulting to $(CFG)***)
endif

ToolsetRoot=C:\CXSTM8
ToolsetBin=C:\CXSTM8
ToolsetInc=C:\CXSTM8\Hstm8
ToolsetLib=C:\CXSTM8\Lib
ToolsetIncOpts=-iC:\CXSTM8\Hstm8 
ToolsetLibOpts=-lC:\CXSTM8\Lib 
ObjectExt=o
OutputExt=elf
InputName=$(basename $(notdir $<))


# 
# Debug
# 
ifeq "$(CFG)" "Debug"


OutputPath=Debug
ProjectSFile=walkingpad_dev
TargetSName=$(ProjectSFile)
TargetFName=$(ProjectSFile).elf
IntermPath=$(dir $@)
CFLAGS_PRJ=$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -no -pp -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<
ASMFLAGS_PRJ=$(ToolsetBin)\castm8  -xx -l $(ToolsetIncOpts) -o$(IntermPath)$(InputName).$(ObjectExt) $<

all : $(OutputPath) $(ProjectSFile).elf

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Debug\speed.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\sensor.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\run_mode_new.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\run_auto.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\time.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\error.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\motion.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\program.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\control.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\factory.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\fan.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\key.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\rc.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\image.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\miwifi.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\beep.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\eeprom.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\commu.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\displaydriver.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\ini.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\main.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\stm8_interrupt_vector.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

Debug\uart_sim.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(ToolsetBin)\cxstm8  -ilib +warn +mods0 +debug -pxp -no -pp -v -l -dDEBUG -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<

$(ProjectSFile).elf :  $(OutputPath)\speed.o $(OutputPath)\sensor.o $(OutputPath)\run_mode_new.o $(OutputPath)\run_auto.o $(OutputPath)\time.o $(OutputPath)\error.o $(OutputPath)\motion.o $(OutputPath)\program.o $(OutputPath)\control.o $(OutputPath)\factory.o $(OutputPath)\fan.o $(OutputPath)\key.o $(OutputPath)\rc.o $(OutputPath)\image.o $(OutputPath)\miwifi.o $(OutputPath)\beep.o $(OutputPath)\eeprom.o $(OutputPath)\commu.o $(OutputPath)\displaydriver.o $(OutputPath)\ini.o $(OutputPath)\main.o $(OutputPath)\stm8_interrupt_vector.o $(OutputPath)\uart_sim.o $(OutputPath)\walkingpad_dev.lkf
	$(ToolsetBin)\clnk  $(ToolsetLibOpts) -o $(OutputPath)\$(TargetSName).sm8 -m$(OutputPath)\$(TargetSName).map $(OutputPath)\$(TargetSName).lkf 
	$(ToolsetBin)\cvdwarf  $(OutputPath)\$(TargetSName).sm8

	$(ToolsetBin)\chex  -fi -o $(OutputPath)\$(TargetSName)_debug.hex $(OutputPath)\$(TargetSName).sm8
	bin\srec_cat.exe  -Disable_Sequence_Warnings ..\STM8S005K_BootLoader\STVD\Cosmic\Release\stm8bootloader.hex -intel $(OutputPath)\$(TargetSName)_debug.hex -intel -o $(OutputPath)\walkingpad_all_debug.hex -intel
clean : 
	-@erase $(OutputPath)\speed.o
	-@erase $(OutputPath)\sensor.o
	-@erase $(OutputPath)\run_mode_new.o
	-@erase $(OutputPath)\run_auto.o
	-@erase $(OutputPath)\time.o
	-@erase $(OutputPath)\error.o
	-@erase $(OutputPath)\motion.o
	-@erase $(OutputPath)\program.o
	-@erase $(OutputPath)\control.o
	-@erase $(OutputPath)\factory.o
	-@erase $(OutputPath)\fan.o
	-@erase $(OutputPath)\key.o
	-@erase $(OutputPath)\rc.o
	-@erase $(OutputPath)\image.o
	-@erase $(OutputPath)\miwifi.o
	-@erase $(OutputPath)\beep.o
	-@erase $(OutputPath)\eeprom.o
	-@erase $(OutputPath)\commu.o
	-@erase $(OutputPath)\displaydriver.o
	-@erase $(OutputPath)\ini.o
	-@erase $(OutputPath)\main.o
	-@erase $(OutputPath)\stm8_interrupt_vector.o
	-@erase $(OutputPath)\uart_sim.o
	-@erase $(OutputPath)\walkingpad_dev.elf
	-@erase $(OutputPath)\speed.ls
	-@erase $(OutputPath)\sensor.ls
	-@erase $(OutputPath)\run_mode_new.ls
	-@erase $(OutputPath)\run_auto.ls
	-@erase $(OutputPath)\time.ls
	-@erase $(OutputPath)\error.ls
	-@erase $(OutputPath)\motion.ls
	-@erase $(OutputPath)\program.ls
	-@erase $(OutputPath)\control.ls
	-@erase $(OutputPath)\factory.ls
	-@erase $(OutputPath)\fan.ls
	-@erase $(OutputPath)\key.ls
	-@erase $(OutputPath)\rc.ls
	-@erase $(OutputPath)\image.ls
	-@erase $(OutputPath)\miwifi.ls
	-@erase $(OutputPath)\beep.ls
	-@erase $(OutputPath)\eeprom.ls
	-@erase $(OutputPath)\commu.ls
	-@erase $(OutputPath)\displaydriver.ls
	-@erase $(OutputPath)\ini.ls
	-@erase $(OutputPath)\main.ls
	-@erase $(OutputPath)\stm8_interrupt_vector.ls
	-@erase $(OutputPath)\uart_sim.ls
endif

# 
# Release
# 
ifeq "$(CFG)" "Release"


OutputPath=Release
ProjectSFile=walkingpad_dev
TargetSName=$(ProjectSFile)
TargetFName=$(ProjectSFile).elf
IntermPath=$(dir $@)
CFLAGS_PRJ=$(ToolsetBin)\cxstm8  +mods0 -pxx -pp -ilib -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<
ASMFLAGS_PRJ=$(ToolsetBin)\castm8  $(ToolsetIncOpts) -o$(IntermPath)$(InputName).$(ObjectExt) $<

all : $(OutputPath) $(ProjectSFile).elf

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

Release\speed.$(ObjectExt) : lib\speed.c c:\cxstm8\hstm8\mods0.h lib\speed.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h src\run_mode.h src\beep.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\sensor.$(ObjectExt) : lib\sensor.c c:\cxstm8\hstm8\mods0.h src\sensor.h newtype.h c:\cxstm8\hstm8\stdbool.h src\beep.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h c:\cxstm8\hstm8\string.h c:\cxstm8\hstm8\stdlib.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\run_mode_new.$(ObjectExt) : lib\run_mode_new.c c:\cxstm8\hstm8\mods0.h src\run_mode.h newtype.h c:\cxstm8\hstm8\stdbool.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h src\sensor.h src\beep.h src\eeprom.h lib\speed.h src\time.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\run_auto.$(ObjectExt) : lib\run_auto.c c:\cxstm8\hstm8\mods0.h src\run_mode.h newtype.h c:\cxstm8\hstm8\stdbool.h src\sensor.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h src\beep.h lib\speed.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\time.$(ObjectExt) : src\time.c c:\cxstm8\hstm8\mods0.h src\time.h newtype.h c:\cxstm8\hstm8\stdbool.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\error.$(ObjectExt) : src\error.c c:\cxstm8\hstm8\mods0.h src\control.h src\time.h newtype.h c:\cxstm8\hstm8\stdbool.h src\beep.h src\sensor.h src\miwifi.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h src\image.h src\eeprom.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\motion.$(ObjectExt) : src\motion.c c:\cxstm8\hstm8\mods0.h c:\cxstm8\hstm8\stdio.h c:\cxstm8\hstm8\string.h newtype.h c:\cxstm8\hstm8\stdbool.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h src\control.h src\time.h src\eeprom.h src\image.h src\beep.h src\key.h src\miwifi.h src\run_mode.h src\sensor.h displaydriver.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\program.$(ObjectExt) : src\program.c c:\cxstm8\hstm8\mods0.h src\key.h newtype.h c:\cxstm8\hstm8\stdbool.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h src\beep.h src\eeprom.h src\control.h src\time.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\control.$(ObjectExt) : src\control.c c:\cxstm8\hstm8\mods0.h c:\cxstm8\hstm8\stdio.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h src\image.h displaydriver.h src\sensor.h src\beep.h src\run_mode.h src\miwifi.h src\eeprom.h src\key.h src\control.h src\time.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\factory.$(ObjectExt) : src\factory.c c:\cxstm8\hstm8\mods0.h c:\cxstm8\hstm8\stdio.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h src\eeprom.h src\key.h src\beep.h src\image.h src\miwifi.h src\run_mode.h src\sensor.h src\control.h src\time.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\fan.$(ObjectExt) : src\fan.c c:\cxstm8\hstm8\mods0.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h src\control.h src\time.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\key.$(ObjectExt) : src\key.c c:\cxstm8\hstm8\mods0.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h src\key.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\rc.$(ObjectExt) : src\rc.c c:\cxstm8\hstm8\mods0.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h src\key.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\image.$(ObjectExt) : src\image.c c:\cxstm8\hstm8\mods0.h c:\cxstm8\hstm8\stdio.h c:\cxstm8\hstm8\string.h c:\cxstm8\hstm8\stdarg.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h src\image.h src\time.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\miwifi.$(ObjectExt) : src\miwifi.c c:\cxstm8\hstm8\mods0.h c:\cxstm8\hstm8\stdio.h c:\cxstm8\hstm8\string.h c:\cxstm8\hstm8\stdlib.h c:\cxstm8\hstm8\ctype.h src\miwifi.h newtype.h c:\cxstm8\hstm8\stdbool.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h src\sensor.h src\beep.h src\run_mode.h src\eeprom.h src\image.h displaydriver.h src\key.h src\time.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\beep.$(ObjectExt) : src\beep.c c:\cxstm8\hstm8\mods0.h src\beep.h newtype.h c:\cxstm8\hstm8\stdbool.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\eeprom.$(ObjectExt) : src\eeprom.c c:\cxstm8\hstm8\mods0.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h src\eeprom.h src\run_mode.h src\miwifi.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\commu.$(ObjectExt) : commu.c c:\cxstm8\hstm8\mods0.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\displaydriver.$(ObjectExt) : displaydriver.c c:\cxstm8\hstm8\mods0.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h src\image.h displaydriver.h c:\cxstm8\hstm8\processor.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\ini.$(ObjectExt) : ini.c c:\cxstm8\hstm8\mods0.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h displaydriver.h src\eeprom.h src\image.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\main.$(ObjectExt) : main.c c:\cxstm8\hstm8\mods0.h stm8s.h stm8s_type.h stm8s_conf.h zero.h newtype.h c:\cxstm8\hstm8\stdbool.h src\sensor.h displaydriver.h src\control.h src\time.h src\miwifi.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\stm8_interrupt_vector.$(ObjectExt) : stm8_interrupt_vector.c c:\cxstm8\hstm8\mods0.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

Release\uart_sim.$(ObjectExt) : uart_sim.c c:\cxstm8\hstm8\mods0.h declare.h stm8s.h stm8s_type.h stm8s_conf.h stm8s105k.h newtype.h c:\cxstm8\hstm8\stdbool.h c:\cxstm8\hstm8\processor.h 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

$(ProjectSFile).elf :  $(OutputPath)\speed.o $(OutputPath)\sensor.o $(OutputPath)\run_mode_new.o $(OutputPath)\run_auto.o $(OutputPath)\time.o $(OutputPath)\error.o $(OutputPath)\motion.o $(OutputPath)\program.o $(OutputPath)\control.o $(OutputPath)\factory.o $(OutputPath)\fan.o $(OutputPath)\key.o $(OutputPath)\rc.o $(OutputPath)\image.o $(OutputPath)\miwifi.o $(OutputPath)\beep.o $(OutputPath)\eeprom.o $(OutputPath)\commu.o $(OutputPath)\displaydriver.o $(OutputPath)\ini.o $(OutputPath)\main.o $(OutputPath)\stm8_interrupt_vector.o $(OutputPath)\uart_sim.o $(OutputPath)\walkingpad_dev.lkf
	clib  -c lib/wp.sm8 $(OutputPath)run_auto.o $(OutputPath)run_mode_new.o $(OutputPath)speed.o $(OutputPath)sensor.o
	$(ToolsetBin)\clnk  $(ToolsetLibOpts) -o $(OutputPath)\$(TargetSName).sm8 -m$(OutputPath)\$(TargetSName).map $(OutputPath)\$(TargetSName).lkf 
	$(ToolsetBin)\cvdwarf  $(OutputPath)\$(TargetSName).sm8

	$(ToolsetBin)\chex  -fi -o $(OutputPath)\$(TargetSName).hex $(OutputPath)\$(TargetSName).sm8
	bin\hex2bin.exe  $(OutputPath)\$(TargetSName).hex
	cmd.exe  /C move /Y $(OutputPath)\$(TargetSName).bin bin\fw.bin
	cmd.exe  /C cd bin && crc.exe
	bin\srec_cat.exe  -Disable_Sequence_Warnings ..\STM8S005K_BootLoader\STVD\Cosmic\Release\stm8bootloader.hex -intel $(OutputPath)\$(TargetSName).hex -intel -o $(OutputPath)\walkingpad_all.hex -intel
clean : 
	-@erase $(OutputPath)\speed.o
	-@erase $(OutputPath)\sensor.o
	-@erase $(OutputPath)\run_mode_new.o
	-@erase $(OutputPath)\run_auto.o
	-@erase $(OutputPath)\time.o
	-@erase $(OutputPath)\error.o
	-@erase $(OutputPath)\motion.o
	-@erase $(OutputPath)\program.o
	-@erase $(OutputPath)\control.o
	-@erase $(OutputPath)\factory.o
	-@erase $(OutputPath)\fan.o
	-@erase $(OutputPath)\key.o
	-@erase $(OutputPath)\rc.o
	-@erase $(OutputPath)\image.o
	-@erase $(OutputPath)\miwifi.o
	-@erase $(OutputPath)\beep.o
	-@erase $(OutputPath)\eeprom.o
	-@erase $(OutputPath)\commu.o
	-@erase $(OutputPath)\displaydriver.o
	-@erase $(OutputPath)\ini.o
	-@erase $(OutputPath)\main.o
	-@erase $(OutputPath)\stm8_interrupt_vector.o
	-@erase $(OutputPath)\uart_sim.o
	-@erase $(OutputPath)\walkingpad_dev.elf
	-@erase $(OutputPath)\walkingpad_dev.elf
	-@erase $(OutputPath)\walkingpad_dev.map
	-@erase $(OutputPath)\speed.ls
	-@erase $(OutputPath)\sensor.ls
	-@erase $(OutputPath)\run_mode_new.ls
	-@erase $(OutputPath)\run_auto.ls
	-@erase $(OutputPath)\time.ls
	-@erase $(OutputPath)\error.ls
	-@erase $(OutputPath)\motion.ls
	-@erase $(OutputPath)\program.ls
	-@erase $(OutputPath)\control.ls
	-@erase $(OutputPath)\factory.ls
	-@erase $(OutputPath)\fan.ls
	-@erase $(OutputPath)\key.ls
	-@erase $(OutputPath)\rc.ls
	-@erase $(OutputPath)\image.ls
	-@erase $(OutputPath)\miwifi.ls
	-@erase $(OutputPath)\beep.ls
	-@erase $(OutputPath)\eeprom.ls
	-@erase $(OutputPath)\commu.ls
	-@erase $(OutputPath)\displaydriver.ls
	-@erase $(OutputPath)\ini.ls
	-@erase $(OutputPath)\main.ls
	-@erase $(OutputPath)\stm8_interrupt_vector.ls
	-@erase $(OutputPath)\uart_sim.ls
endif

# 
# ReleaseUpload
# 
ifeq "$(CFG)" "ReleaseUpload"


OutputPath=ReleaseUpload
ProjectSFile=walkingpad_dev
TargetSName=$(ProjectSFile)
TargetFName=$(ProjectSFile).elf
IntermPath=$(dir $@)
CFLAGS_PRJ=$(ToolsetBin)\cxstm8  +mods0 -pxx -pp -ilib -isrc $(ToolsetIncOpts) -cl$(IntermPath:%\=%) -co$(IntermPath:%\=%) $<
ASMFLAGS_PRJ=$(ToolsetBin)\castm8  $(ToolsetIncOpts) -o$(IntermPath)$(InputName).$(ObjectExt) $<

all : $(OutputPath) $(ProjectSFile).elf

$(OutputPath) : 
	if not exist $(OutputPath)/ mkdir $(OutputPath)

ReleaseUpload\speed.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\sensor.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\run_mode_new.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\run_auto.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\time.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\error.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\motion.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\program.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\control.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\factory.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\fan.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\key.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\rc.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\image.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\miwifi.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\beep.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\eeprom.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\commu.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\displaydriver.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\ini.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\main.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\stm8_interrupt_vector.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

ReleaseUpload\uart_sim.$(ObjectExt) : 
	@if not exist $(dir $@)  mkdir $(dir $@)
	$(CFLAGS_PRJ)

$(ProjectSFile).elf :  $(OutputPath)\speed.o $(OutputPath)\sensor.o $(OutputPath)\run_mode_new.o $(OutputPath)\run_auto.o $(OutputPath)\time.o $(OutputPath)\error.o $(OutputPath)\motion.o $(OutputPath)\program.o $(OutputPath)\control.o $(OutputPath)\factory.o $(OutputPath)\fan.o $(OutputPath)\key.o $(OutputPath)\rc.o $(OutputPath)\image.o $(OutputPath)\miwifi.o $(OutputPath)\beep.o $(OutputPath)\eeprom.o $(OutputPath)\commu.o $(OutputPath)\displaydriver.o $(OutputPath)\ini.o $(OutputPath)\main.o $(OutputPath)\stm8_interrupt_vector.o $(OutputPath)\uart_sim.o $(OutputPath)\walkingpad_dev.lkf
	$(ToolsetBin)\clnk  $(ToolsetLibOpts) -o $(OutputPath)\$(TargetSName).sm8 -m$(OutputPath)\$(TargetSName).map $(OutputPath)\$(TargetSName).lkf 
	$(ToolsetBin)\cvdwarf  $(OutputPath)\$(TargetSName).sm8

	$(ToolsetBin)\chex  -fi -o $(OutputPath)\$(TargetSName).hex $(OutputPath)\$(TargetSName).sm8
	bin\hex2bin.exe  $(OutputPath)\$(TargetSName).hex
	cmd.exe  /C move /Y $(OutputPath)\$(TargetSName).bin bin\fw.bin
	cmd.exe  /C cd bin && crc.exe
	python  py\qiniu_upload.py bin\fw_crc.bin
clean : 
	-@erase $(OutputPath)\speed.o
	-@erase $(OutputPath)\sensor.o
	-@erase $(OutputPath)\run_mode_new.o
	-@erase $(OutputPath)\run_auto.o
	-@erase $(OutputPath)\time.o
	-@erase $(OutputPath)\error.o
	-@erase $(OutputPath)\motion.o
	-@erase $(OutputPath)\program.o
	-@erase $(OutputPath)\control.o
	-@erase $(OutputPath)\factory.o
	-@erase $(OutputPath)\fan.o
	-@erase $(OutputPath)\key.o
	-@erase $(OutputPath)\rc.o
	-@erase $(OutputPath)\image.o
	-@erase $(OutputPath)\miwifi.o
	-@erase $(OutputPath)\beep.o
	-@erase $(OutputPath)\eeprom.o
	-@erase $(OutputPath)\commu.o
	-@erase $(OutputPath)\displaydriver.o
	-@erase $(OutputPath)\ini.o
	-@erase $(OutputPath)\main.o
	-@erase $(OutputPath)\stm8_interrupt_vector.o
	-@erase $(OutputPath)\uart_sim.o
	-@erase $(OutputPath)\walkingpad_dev.elf
	-@erase $(OutputPath)\walkingpad_dev.elf
	-@erase $(OutputPath)\walkingpad_dev.map
	-@erase $(OutputPath)\speed.ls
	-@erase $(OutputPath)\sensor.ls
	-@erase $(OutputPath)\run_mode_new.ls
	-@erase $(OutputPath)\run_auto.ls
	-@erase $(OutputPath)\time.ls
	-@erase $(OutputPath)\error.ls
	-@erase $(OutputPath)\motion.ls
	-@erase $(OutputPath)\program.ls
	-@erase $(OutputPath)\control.ls
	-@erase $(OutputPath)\factory.ls
	-@erase $(OutputPath)\fan.ls
	-@erase $(OutputPath)\key.ls
	-@erase $(OutputPath)\rc.ls
	-@erase $(OutputPath)\image.ls
	-@erase $(OutputPath)\miwifi.ls
	-@erase $(OutputPath)\beep.ls
	-@erase $(OutputPath)\eeprom.ls
	-@erase $(OutputPath)\commu.ls
	-@erase $(OutputPath)\displaydriver.ls
	-@erase $(OutputPath)\ini.ls
	-@erase $(OutputPath)\main.ls
	-@erase $(OutputPath)\stm8_interrupt_vector.ls
	-@erase $(OutputPath)\uart_sim.ls
endif
