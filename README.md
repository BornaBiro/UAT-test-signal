# UAT (ADS-B 978) test signal generator

## Disclaimer

This low power UAT test source is designed for a lab or an aircraft hangar use only.

## Disclaimer2
This is updated version of the project, since original one had some issues, described in the next paragraphs.
### Issue no1 - Could not build
This is the first issue - following Build Instructions I simply could not build the project. Project Dependency for TI RTOS was completly missing from the repo?! I created one on the Web TI CCS along with the empty project and linked it to the UAT project. Hitting "Build" again yield in error prompting me to use Desktop Version of the CCS. After few hours downloading, installing and setuping everything, got the new error on the build saying that some tms470 dependency was missing. Google and ChatGPT weren't very useful, so what I did is create new empty Project along with TI RTOS and just added all source files from the original project (except UAT_test_signal.c, I copied everything into empty.c, yeah I know very meaningful project name xD). Build was finally successfull!

### Issue no2 - Wrong transmit frequency
For some reason transmit frequency was 915MHz (see images below), but it needs to be at 978MHz. I downloaded and installed SmartRF Studio 7, selected CC1310 device, imported parameters from smartrf_settings/smartrf_settings.c, except the frequency. Frequency was set to 978MHz. Only values that changed were at `rfc_CMD_PROP_RADIO_DIV_SETUP_t`
```
.centerFreq = 0x03D2,
.intFreq = 0x0B33,
```
and at `rfc_CMD_FS_t`
```
.frequency = 0x03D2,
```
Now the CC1310 is transmitting data at 978MHz. **I did not test if the transmitted data is correct, since I accidently destroyed one CC1310.**

<p align="center">
  <img width="800" src="https://raw.githubusercontent.com/BornaBiro/UAT-test-signal/fixed/notes/pics/RigolDS0.png">
  <br>
    <b>Wrong transmit frequency - 915MHz</b>
</p>
<br>

<p align="center">
  <img width="800" src="https://raw.githubusercontent.com/BornaBiro/UAT-test-signal/fixed/notes/pics/RigolDS1.png">
  <br>
    <b>Wrong transmit frequency - 915MHz, but nothing on 978MHz (check the Ax cursor!)</b>
</p>
<br>

<p align="center">
  <img width="800" src="https://raw.githubusercontent.com/BornaBiro/UAT-test-signal/fixed/notes/pics/RigolDS2.png">
  <br>
    <b>Fixed transmit frequency - wide RBW</b>
</p>
<br>

<p align="center">
  <img width="800" src="https://raw.githubusercontent.com/BornaBiro/UAT-test-signal/fixed/notes/pics/RigolDS3.png">
  <br>
    <b>Fixed transmit frequency - narrow RBW</b>
</p>
<br>

<p align="center">
  <img width="800" src="https://raw.githubusercontent.com/BornaBiro/UAT-test-signal/fixed/notes/pics/RigolDS4.png">
  <br>
    <b>Fixed transmit frequency - wide RBW</b>
</p>
<br>

## Legitimate use

Radio being used in the project is rated for 14 dBm (25 mW) of maximum transmit power.<br>
FCC compliant built-in RF filter reduces the power even more, down to approximately 1 mW on the reference frequency.<br>
This power is sufficient to cover an area of just only few meters around the transmitter.<br>

## Hardware

### Variant 1. Basic.

