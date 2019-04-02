EESchema Schematic File Version 4
LIBS:STMaytal32v04-cache
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
L Makerlab_microcontrollers:STM32_Blue_Pill U1
U 1 1 5BD0A625
P 1650 5150
F 0 "U1" V 1550 5200 50  0000 R CNN
F 1 "STM32_Blue_Pill" V 1650 5450 50  0000 R CNN
F 2 "DAI_Maker_Lab_footprints:STM32_Blue_Pill" H 1400 5150 50  0001 C CNN
F 3 "" H 1400 5150 50  0001 C CNN
	1    1650 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery BT1
U 1 1 5BD0A7E8
P 1350 1050
F 0 "BT1" V 1105 1050 50  0000 C CNN
F 1 "Battery" V 1196 1050 50  0000 C CNN
F 2 "DAI_Maker_Lab_footprints:Keystone_3POS_2mm" V 1350 1110 50  0001 C CNN
F 3 "~" V 1350 1110 50  0001 C CNN
	1    1350 1050
	0    1    1    0   
$EndComp
Text GLabel 1150 2100 3    50   Input ~ 0
GND
Text GLabel 1650 7150 3    50   Input ~ 0
GND
Wire Wire Line
	1650 7150 1650 7050
Text GLabel 2450 5450 2    50   Input ~ 0
RST
Wire Wire Line
	2450 5450 2350 5450
Text GLabel 2450 6350 2    50   Input ~ 0
CS-RI
Wire Wire Line
	2450 6350 2350 6350
Text GLabel 2450 6250 2    50   Input ~ 0
SCK-RX
Text GLabel 2450 6150 2    50   Input ~ 0
MISO-TX
Text GLabel 2450 6050 2    50   Input ~ 0
MOSI-KEY
Wire Wire Line
	2350 6050 2450 6050
Wire Wire Line
	2350 6150 2450 6150
Wire Wire Line
	2350 6250 2450 6250
Text GLabel 2450 6450 2    50   Input ~ 0
G0
Text GLabel 2450 4450 2    50   Input ~ 0
G1-PSTAT
Text GLabel 1550 2100 3    50   Input ~ 0
VBAT
Text GLabel 1650 3250 1    50   Input ~ 0
VBAT
$Comp
L Regulator_Linear:LM78M05_TO220 U2
U 1 1 5BD17D74
P 4050 4100
F 0 "U2" H 4150 4350 50  0000 C CNN
F 1 "LM78M05_TO220" H 3900 4250 50  0000 C CNN
F 2 "TO_SOT_Packages_THT:TO-220-3_Vertical" H 4050 4325 50  0001 C CIN
F 3 "http://www.fairchildsemi.com/ds/LM/LM78M05.pdf" H 4050 4050 50  0001 C CNN
	1    4050 4100
	1    0    0    -1  
$EndComp
Text GLabel 4050 5000 3    50   Input ~ 0
GND
$Comp
L Connector:Conn_01x03_Male J1
U 1 1 5BD18B0E
P 4950 4000
F 0 "J1" H 4923 3930 50  0000 R CNN
F 1 "Conn_01x03_Male" H 4923 4021 50  0000 R CNN
F 2 "DAI_Maker_Lab_footprints:JST-PH-2.0-3_pin" H 4950 4000 50  0001 C CNN
F 3 "~" H 4950 4000 50  0001 C CNN
	1    4950 4000
	-1   0    0    1   
$EndComp
Text GLabel 4700 4000 0    50   Input ~ 0
GND
Wire Wire Line
	4700 4000 4750 4000
Wire Wire Line
	4350 4100 4750 4100
Text GLabel 4700 3400 2    50   Input ~ 0
PRESSURE
Text GLabel 2450 6750 2    50   Input ~ 0
PRESSURE
Wire Wire Line
	2450 6750 2350 6750
