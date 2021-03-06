EESchema Schematic File Version 4
LIBS:STMaytal32-LoRa_Module-cache
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Makerlab_microcontrollers:Adafruit_LoRa_Breakout U3
U 1 1 5BD0BD41
P 3100 3050
F 0 "U3" H 3100 3100 50  0000 C CNN
F 1 "Adafruit_LoRa_Breakout" H 3150 3000 50  0000 C CNN
F 2 "DAI_Maker_Lab_footprints:Adafruit_LoRa_Breakout" H 3100 3050 50  0001 C CNN
F 3 "" H 3100 3050 50  0001 C CNN
	1    3100 3050
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery_Cell BT2
U 1 1 5BD0C4FE
P 4500 1450
F 0 "BT2" H 4618 1546 50  0000 L CNN
F 1 "Battery_Cell" H 4618 1455 50  0000 L CNN
F 2 "" V 4500 1510 50  0001 C CNN
F 3 "~" V 4500 1510 50  0001 C CNN
	1    4500 1450
	1    0    0    -1  
$EndComp
Text GLabel 4000 2400 3    50   Input ~ 0
GND
Text GLabel 3100 3850 3    50   Input ~ 0
GND
Wire Wire Line
	3100 3750 3100 3850
Text GLabel 2150 3000 0    50   Input ~ 0
SCK-RX
Text GLabel 2150 3100 0    50   Input ~ 0
MOSI-KEY
Text GLabel 2150 3200 0    50   Input ~ 0
CS-RI
Text GLabel 2150 3300 0    50   Input ~ 0
RST
Text GLabel 4100 2800 2    50   Input ~ 0
G0
Text GLabel 4100 2900 2    50   Input ~ 0
MISO-TX
Text GLabel 4100 3000 2    50   Input ~ 0
G1-PSTAT
NoConn ~ 4000 3100
NoConn ~ 4000 3200
NoConn ~ 4000 3300
NoConn ~ 4000 3400
Wire Wire Line
	2150 3000 2250 3000
Wire Wire Line
	2150 3100 2250 3100
Wire Wire Line
	2150 3200 2250 3200
Wire Wire Line
	2150 3300 2250 3300
Wire Wire Line
	4000 2800 4100 2800
Wire Wire Line
	4000 2900 4100 2900
Wire Wire Line
	4000 3000 4100 3000
Wire Wire Line
	2850 2300 2850 2450
$Comp
L Makerlab_breakouts:Adafruit_LiPoly_Solar U4
U 1 1 5BD239AB
P 4100 1800
F 0 "U4" H 4150 1800 50  0000 R CNN
F 1 "Adafruit_LiPoly_Solar" V 4350 2150 50  0000 R CNN
F 2 "DAI_Maker_Lab_footprints:Adafruit_LiPo_Solar" H 4100 1800 50  0001 C CNN
F 3 "" H 4100 1800 50  0001 C CNN
	1    4100 1800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4200 1250 4500 1250
Wire Wire Line
	4500 1550 4500 2350
Wire Wire Line
	4500 2350 4200 2350
Wire Wire Line
	4000 2350 4000 2400
Wire Wire Line
	4000 1250 3700 1250
Wire Wire Line
	3700 1250 3700 2300
$Comp
L Connector_Generic:Conn_02x05_Counter_Clockwise J1
U 1 1 5BEFDAA8
P 1550 1750
F 0 "J1" H 1600 2167 50  0000 C CNN
F 1 "Conn_02x05_Counter_Clockwise" H 1600 2076 50  0000 C CNN
F 2 "DAI_Maker_Lab_footprints:2x05-JTAG-type-connector" H 1550 1750 50  0001 C CNN
F 3 "~" H 1550 1750 50  0001 C CNN
	1    1550 1750
	1    0    0    -1  
$EndComp
Text GLabel 1300 1650 0    50   Input ~ 0
EN
Text GLabel 1300 1750 0    50   Input ~ 0
G0
Text GLabel 1300 1850 0    50   Input ~ 0
G1-PSTAT
Text GLabel 1300 1950 0    50   Input ~ 0
CS-RI
Text GLabel 1900 1550 2    50   Input ~ 0
GND
Text GLabel 1900 1650 2    50   Input ~ 0
MISO-TX
Text GLabel 1900 1750 2    50   Input ~ 0
MOSI-KEY
Text GLabel 1900 1850 2    50   Input ~ 0
SCK-RX
Text GLabel 1900 1950 2    50   Input ~ 0
RST
Wire Wire Line
	1300 1650 1350 1650
Wire Wire Line
	1300 1750 1350 1750
Wire Wire Line
	1300 1850 1350 1850
Wire Wire Line
	1300 1950 1350 1950
Wire Wire Line
	1850 1550 1900 1550
Wire Wire Line
	1850 1650 1900 1650
Wire Wire Line
	1850 1750 1900 1750
Wire Wire Line
	1850 1850 1900 1850
Wire Wire Line
	1850 1950 1900 1950
Text GLabel 2150 2900 0    50   Input ~ 0
EN
Wire Wire Line
	2150 2900 2250 2900
NoConn ~ 1350 1550
Wire Wire Line
	2850 2300 3700 2300
$EndSCHEMATC