[TI SimpleLink CC1310 LaunchPad kit (915 MHz)](http://www.ti.com/tool/LAUNCHXL-CC1310)

<br>

<img src="https://www.ti.com/diagrams/launchxl-cc1310_launchxl-cc1310-angled_(1).jpg">

<br>

### Variant 2. Advanced.

<br>

<img src="https://github.com/lyusupov/SoftRF/raw/master/documents/images/SoftRF-UAT-1.jpg" height="262" width="400"><br>
<br>
<img src="https://github.com/lyusupov/SoftRF/raw/master/documents/images/SoftRF-UAT-2.jpg" height="199" width="400"><br>

Schematics of the adapter and Gerber files of the PCB will be published soon after I'll receive the PCB samples<br>
and will make sure that the design has no any critical issues.

#### Bill of materials

Number|Part|Qty|Picture|Source
---|---|---|---|---
1|PCB|1|<img src="https://github.com/lyusupov/UAT-test-signal/raw/master/notes/pics/SoftRF-UAT-PCB.jpg" height="388" width="300">|&nbsp;TBD&nbsp; <!-- <a href="https://PCBs.io/share/rYeN0"><img src="https://s3.amazonaws.com/pcbs.io/share.png" alt="Order from PCBs.io"></img></a>  -->
2|Ebyte E70-915T14S<br>RF module|1|![](https://github.com/lyusupov/UAT-test-signal/raw/master/notes/pics/E70-915T14S.jpg)|[AliExpress](http://s.click.aliexpress.com/e/nysD1eu)
3|Female SMA-KHD|1|<img src="https://github.com/lyusupov/SoftRF/raw/master/documents/images/bom/sma-khd.jpg" height="300" width="300">|[AliExpress](https://www.aliexpress.com/item/10-Pcs-SMA-Female-Jack-Solder-Edge-1-6mm-Space-PCB-Mount-Straight-RF-Connector-New/32842094243.html)
4|2x7 female header 2.54mm|1|![](https://github.com/lyusupov/SoftRF/blob/master/documents/images/bom/f2x7.jpg)|Local
5|1x40 male header 2.54mm|2|<img src="https://github.com/lyusupov/SoftRF/blob/master/documents/images/bom/m40.jpg" height="283" width="200">|[AliExpress](https://www.aliexpress.com/item/10pcs-40-Pin-1x40-Single-Row-Male-2-54-Breakable-Pin-Header-Connector-Strip-for-Arduino/32806313091.html)
6|XDS110 cJTAG debug tool (clone)|1|<img src="https://github.com/lyusupov/UAT-test-signal/raw/master/notes/pics/XDS110_clone.jpg" height="300" width="221">|[AliExpress](https://www.aliexpress.com/item/-/32938193571.html)
7|40 pcs. female DuPont jumper wires|1|<img src="https://github.com/lyusupov/SoftRF/blob/master/documents/images/bom/40DuPont.jpg" height="237" width="300">|[AliExpress](http://www.aliexpress.com/item/40-pcs-30cm-1p-1p-female-to-female-2-54mm-Spacing-Jumper-Wire-Dupont-Cable/1905309688.html) 



## Firmware

### Build instructions

~~1) either:~~
~~- download this CCS project from GitHub, then upload it into your [TI CCS Cloud IDE](https://dev.ti.com/), or ;~~
~~- if you have a GitHub account: "fork" this project into your GitHub space, then import directly into TI CCS Cloud IDE.~~
~~2) build, then run the firmware on your CC1310 hardware with assistance of [TI Cloud Agent](http://processors.wiki.ti.com/index.php/TI_Cloud_Agent) and [TI Cloud Agent Bridge](https://chrome.google.com/webstore/detail/ticloudagent-bridge/pfillhniocmjcapelhjcianojmoidjdk) plug-in for Google Chrome browser.~~ 

1. Create the account on [TI Developer Zone](https://dev.ti.com/)
2. Navigate down to the All Available Tools and select CCS Cloud
3. Open it and wait until Web IDE is fully loaded
4. File->Import Projects, click on Browse and select `tirtos_builds_CC1310_LAUNCHXL_release_ccs` folder
5. Do the same thing for `empty_CC1310_LAUNCHXL_tirtos_ccs`
6. Click on Project->Build All
7. In the folder `empty_CC1310_LAUNCHXL_tirtos_ccs` there should be Debug folder. Open in, find the file called `empty_CC1310_LAUNCHXL_tirtos_ccs.out`. Right-click, select download.
8. Upload it on the CC1310 IC using your favorite tool (my choice was OpenOCD and FT232L as "Debug Probe")

## Code upload
As prev. mentioned, I use OpenOCD as my upload tool. It's free and the probe is cheap (FT232L breakout). It's not perfect, but it does work (it's slow and kinda buggy, but hey it cheap!).

1. Get OpenOCD from [Github repo](https://github.com/openocd-org/openocd) - Download release. I used v0.12.0 from release page
2. Extract it on C:\OpenOCD
3. Add PATH to the System Environment Variables to the OpenOCD.
4. Get Windows Terminal (commands can be run with CMD, but I used to run them from the Windows Terminal).
5. Go to C:\OpenOCD\bin and create `target` and `interface` folders.
6. In `interface` folder paste all files from [interface folder](https://github.com/openocd-org/openocd/tree/master/tcl/interface)
7. In `target` folder paste all files from [target folder](https://github.com/openocd-org/openocd/tree/master/tcl/target)
8. Get FT232R/FT232RL breakout. Get the [Zadig](https://zadig.akeo.ie/). Select Options->List All devices. Select from the drop down menu FT232R USB UART. Select libusbK and click on "Replace Driver". If you need to return driver to the previous state (to FT232R works as USB UART select WinUSB and "Replace Driver").
9. Open one terminal and run this command
`openocd -s tcl/ -f interface/ft232r.cfg -c "adapter speed 2500" -c "transport select jtag" -c "reset_config srst_only" -f target/ti_cc13x0.cfg`. It should open telnet. **Note:** Check if the telent is enabled, open second Windows Terminal and run telnet command. If failed, goto Control Panel->Program and Features, at the left side click on Turn Windows feruates On or Off, scroll down to the Telnet and enable it.
10. In the second Windows Terminal run `telnet localhost 4444`. If connected run `reset halt`. It should halt the CPU core. If successfull, run `flash write_image erase [path_to_image_file] 0x00000000` for example `flash write_image erase C:/empty_CC1310_LAUNCHXL_tirtos_ccs_new.out 0x00000000`. Press enter. **NOTE NOTE NOTE:** It will look like nothing is happenning, but in fact, it is programming device. It can take up to 2 minutes to program it. After programming is successfull, run `reset run` and `shutdown`. Powercycle target device.
11. Done! Your device sends data every 500ms. Check DIO7 for toogle. If the pin is toggling, it is transmisstion data on every pin state change.

## FTDI FT232R <-> CC310 Connections
|CC1310 GPIO|CC1310 pin|FT232R Breakout|
---|---|---
|TMSC|21|CTS|
|TCKC|22|TXD|
|TDO (DIO16)|23|RTS|
|TDI (DIO17)|24|RXD|
|RESET|32|DTR|

FT232R JTAG pinout can be found [here](https://openocd.org/doc/html/Debug-Adapter-Configuration.html). Search for `Interface Driver: ft232r`.

## Validation

### Raw data

```
pi@raspberrypi:/run/tmp/dump978-master $ rtl_sdr -f 915000000 -s 2083334 -g 8 - | ./dump978
Found 1 device(s):
  0:  Generic, RTL2832U, SN: 77771111153705700

Using device 0: Generic RTL2832U
Found Rafael Micro R820T tuner
Exact sample rate is: 2083334.141630 Hz
[R82XX] PLL not locked!
Sampling at 2083334 S/s.
Tuned to 915000000 Hz.
Tuner gain set to 7.70 dB.
Reading samples in async mode...
-0d1abba154d8ec198ba602f0800000000074c28d855bfd0b4aa5c2a0000000000000;
...
```

### Text

```
pi@raspberrypi:/run/tmp/dump978-master $ rtl_sdr -f 915000000 -s 2083334 -g 8 - | ./dump978 | ./uat2text
Found 1 device(s):
  0:  Generic, RTL2832U, SN: 77771111153705700

Using device 0: Generic RTL2832U
Found Rafael Micro R820T tuner
Exact sample rate is: 2083334.141630 Hz
[R82XX] PLL not locked!
Sampling at 2083334 S/s.
Tuned to 915000000 Hz.
Tuner gain set to 7.70 dB.
Reading samples in async mode...
HDR:
 MDB Type:          1
 Address:           1ABBA1 (Fixed ADS-B Beacon Address)
SV:
 NIC:               0
 Latitude:          +59.6583
 Longitude:         +17.9617
 Altitude:          150 ft (barometric)
 Dimensions:        15.0m L x 11.5m W
 UTC coupling:      no
 TIS-B site ID:     0
MS:
 Emitter category:  Service vehicle
 Callsign:          RAMPTEST
 Emergency status:  No emergency
 UAT version:       2
 SIL:               3
 Transmit MSO:      18
 NACp:              10
 NACv:              2
 NICbaro:           1
 Capabilities:      CDTI ACAS
 Active modes:
 Target track type: true heading
AUXSV:
 Sec. altitude:     unavailable
...
```

### Map

```
pi@raspberrypi:/run/tmp $ rtl_sdr -f 915000000 -s 2083334 -g 8 - | ./dump978-master/dump978 | ./dump978-master/uat2json /run/tmp/dump1090-master/public_html/data/
Found 1 device(s):
  0:  Generic, RTL2832U, SN: 77771111153705700

Using device 0: Generic RTL2832U
Found Rafael Micro R820T tuner
Exact sample rate is: 2083334.141630 Hz
[R82XX] PLL not locked!
Sampling at 2083334 S/s.
Tuned to 915000000 Hz.
Tuner gain set to 7.70 dB.
Reading samples in async mode...
...
```

<img src="https://github.com/lyusupov/UAT-test-signal/raw/master/notes/pics/dump978.jpg" height="418" width="674">
<br>

### ADS-B receiver


![](https://github.com/lyusupov/SoftRF/raw/master/documents/images/UATbridge_Stratux.JPG)
<br>

## Signal

[IQ file](https://github.com/lyusupov/UAT-test-signal/raw/master/notes/UAT_977MHz-8_333_MSps.wav) (WAV).<br>
Taken at base frequency: 977 MHz . Sampling rate: 8.333 MSps.

![](https://github.com/lyusupov/UAT-test-signal/raw/master/notes/pics/UAT_Signal.JPG)



![](https://github.com/lyusupov/UAT-test-signal/raw/master/notes/pics/UAT_Spectrum.JPG)



## Data customization

1. Execute *UATEncoder.py* script with `<CallSign>` `<ICAO>` `<Latitude>` `<Longitude>` `<Altitude>` arguments:
```
$ python UATEncoder.py RAMPTEST 0x1ABBA1 59.6583 17.9617 137.8

#define UAT_DATA    "0d1abba154d8ec198ba602f0800000000074c28d855bfd0b4aa5c2a0000000000000"


```

2. Edit *UAT_data.h* file:
```
#ifndef UAT_DATA

#define UAT_DATA    "0d1abba154d8ec198ba602f0800000000074c28d855bfd0b4aa5c2a0000000000000"

#endif
```

3. Build your custom firmware and download it into your signal generator hardware.

