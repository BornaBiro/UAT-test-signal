#
_XDCBUILDCOUNT = 
ifneq (,$(findstring path,$(_USEXDCENV_)))
override XDCPATH = /mnt/tirex-content/simplelink_cc13x0_sdk_4_20_02_07/source;/mnt/tirex-content/simplelink_cc13x0_sdk_4_20_02_07/kernel/tirtos/packages
override XDCROOT = /mnt/tirex-content/xdctools_3_51_03_28_core
override XDCBUILDCFG = ./config.bld
endif
ifneq (,$(findstring args,$(_USEXDCENV_)))
override XDCARGS = 
override XDCTARGETS = 
endif
#
ifeq (0,1)
PKGPATH = /mnt/tirex-content/simplelink_cc13x0_sdk_4_20_02_07/source;/mnt/tirex-content/simplelink_cc13x0_sdk_4_20_02_07/kernel/tirtos/packages;/mnt/tirex-content/xdctools_3_51_03_28_core/packages;..
HOSTOS = Linux
endif