Text GLabel 3650 4100 0    50   Input ~ 0
VBAT
Text GLabel 3650 4700 0    50   Input ~ 0
Q1_BASE
$Comp
L Device:R R2
U 1 1 5BD36C82
P 4550 3150
F 0 "R2" H 4480 3104 50  0000 R CNN
F 1 "91K" H 4480 3195 50  0000 R CNN
F 2 "Resistors_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4480 3150 50  0001 C CNN
F 3 "~" H 4550 3150 50  0001 C CNN
	1    4550 3150
	-1   0    0    1   
$EndComp
$Comp
L Device:R R1
U 1 1 5BD36D6B
P 4550 3650
F 0 "R1" H 4480 3604 50  0000 R CNN
F 1 "47K" H 4480 3695 50  0000 R CNN
F 2 "Resistors_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4480 3650 50  0001 C CNN
F 3 "~" H 4550 3650 50  0001 C CNN
	1    4550 3650
	-1   0    0    1   
$EndComp
Wire Wire Line
	4700 3400 4550 3400
Wire Wire Line
	4550 3400 4550 3500
Wire Wire Line
	4550 3300 4550 3400
Connection ~ 4550 3400
Text GLabel 4550 2900 1    50   Input ~ 0
GND
Wire Wire Line
	4550 2900 4550 3000
Wire Wire Line
	4550 3800 4550 3900
Wire Wire Line
	4550 3900 4750 3900
$Comp
L Device:C C1
U 1 1 5BD496DC
P 1350 1450
F 0 "C1" V 1098 1450 50  0000 C CNN
F 1 "10uF" V 1189 1450 50  0000 C CNN
F 2 "Capacitors_THT:CP_Radial_D5.0mm_P2.50mm" H 1388 1300 50  0001 C CNN
F 3 "~" H 1350 1450 50  0001 C CNN
	1    1350 1450
	0    1    1    0   
$EndComp
$Comp
L Device:C C2
U 1 1 5BD498B3
P 1350 1900
F 0 "C2" V 1098 1900 50  0000 C CNN
F 1 "0.1uF" V 1189 1900 50  0000 C CNN
F 2 "Capacitors_THT:C_Disc_D3.0mm_W2.0mm_P2.50mm" H 1388 1750 50  0001 C CNN
F 3 "~" H 1350 1900 50  0001 C CNN
	1    1350 1900
	0    1    1    0   
$EndComp
Wire Wire Line
	1150 1050 1150 1450
Wire Wire Line
	1550 1050 1550 1450
Wire Wire Line
	1500 1450 1550 1450
Connection ~ 1550 1450
Wire Wire Line
	1550 1450 1550 1900
Wire Wire Line
	1200 1450 1150 1450
Connection ~ 1150 1450
Wire Wire Line
	1150 1450 1150 1900
Wire Wire Line
	1200 1900 1150 1900
Connection ~ 1150 1900
Wire Wire Line
	1150 1900 1150 2100
Wire Wire Line
	1500 1900 1550 1900
Connection ~ 1550 1900
Wire Wire Line
	1550 1900 1550 2100
$Comp
L Makerlab_components:P30N06LE Q1
U 1 1 5BEA079F
P 4000 4700
F 0 "Q1" H 4156 4746 50  0000 L CNN
F 1 "P30N06LE" H 4156 4655 50  0000 L CNN
F 2 "Power_Integrations:TO-220" H 3600 4300 50  0001 C CNN
F 3 "" H 3600 4300 50  0001 C CNN
	1    4000 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 4100 3750 4100
Wire Wire Line
	4050 4400 4050 4500
Wire Wire Line
	3650 4700 3750 4700
Wire Wire Line
	4050 4900 4050 5000
Text GLabel 1750 3250 1    50   Input ~ 0
VCC
Wire Wire Line
	1750 3250 1750 3350
