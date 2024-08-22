################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
smartrf_settings/%.obj: ../smartrf_settings/%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	ulimit -t 30 ; ulimit -s 1024 ; "/mnt/ccs/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/bin/armcl" -mv7M3 --code_state=16 --float_support=vfplib -me --include_path="/home/guest/ide/default/empty_CC1310_LAUNCHXL_tirtos_ccs" --include_path="/mnt/tirex-content/simplelink_cc13x0_sdk_4_20_02_07/source/ti/posix/ccs" --include_path="/mnt/ccs/ccs/tools/compiler/ti-cgt-arm_20.2.7.LTS/include" --define=DeviceFamily_CC13X0 -g --diag_warning=225 --diag_warning=255 --diag_wrap=off --display_error_number --gen_func_subsections=on --preproc_with_compile --preproc_dependency="smartrf_settings/$(basename $(<F)).d_raw" --obj_directory="smartrf_settings" --diag_error=66 --set_error_limit=10 $(GEN_OPTS__FLAG) "$(shell echo $<)"
	@echo 'Finished building: "$<"'
	@echo ' '


