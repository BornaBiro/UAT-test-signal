################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
build-1317695535:
	@$(MAKE) --no-print-directory -Onone -f subdir_rules.mk build-1317695535-inproc

build-1317695535-inproc: ../release.cfg
	@echo 'Building file: "$<"'
	@echo 'Invoking: XDCtools'
	"/mnt/tirex-content/xdctools_3_51_03_28_core/xs" --xdcpath="/mnt/tirex-content/simplelink_cc13x0_sdk_4_20_02_07/source;/mnt/tirex-content/simplelink_cc13x0_sdk_4_20_02_07/kernel/tirtos/packages;" xdc.tools.configuro -o configPkg -t ti.targets.arm.elf.M3 -p ti.platforms.simplelink:CC1310F128 -r release -c "/mnt/ccs/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS" --compileOptions " -DDeviceFamily_CC13X0 " "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

configPkg/linker.cmd: build-1317695535 ../release.cfg
configPkg/compiler.opt: build-1317695535
configPkg: build-1317695535