Text GLabel 3850 6050 0    50   Input ~ 0
VCC
Text GLabel 4550 6050 2    50   Input ~ 0
GND
Text GLabel 3850 6150 0    50   Input ~ 0
EN
Text GLabel 4550 6350 2    50   Input ~ 0
SCK-RX
Text GLabel 4550 6150 2    50   Input ~ 0
MISO-TX
Text GLabel 4550 6250 2    50   Input ~ 0
MOSI-KEY
Text GLabel 3850 6250 0    50   Input ~ 0
G0
Text GLabel 3850 6350 0    50   Input ~ 0
G1-PSTAT
$Comp
L Connector_Generic:Conn_02x05_Counter_Clockwise J2
U 1 1 5BED939C
P 4150 6250
F 0 "J2" H 4200 6667 50  0000 C CNN
F 1 "Conn_02x05_Counter_Clockwise" H 4200 6576 50  0000 C CNN
F 2 "DAI_Maker_Lab_footprints:2x05-JTAG-type-connector" H 4150 6250 50  0001 C CNN
F 3 "~" H 4150 6250 50  0001 C CNN
	1    4150 6250
	1    0    0    -1  
$EndComp
Text GLabel 4550 6450 2    50   Input ~ 0
RST
Text GLabel 3850 6450 0    50   Input ~ 0
CS-RI
Wire Wire Line
	3850 6050 3950 6050
Wire Wire Line
	3850 6150 3950 6150
Wire Wire Line
	3850 6250 3950 6250
Wire Wire Line
	3850 6350 3950 6350
Wire Wire Line
	3850 6450 3950 6450
Wire Wire Line
	4450 6050 4550 6050
Wire Wire Line
	4450 6150 4550 6150
Wire Wire Line
	4450 6250 4550 6250
Wire Wire Line
	4450 6350 4550 6350
Wire Wire Line
	4450 6450 4550 6450
Wire Wire Line
	2450 4450 2350 4450
Wire Wire Line
	2450 6450 2350 6450
Text GLabel 2450 4350 2    50   Input ~ 0
EN
Wire Wire Line
	2450 4350 2350 4350
Text GLabel 2450 5350 2    50   Input ~ 0
Q1_BASE
Wire Wire Line
	1650 3250 1650 3350
Text GLabel 2450 5850 2    50   Input ~ 0
SERIAL1.TX
Wire Wire Line
	2450 5850 2350 5850
$Comp
L Connector:Conn_01x02_Male J4
U 1 1 5C05AB41
P 2800 1800
F 0 "J4" V 2906 1841 50  0000 L CNN
F 1 "Conn_01x02_Male" V 2951 1840 50  0001 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 2800 1800 50  0001 C CNN
F 3 "~" H 2800 1800 50  0001 C CNN
	1    2800 1800
	0    1    1    0   
$EndComp
$Comp
L Connector:Conn_01x01_Male J3
U 1 1 5C05CDE5
P 2450 1800
F 0 "J3" V 2556 1841 50  0000 L CNN
F 1 "Conn_01x01_Male" V 2601 1840 50  0001 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x01_Pitch2.54mm" H 2450 1800 50  0001 C CNN
F 3 "~" H 2450 1800 50  0001 C CNN
	1    2450 1800
	0    1    1    0   
$EndComp
Text GLabel 2450 2100 3    50   Input ~ 0
GND
Wire Wire Line
	2450 2100 2450 2000
Text GLabel 2700 2100 3    50   Input ~ 0
SERIAL1.RX
Text GLabel 2800 2100 3    50   Input ~ 0
SERIAL1.TX
Wire Wire Line
	2800 2100 2800 2000
Wire Wire Line
	2700 2100 2700 2000
Text GLabel 2450 5750 2    50   Input ~ 0
SERIAL1.RX
Wire Wire Line
	2450 5750 2350 5750
Wire Wire Line
	2450 5350 2350 5350
NoConn ~ 2350 3650
NoConn ~ 2350 3750
NoConn ~ 2350 3850
NoConn ~ 2350 3950
NoConn ~ 2350 4050
NoConn ~ 2350 4150
NoConn ~ 2350 4250
NoConn ~ 2350 4550
NoConn ~ 2350 4650
NoConn ~ 2350 4750
NoConn ~ 2350 4850
NoConn ~ 2350 4950
NoConn ~ 2350 5050
NoConn ~ 2350 5150
NoConn ~ 2350 5550
NoConn ~ 2350 5650
NoConn ~ 2350 5950
NoConn ~ 2350 6550
NoConn ~ 2350 6650
$EndSCHEMATC
