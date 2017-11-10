//POVRay-fájl készítés mint 3d41.ulp v20110101
//C:/Users/Tamás/Documents/eagle/fejhallgatóamp/Headamp.brd
//2017.11.10. 15:39:41

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

#declare global_use_radiosity = on;

#declare global_ambient_mul = 1;
#declare global_ambient_mul_emit = 0;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 2;
#declare pin_short = on;

#declare e3d_environment = on;

#local cam_x = 0;
#local cam_y = 128;
#local cam_z = -68;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -2;
#local cam_look_z = 0;

#local pcb_rotate_x = 0;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#local pcb_wire_bridges = off;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 13;
#local lgt1_pos_y = 20;
#local lgt1_pos_z = 15;
#local lgt1_intense = 0.715161;
#local lgt2_pos_x = -13;
#local lgt2_pos_y = 20;
#local lgt2_pos_z = 15;
#local lgt2_intense = 0.715161;
#local lgt3_pos_x = 13;
#local lgt3_pos_y = 20;
#local lgt3_pos_z = -10;
#local lgt3_intense = 0.715161;
#local lgt4_pos_x = -13;
#local lgt4_pos_y = 20;
#local lgt4_pos_z = -10;
#local lgt4_intense = 0.715161;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 35.560000;
#declare pcb_y_size = 29.845000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(619);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "e3d_tools.inc"
#include "e3d_user.inc"

global_settings{charset utf8}

#if(e3d_environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Adat animációhoz
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "Nincs elegendõ animációs adat (min. 3 pont kell) (Berepülés útvonala)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "Nincs elegendõ animációs adat (min. 3 pont kell) (Nézet útvonala)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-17.780000,0,-14.922500>
}
#end

background{col_bgr}
light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro HEADAMP(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Panel
prism{-1.500000,0.000000,8
<40.005000,16.510000><75.565000,16.510000>
<75.565000,16.510000><75.565000,46.355000>
<75.565000,46.355000><40.005000,46.355000>
<40.005000,46.355000><40.005000,16.510000>
texture{col_brd}}
}//End union(PCB)
//Furatok(valós)/Alkatrészek
//Furatok(valós)/Panel
//Furatok(valós)/Átvezetések
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Alkatrészek
union{
#ifndef(pack_C1) #declare global_pack_C1=yes; object {CAP_SMD_CHIP_0805()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<60.325000,0.000000,23.495000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C1 220p C3216
#ifndef(pack_C2) #declare global_pack_C2=yes; object {CAP_SMD_CHIP_0805()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<69.215000,0.000000,23.495000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C2 3,3uf C3216
#ifndef(pack_C3) #declare global_pack_C3=yes; object {CAP_SMD_CHIP_1206()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<60.325000,0.000000,41.910000>translate<0,0.035000,0> }#end		//SMD Capacitor 1206 C3 220p C3216
#ifndef(pack_C4) #declare global_pack_C4=yes; object {CAP_SMD_CHIP_0805()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<69.215000,0.000000,41.275000>translate<0,0.035000,0> }#end		//SMD Capacitor 0805 C4 3,3uf C3216
#ifndef(pack_E_1) #declare global_pack_E_1=yes; object {IC_SMD_SO8("APA2305","PHILIPS",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<63.500000,0.000000,32.893000>translate<0,0.035000,0> }#end		//SMD IC SO8 Package E$1 APA2305 SO08-208
#ifndef(pack_E_2) #declare global_pack_E_2=yes; object {CON_PH_1X2()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<43.180000,0.000000,39.370000>}#end		//Header 2,54mm Grid 2Pin 1Row (jumper.lib) E$2  1X02
#ifndef(pack_E_3) #declare global_pack_E_3=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<66.675000,0.000000,41.275000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 E$3 10k M3516
#ifndef(pack_E_4) #declare global_pack_E_4=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<66.040000,0.000000,24.130000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 E$4 10k M3516
#ifndef(pack_E_5) #declare global_pack_E_5=yes; object {CON_PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<69.215000,0.000000,29.845000>}#end		//Header 2,54mm Grid 3Pin 1Row (jumper.lib) E$5  1X03
#ifndef(pack_E_6) #declare global_pack_E_6=yes; object {CON_PH_1X3()translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<44.450000,0.000000,27.940000>}#end		//Header 2,54mm Grid 3Pin 1Row (jumper.lib) E$6  1X03
#ifndef(pack_E_10) #declare global_pack_E_10=yes; object {CAP_SMD_ELKO_PANASONIC_B("100uF",)translate<0,0,0> rotate<0,180.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<50.165000,0.000000,40.640000>translate<0,0.035000,0> }#end		//SMD Elko Panasonic B (rcl.lib) E$10 100uF SANYO-OSCON_SMD_C6
#ifndef(pack_E_11) #declare global_pack_E_11=yes; object {CAP_SMD_ELKO_PANASONIC_B("47uF",)translate<0,0,0> rotate<0,180.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<50.165000,0.000000,32.385000>translate<0,0.035000,0> }#end		//SMD Elko Panasonic B (rcl.lib) E$11 47uF SANYO-OSCON_SMD_C6
#ifndef(pack_E_12) #declare global_pack_E_12=yes; object {CAP_SMD_ELKO_PANASONIC_B("100uF",)translate<0,0,0> rotate<0,180.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<50.165000,0.000000,24.765000>translate<0,0.035000,0> }#end		//SMD Elko Panasonic B (rcl.lib) E$12 100uF SANYO-OSCON_SMD_C6
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<63.500000,0.000000,24.130000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R1 10k M3516
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_SMD_CHIP_0805("332",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<57.785000,0.000000,24.130000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R2 3k3 M3516
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_SMD_CHIP_0805("332",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<57.785000,0.000000,41.275000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R3 3k3 M3516
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_SMD_CHIP_0805("103",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<64.135000,0.000000,41.275000>translate<0,0.035000,0> }#end		//SMD Resistor 0805 R4 10k M3516
}//End union
#end
#if(pcb_pads_smds=on)
//Forrfelületek és SMD/Alkatrészek
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<60.325000,0.000000,22.095000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<60.325000,0.000000,24.895000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<69.215000,0.000000,22.095000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<69.215000,0.000000,24.895000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<60.325000,0.000000,40.510000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<60.325000,0.000000,43.310000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<69.215000,0.000000,39.875000>}
object{TOOLS_PCB_SMD(1.600000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<69.215000,0.000000,42.675000>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<61.595000,0.000000,29.394600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<62.865000,0.000000,29.394600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<64.135000,0.000000,29.394600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<65.405000,0.000000,29.394600>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<65.405000,0.000000,36.391400>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<64.135000,0.000000,36.391400>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<62.865000,0.000000,36.391400>}
object{TOOLS_PCB_SMD(0.660400,2.032000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<61.595000,0.000000,36.391400>}
#ifndef(global_pack_E_2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<43.180000,0,38.100000> texture{col_thl}}
#ifndef(global_pack_E_2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<43.180000,0,40.640000> texture{col_thl}}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<66.675000,0.000000,39.575000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<66.675000,0.000000,42.975000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<66.040000,0.000000,22.430000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<66.040000,0.000000,25.830000>}
#ifndef(global_pack_E_5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<69.215000,0,32.385000> texture{col_thl}}
#ifndef(global_pack_E_5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<69.215000,0,29.845000> texture{col_thl}}
#ifndef(global_pack_E_5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<69.215000,0,27.305000> texture{col_thl}}
#ifndef(global_pack_E_6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<44.450000,0,25.400000> texture{col_thl}}
#ifndef(global_pack_E_6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<44.450000,0,27.940000> texture{col_thl}}
#ifndef(global_pack_E_6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-180.000000,0>translate<44.450000,0,30.480000> texture{col_thl}}
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<52.965000,0.000000,40.640000>}
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<47.365000,0.000000,40.640000>}
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<52.965000,0.000000,32.385000>}
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<47.365000,0.000000,32.385000>}
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<52.965000,0.000000,24.765000>}
object{TOOLS_PCB_SMD(3.500000,1.600000,0.037000,0) rotate<0,-0.000000,0> texture{col_pds} translate<47.365000,0.000000,24.765000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.500000,0.000000,22.430000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<63.500000,0.000000,25.830000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<57.785000,0.000000,22.430000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<57.785000,0.000000,25.830000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<57.785000,0.000000,39.575000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<57.785000,0.000000,42.975000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<64.135000,0.000000,39.575000>}
object{TOOLS_PCB_SMD(1.400000,1.800000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<64.135000,0.000000,42.975000>}
//Forrfelület/Átvezetés
#end
#if(pcb_wires=on)
union{
//Jelek
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.545000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.545000,0.000000,36.195000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,90.000000,0> translate<42.545000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.545000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,36.830000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<42.545000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,38.100000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.180000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.545000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,40.640000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<42.545000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,33.655000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.815000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,37.465000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.180000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,37.465000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<43.180000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,41.275000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.180000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,41.910000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<43.815000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,0.000000,25.400000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.815000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,0.000000,30.480000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.815000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,0.000000,24.765000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<44.450000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,0.000000,25.400000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.450000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.450000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,0.000000,30.480000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.450000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,0.000000,43.180000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.815000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,0.000000,24.765000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.085000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.545000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,0.000000,27.940000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<42.545000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,0.000000,31.750000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<46.355000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.815000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,0.000000,36.195000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.815000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,0.000000,40.005000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,90.000000,0> translate<46.355000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.085000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,0.000000,43.180000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<45.085000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.355000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,0.000000,27.940000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.355000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,0.000000,20.955000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,-90.000000,0> translate<50.165000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.530000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,0.000000,27.305000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<49.530000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,0.000000,34.290000>}
box{<0,0,-0.304800><7.620000,0.035000,0.304800> rotate<0,-90.000000,0> translate<50.165000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.895000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,0.000000,41.910000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<48.895000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,0.000000,19.685000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<50.165000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.165000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,0.000000,33.020000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<50.165000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,0.000000,24.765000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.610000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.610000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,0.000000,40.640000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<54.610000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.515000,0.000000,26.035000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.245000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.245000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.515000,0.000000,39.370000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<55.245000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.515000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,26.035000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<56.515000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,26.670000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.420000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,0.000000,27.940000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<58.420000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<53.975000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,0.000000,32.385000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,0.000000,0> translate<53.975000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,22.225000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.785000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.420000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,25.400000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<58.420000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.515000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,39.370000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<56.515000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,40.005000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.325000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.785000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,43.815000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.785000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,43.815000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<60.325000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,27.940000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.055000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,38.735000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<60.325000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,42.545000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.325000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,0.000000,28.575000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.960000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.055000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,0.000000,34.925000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<59.055000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,0.000000,36.195000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<61.595000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,0.000000,38.735000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.960000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,26.035000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<62.865000,-1.535000,25.400000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,-90.000000,0> translate<62.865000,-1.535000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,0.000000,28.575000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,90.000000,0> translate<62.865000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,0.000000,36.830000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.865000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.595000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.865000,0.000000,37.465000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<61.595000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,0.000000,22.860000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,-90.000000,0> translate<63.500000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.325000,0.000000,22.225000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,0.000000,25.400000>}
box{<0,0,-0.304800><4.490128,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.325000,0.000000,22.225000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.960000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,0.000000,40.005000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<60.960000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.435000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,0.000000,19.685000>}
box{<0,0,-0.304800><12.700000,0.035000,0.304800> rotate<0,0.000000,0> translate<51.435000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,0.000000,28.575000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<64.135000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,0.000000,39.370000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<64.135000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,0.000000,27.940000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<64.135000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,0.000000,26.670000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-90.000000,0> translate<65.405000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.770000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,0.000000,27.305000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<64.770000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,-1.535000,36.195000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-90.000000,0> translate<65.405000,-1.535000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,0.000000,36.830000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-90.000000,0> translate<65.405000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,0.000000,41.275000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<64.135000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,0.000000,20.955000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,-90.000000,0> translate<66.040000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.135000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,0.000000,21.590000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.135000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.675000,0.000000,38.735000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<65.405000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.675000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.675000,0.000000,39.370000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<66.675000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.040000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,0.000000,19.685000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<66.040000,0.000000,20.955000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.500000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,0.000000,24.130000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<63.500000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,0.000000,28.575000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<65.405000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,22.860000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<67.310000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,29.845000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<67.310000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.405000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,41.275000>}
box{<0,0,-0.304800><3.175000,0.035000,0.304800> rotate<0,0.000000,0> translate<65.405000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,41.910000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,90.000000,0> translate<68.580000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,27.305000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<68.580000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,27.305000>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.215000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,32.385000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,-90.000000,0> translate<69.215000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,33.020000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<68.580000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,34.290000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.215000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,39.370000>}
box{<0,0,-0.304800><5.080000,0.035000,0.304800> rotate<0,90.000000,0> translate<69.215000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,42.545000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<68.580000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.215000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,0.000000,27.305000>}
box{<0,0,-0.304800><0.635000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.215000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,0.000000,29.845000>}
box{<0,0,-0.304800><1.270000,0.035000,0.304800> rotate<0,0.000000,0> translate<68.580000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.580000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.485000,0.000000,32.385000>}
box{<0,0,-0.304800><1.905000,0.035000,0.304800> rotate<0,0.000000,0> translate<68.580000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.310000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,0.000000,19.685000>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<67.310000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.120000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,20.955000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.120000,0.000000,19.685000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.850000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,27.305000>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,44.997030,0> translate<69.850000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,20.955000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,27.305000>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<72.390000,0.000000,27.305000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Sokszögek
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,37.408200>}
box{<0,0,-0.304800><12.643200,0.035000,0.304800> rotate<0,90.000000,0> translate<41.275000,0.000000,37.408200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,0.000000,17.780000>}
box{<0,0,-0.304800><9.878282,0.035000,0.304800> rotate<0,44.997030,0> translate<41.275000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,24.993600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.426600,0.000000,24.993600>}
box{<0,0,-0.304800><1.151600,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,24.993600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.367200,0.000000,25.603200>}
box{<0,0,-0.304800><1.092200,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.633000,0.000000,26.212800>}
box{<0,0,-0.304800><1.358000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.937700,0.000000,26.822400>}
box{<0,0,-0.304800><1.662700,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.831700,0.000000,27.432000>}
box{<0,0,-0.304800><0.556700,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,28.041600>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,28.651200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,28.651200>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,28.651200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,29.260800>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,29.870400>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,30.480000>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,31.089600>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,31.699200>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,32.308800>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,32.918400>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,33.528000>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,34.137600>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,34.747200>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,35.356800>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,35.966400>}
box{<0,0,-0.304800><0.406400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.768100,0.000000,36.576000>}
box{<0,0,-0.304800><0.493100,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.464500,0.000000,37.185600>}
box{<0,0,-0.304800><0.189500,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,37.408200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.298300,0.000000,37.351800>}
box{<0,0,-0.304800><0.061023,0.035000,0.304800> rotate<0,67.549015,0> translate<41.275000,0.000000,37.408200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,38.791700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,39.948200>}
box{<0,0,-0.304800><1.156500,0.035000,0.304800> rotate<0,90.000000,0> translate<41.275000,0.000000,39.948200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,38.791700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.298300,0.000000,38.848100>}
box{<0,0,-0.304800><0.061023,0.035000,0.304800> rotate<0,-67.549015,0> translate<41.275000,0.000000,38.791700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.464600,0.000000,39.014400>}
box{<0,0,-0.304800><0.189600,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.566100,0.000000,39.624000>}
box{<0,0,-0.304800><0.291100,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,39.948200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.298300,0.000000,39.891800>}
box{<0,0,-0.304800><0.061023,0.035000,0.304800> rotate<0,67.549015,0> translate<41.275000,0.000000,39.948200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,41.331700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,43.180000>}
box{<0,0,-0.304800><1.848300,0.035000,0.304800> rotate<0,90.000000,0> translate<41.275000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,41.331700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.298300,0.000000,41.388100>}
box{<0,0,-0.304800><0.061023,0.035000,0.304800> rotate<0,-67.549015,0> translate<41.275000,0.000000,41.331700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.363000,0.000000,41.452800>}
box{<0,0,-0.304800><0.088000,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.951400,0.000000,42.062400>}
box{<0,0,-0.304800><1.676400,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.355900,0.000000,42.672000>}
box{<0,0,-0.304800><2.080900,0.035000,0.304800> rotate<0,0.000000,0> translate<41.275000,0.000000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.275000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,45.085000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.275000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.298300,0.000000,37.351800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.669800,0.000000,36.980300>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,44.997030,0> translate<41.298300,0.000000,37.351800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.298300,0.000000,38.848100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.669800,0.000000,39.219600>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.298300,0.000000,38.848100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.298300,0.000000,39.891800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.669800,0.000000,39.520300>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,44.997030,0> translate<41.298300,0.000000,39.891800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.298300,0.000000,41.388100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.669800,0.000000,41.759600>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,-44.997030,0> translate<41.298300,0.000000,41.388100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.376600,0.000000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.965500,0.000000,43.281600>}
box{<0,0,-0.304800><2.588900,0.035000,0.304800> rotate<0,0.000000,0> translate<41.376600,0.000000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.656000,0.000000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.836100,0.000000,24.384000>}
box{<0,0,-0.304800><1.180100,0.035000,0.304800> rotate<0,0.000000,0> translate<41.656000,0.000000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.669800,0.000000,36.980300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.980500,0.000000,36.851600>}
box{<0,0,-0.304800><0.336301,0.035000,0.304800> rotate<0,22.499120,0> translate<41.669800,0.000000,36.980300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.669800,0.000000,39.219600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.032800,0.000000,39.369900>}
box{<0,0,-0.304800><0.392886,0.035000,0.304800> rotate<0,-22.490496,0> translate<41.669800,0.000000,39.219600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.669800,0.000000,39.520300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.032800,0.000000,39.369900>}
box{<0,0,-0.304800><0.392924,0.035000,0.304800> rotate<0,22.503968,0> translate<41.669800,0.000000,39.520300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.669800,0.000000,41.759600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.155200,0.000000,41.960700>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,-22.502619,0> translate<41.669800,0.000000,41.759600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,27.768100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.812900,0.000000,27.450800>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,67.484752,0> translate<41.681400,0.000000,27.768100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,36.366800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,27.768100>}
box{<0,0,-0.304800><8.598700,0.035000,0.304800> rotate<0,-90.000000,0> translate<41.681400,0.000000,27.768100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.681400,0.000000,36.366800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.812900,0.000000,36.684100>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-67.484752,0> translate<41.681400,0.000000,36.366800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.812900,0.000000,27.450800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.055800,0.000000,27.207900>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,44.997030,0> translate<41.812900,0.000000,27.450800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.812900,0.000000,36.684100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.980500,0.000000,36.851600>}
box{<0,0,-0.304800><0.236951,0.035000,0.304800> rotate<0,-44.979933,0> translate<41.812900,0.000000,36.684100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<41.986200,0.000000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.575000,0.000000,43.891200>}
box{<0,0,-0.304800><2.588800,0.035000,0.304800> rotate<0,0.000000,0> translate<41.986200,0.000000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.055800,0.000000,27.207900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.373100,0.000000,27.076400>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,22.509308,0> translate<42.055800,0.000000,27.207900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.155200,0.000000,41.960700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.951400,0.000000,41.960700>}
box{<0,0,-0.304800><0.796200,0.035000,0.304800> rotate<0,0.000000,0> translate<42.155200,0.000000,41.960700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.265600,0.000000,23.774400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,23.774400>}
box{<0,0,-0.304800><2.790600,0.035000,0.304800> rotate<0,0.000000,0> translate<42.265600,0.000000,23.774400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.367200,0.000000,25.137200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.568300,0.000000,24.651800>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,67.491441,0> translate<42.367200,0.000000,25.137200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.367200,0.000000,25.662700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.367200,0.000000,25.137200>}
box{<0,0,-0.304800><0.525500,0.035000,0.304800> rotate<0,-90.000000,0> translate<42.367200,0.000000,25.137200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.367200,0.000000,25.662700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.568300,0.000000,26.148100>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,-67.491441,0> translate<42.367200,0.000000,25.662700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.373100,0.000000,27.076400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.683800,0.000000,27.076400>}
box{<0,0,-0.304800><0.310700,0.035000,0.304800> rotate<0,0.000000,0> translate<42.373100,0.000000,27.076400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.568300,0.000000,24.651800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.939800,0.000000,24.280300>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,44.997030,0> translate<42.568300,0.000000,24.651800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.568300,0.000000,26.148100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.939800,0.000000,26.519600>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,-44.997030,0> translate<42.568300,0.000000,26.148100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.595800,0.000000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.249600,0.000000,44.500800>}
box{<0,0,-0.304800><14.653800,0.035000,0.304800> rotate<0,0.000000,0> translate<42.595800,0.000000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.683800,0.000000,27.076400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.939800,0.000000,26.820300>}
box{<0,0,-0.304800><0.362109,0.035000,0.304800> rotate<0,45.008218,0> translate<42.683800,0.000000,27.076400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.875200,0.000000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,23.164800>}
box{<0,0,-0.304800><6.426200,0.035000,0.304800> rotate<0,0.000000,0> translate<42.875200,0.000000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.939800,0.000000,24.280300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.425200,0.000000,24.079200>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,22.502619,0> translate<42.939800,0.000000,24.280300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.939800,0.000000,26.519600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.302900,0.000000,26.669900>}
box{<0,0,-0.304800><0.392978,0.035000,0.304800> rotate<0,-22.484919,0> translate<42.939800,0.000000,26.519600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.939800,0.000000,26.820300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.302900,0.000000,26.669900>}
box{<0,0,-0.304800><0.393016,0.035000,0.304800> rotate<0,22.498388,0> translate<42.939800,0.000000,26.820300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.951400,0.000000,42.081800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.951400,0.000000,41.960700>}
box{<0,0,-0.304800><0.121100,0.035000,0.304800> rotate<0,-90.000000,0> translate<42.951400,0.000000,41.960700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<42.951400,0.000000,42.081800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.082900,0.000000,42.399100>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-67.484752,0> translate<42.951400,0.000000,42.081800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.082900,0.000000,42.399100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.325800,0.000000,42.642000>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.082900,0.000000,42.399100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.180000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,45.085000>}
box{<0,0,-0.304800><29.210000,0.035000,0.304800> rotate<0,0.000000,0> translate<43.180000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.325800,0.000000,42.642000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.325900,0.000000,42.642000>}
box{<0,0,-0.304800><0.000100,0.035000,0.304800> rotate<0,0.000000,0> translate<43.325800,0.000000,42.642000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.325900,0.000000,42.642000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.352900,0.000000,43.669100>}
box{<0,0,-0.304800><1.452468,0.035000,0.304800> rotate<0,-44.999819,0> translate<43.325900,0.000000,42.642000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.408500,0.000000,34.469600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.408500,0.000000,35.837300>}
box{<0,0,-0.304800><1.367700,0.035000,0.304800> rotate<0,90.000000,0> translate<43.408500,0.000000,35.837300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.408500,0.000000,34.469600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.491400,0.000000,36.552600>}
box{<0,0,-0.304800><2.945736,0.035000,0.304800> rotate<0,-44.998405,0> translate<43.408500,0.000000,34.469600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.408500,0.000000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.686100,0.000000,34.747200>}
box{<0,0,-0.304800><0.277600,0.035000,0.304800> rotate<0,0.000000,0> translate<43.408500,0.000000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.408500,0.000000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.295700,0.000000,35.356800>}
box{<0,0,-0.304800><0.887200,0.035000,0.304800> rotate<0,0.000000,0> translate<43.408500,0.000000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.408500,0.000000,35.837300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.669100,0.000000,36.097900>}
box{<0,0,-0.304800><0.368544,0.035000,0.304800> rotate<0,-44.997030,0> translate<43.408500,0.000000,35.837300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.425200,0.000000,24.079200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.549500,0.000000,24.079200>}
box{<0,0,-0.304800><1.124300,0.035000,0.304800> rotate<0,0.000000,0> translate<43.425200,0.000000,24.079200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.484800,0.000000,22.555200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,22.555200>}
box{<0,0,-0.304800><5.816600,0.035000,0.304800> rotate<0,0.000000,0> translate<43.484800,0.000000,22.555200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.537600,0.000000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.905300,0.000000,35.966400>}
box{<0,0,-0.304800><1.367700,0.035000,0.304800> rotate<0,0.000000,0> translate<43.537600,0.000000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<43.669100,0.000000,36.097900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.453400,0.000000,36.882300>}
box{<0,0,-0.304800><1.109238,0.035000,0.304800> rotate<0,-45.000682,0> translate<43.669100,0.000000,36.097900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.094400,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,21.945600>}
box{<0,0,-0.304800><5.207000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.094400,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.147100,0.000000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.491400,0.000000,36.576000>}
box{<0,0,-0.304800><1.344300,0.035000,0.304800> rotate<0,0.000000,0> translate<44.147100,0.000000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.327100,0.000000,39.369900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.690100,0.000000,39.219600>}
box{<0,0,-0.304800><0.392886,0.035000,0.304800> rotate<0,22.490496,0> translate<44.327100,0.000000,39.369900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.327100,0.000000,39.369900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.690100,0.000000,39.520300>}
box{<0,0,-0.304800><0.392924,0.035000,0.304800> rotate<0,-22.503968,0> translate<44.327100,0.000000,39.369900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.352900,0.000000,43.669100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.595800,0.000000,43.912000>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.352900,0.000000,43.669100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.453400,0.000000,36.882300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.690100,0.000000,36.980300>}
box{<0,0,-0.304800><0.256185,0.035000,0.304800> rotate<0,-22.489352,0> translate<44.453400,0.000000,36.882300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.549500,0.000000,24.079200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.595800,0.000000,24.032900>}
box{<0,0,-0.304800><0.065478,0.035000,0.304800> rotate<0,44.997030,0> translate<44.549500,0.000000,24.079200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.595800,0.000000,24.032900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.913100,0.000000,23.901400>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,22.509308,0> translate<44.595800,0.000000,24.032900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.595800,0.000000,43.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.913100,0.000000,44.043500>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-22.509308,0> translate<44.595800,0.000000,43.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.678500,0.000000,31.800700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.678500,0.000000,33.297300>}
box{<0,0,-0.304800><1.496600,0.035000,0.304800> rotate<0,90.000000,0> translate<44.678500,0.000000,33.297300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.678500,0.000000,31.800700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,31.800700>}
box{<0,0,-0.304800><0.377700,0.035000,0.304800> rotate<0,0.000000,0> translate<44.678500,0.000000,31.800700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.678500,0.000000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,32.308800>}
box{<0,0,-0.304800><0.377700,0.035000,0.304800> rotate<0,0.000000,0> translate<44.678500,0.000000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.678500,0.000000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,32.918400>}
box{<0,0,-0.304800><0.377700,0.035000,0.304800> rotate<0,0.000000,0> translate<44.678500,0.000000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.678500,0.000000,33.297300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.087000,0.000000,35.705800>}
box{<0,0,-0.304800><3.406133,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.678500,0.000000,33.297300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.690100,0.000000,36.980300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.061600,0.000000,37.351800>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,-44.997030,0> translate<44.690100,0.000000,36.980300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.690100,0.000000,39.219600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.061600,0.000000,38.848100>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,44.997030,0> translate<44.690100,0.000000,39.219600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.690100,0.000000,39.520300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,39.886500>}
box{<0,0,-0.304800><0.517814,0.035000,0.304800> rotate<0,-45.004854,0> translate<44.690100,0.000000,39.520300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.704000,0.000000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,21.336000>}
box{<0,0,-0.304800><4.597400,0.035000,0.304800> rotate<0,0.000000,0> translate<44.704000,0.000000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.787900,0.000000,41.661800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,41.393400>}
box{<0,0,-0.304800><0.379504,0.035000,0.304800> rotate<0,45.007705,0> translate<44.787900,0.000000,41.661800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.787900,0.000000,41.661800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.442600,0.000000,42.316400>}
box{<0,0,-0.304800><0.925815,0.035000,0.304800> rotate<0,-44.992654,0> translate<44.787900,0.000000,41.661800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.793700,0.000000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,39.624000>}
box{<0,0,-0.304800><0.262500,0.035000,0.304800> rotate<0,0.000000,0> translate<44.793700,0.000000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.895300,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.491400,0.000000,39.014400>}
box{<0,0,-0.304800><0.596100,0.035000,0.304800> rotate<0,0.000000,0> translate<44.895300,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.895400,0.000000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.491400,0.000000,37.185600>}
box{<0,0,-0.304800><0.596000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.895400,0.000000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.909200,0.000000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.167800,0.000000,33.528000>}
box{<0,0,-0.304800><0.258600,0.035000,0.304800> rotate<0,0.000000,0> translate<44.909200,0.000000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.913100,0.000000,23.901400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,23.901400>}
box{<0,0,-0.304800><0.143100,0.035000,0.304800> rotate<0,0.000000,0> translate<44.913100,0.000000,23.901400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.913100,0.000000,44.043500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.723100,0.000000,44.043500>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<44.913100,0.000000,44.043500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<44.996900,0.000000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,41.452800>}
box{<0,0,-0.304800><0.059300,0.035000,0.304800> rotate<0,0.000000,0> translate<44.996900,0.000000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,23.733500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.383500,0.000000,23.406200>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<45.056200,0.000000,23.733500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,23.901400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,23.733500>}
box{<0,0,-0.304800><0.167900,0.035000,0.304800> rotate<0,-90.000000,0> translate<45.056200,0.000000,23.733500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,33.416400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,31.800700>}
box{<0,0,-0.304800><1.615700,0.035000,0.304800> rotate<0,-90.000000,0> translate<45.056200,0.000000,31.800700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,33.416400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.383500,0.000000,33.743700>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<45.056200,0.000000,33.416400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,39.608500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.383500,0.000000,39.281200>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<45.056200,0.000000,39.608500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,39.886500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,39.608500>}
box{<0,0,-0.304800><0.278000,0.035000,0.304800> rotate<0,-90.000000,0> translate<45.056200,0.000000,39.608500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,41.671400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,41.393400>}
box{<0,0,-0.304800><0.278000,0.035000,0.304800> rotate<0,-90.000000,0> translate<45.056200,0.000000,41.393400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.056200,0.000000,41.671400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.383500,0.000000,41.998700>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<45.056200,0.000000,41.671400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.061600,0.000000,37.351800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.262700,0.000000,37.837200>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,-67.491441,0> translate<45.061600,0.000000,37.351800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.061600,0.000000,38.848100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.262700,0.000000,38.362700>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,67.491441,0> translate<45.061600,0.000000,38.848100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.188500,0.000000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.791300,0.000000,42.062400>}
box{<0,0,-0.304800><3.602800,0.035000,0.304800> rotate<0,0.000000,0> translate<45.188500,0.000000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.245200,0.000000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.491400,0.000000,37.795200>}
box{<0,0,-0.304800><0.246200,0.035000,0.304800> rotate<0,0.000000,0> translate<45.245200,0.000000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.245300,0.000000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.491400,0.000000,38.404800>}
box{<0,0,-0.304800><0.246100,0.035000,0.304800> rotate<0,0.000000,0> translate<45.245300,0.000000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.262700,0.000000,37.837200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.262700,0.000000,38.362700>}
box{<0,0,-0.304800><0.525500,0.035000,0.304800> rotate<0,90.000000,0> translate<45.262700,0.000000,38.362700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.313600,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.324800,0.000000,20.726400>}
box{<0,0,-0.304800><4.011200,0.035000,0.304800> rotate<0,0.000000,0> translate<45.313600,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.383500,0.000000,23.406200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,23.406200>}
box{<0,0,-0.304800><3.917900,0.035000,0.304800> rotate<0,0.000000,0> translate<45.383500,0.000000,23.406200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.383500,0.000000,33.743700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.346400,0.000000,33.743700>}
box{<0,0,-0.304800><3.962900,0.035000,0.304800> rotate<0,0.000000,0> translate<45.383500,0.000000,33.743700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.383500,0.000000,39.281200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.491400,0.000000,39.281200>}
box{<0,0,-0.304800><0.107900,0.035000,0.304800> rotate<0,0.000000,0> translate<45.383500,0.000000,39.281200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.383500,0.000000,41.998700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.855100,0.000000,41.998700>}
box{<0,0,-0.304800><3.471600,0.035000,0.304800> rotate<0,0.000000,0> translate<45.383500,0.000000,41.998700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.442600,0.000000,42.316400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.537300,0.000000,42.316400>}
box{<0,0,-0.304800><3.094700,0.035000,0.304800> rotate<0,0.000000,0> translate<45.442600,0.000000,42.316400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.491400,0.000000,39.281200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.491400,0.000000,36.552600>}
box{<0,0,-0.304800><2.728600,0.035000,0.304800> rotate<0,-90.000000,0> translate<45.491400,0.000000,36.552600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.518800,0.000000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,34.137600>}
box{<0,0,-0.304800><3.782600,0.035000,0.304800> rotate<0,0.000000,0> translate<45.518800,0.000000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.597000,0.000000,26.669900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.960100,0.000000,26.519600>}
box{<0,0,-0.304800><0.392978,0.035000,0.304800> rotate<0,22.484919,0> translate<45.597000,0.000000,26.669900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.597000,0.000000,26.669900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.960100,0.000000,26.820300>}
box{<0,0,-0.304800><0.393016,0.035000,0.304800> rotate<0,-22.498388,0> translate<45.597000,0.000000,26.669900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.923200,0.000000,20.116800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.781900,0.000000,20.116800>}
box{<0,0,-0.304800><3.858700,0.035000,0.304800> rotate<0,0.000000,0> translate<45.923200,0.000000,20.116800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.960100,0.000000,26.519600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.331600,0.000000,26.148100>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,44.997030,0> translate<45.960100,0.000000,26.519600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.960100,0.000000,26.820300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.216100,0.000000,27.076400>}
box{<0,0,-0.304800><0.362109,0.035000,0.304800> rotate<0,-45.008218,0> translate<45.960100,0.000000,26.820300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<45.962100,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,26.822400>}
box{<0,0,-0.304800><3.339300,0.035000,0.304800> rotate<0,0.000000,0> translate<45.962100,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.128400,0.000000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,34.747200>}
box{<0,0,-0.304800><3.173000,0.035000,0.304800> rotate<0,0.000000,0> translate<46.128400,0.000000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.216100,0.000000,27.076400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.172300,0.000000,27.076400>}
box{<0,0,-0.304800><2.956200,0.035000,0.304800> rotate<0,0.000000,0> translate<46.216100,0.000000,27.076400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.266900,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,26.212800>}
box{<0,0,-0.304800><3.034500,0.035000,0.304800> rotate<0,0.000000,0> translate<46.266900,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.331600,0.000000,26.148100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.341600,0.000000,26.123700>}
box{<0,0,-0.304800><0.026370,0.035000,0.304800> rotate<0,67.709943,0> translate<46.331600,0.000000,26.148100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.341600,0.000000,26.123700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,26.123700>}
box{<0,0,-0.304800><2.959800,0.035000,0.304800> rotate<0,0.000000,0> translate<46.341600,0.000000,26.123700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.532800,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.391500,0.000000,19.507200>}
box{<0,0,-0.304800><3.858700,0.035000,0.304800> rotate<0,0.000000,0> translate<46.532800,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<46.738000,0.000000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,35.356800>}
box{<0,0,-0.304800><2.563400,0.035000,0.304800> rotate<0,0.000000,0> translate<46.738000,0.000000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.087000,0.000000,35.705800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,36.023100>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-67.484752,0> translate<47.087000,0.000000,35.705800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.142400,0.000000,18.897600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.079200,0.000000,18.897600>}
box{<0,0,-0.304800><3.936800,0.035000,0.304800> rotate<0,0.000000,0> translate<47.142400,0.000000,18.897600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.195000,0.000000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,35.966400>}
box{<0,0,-0.304800><2.106400,0.035000,0.304800> rotate<0,0.000000,0> translate<47.195000,0.000000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,28.803500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,31.026200>}
box{<0,0,-0.304800><2.222700,0.035000,0.304800> rotate<0,90.000000,0> translate<47.218500,0.000000,31.026200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,28.803500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.358100,0.000000,28.803500>}
box{<0,0,-0.304800><2.139600,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,28.803500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,29.260800>}
box{<0,0,-0.304800><13.487500,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,29.870400>}
box{<0,0,-0.304800><13.487500,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,30.480000>}
box{<0,0,-0.304800><13.487500,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,31.026200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.346400,0.000000,31.026200>}
box{<0,0,-0.304800><2.127900,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,31.026200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,36.023100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,36.366800>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,90.000000,0> translate<47.218500,0.000000,36.366800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,36.366800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,39.281200>}
box{<0,0,-0.304800><2.914400,0.035000,0.304800> rotate<0,90.000000,0> translate<47.218500,0.000000,39.281200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,36.576000>}
box{<0,0,-0.304800><2.082900,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,37.185600>}
box{<0,0,-0.304800><2.082900,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,37.795200>}
box{<0,0,-0.304800><2.082900,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,38.404800>}
box{<0,0,-0.304800><2.082900,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,39.014400>}
box{<0,0,-0.304800><2.082900,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.218500,0.000000,39.281200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,39.281200>}
box{<0,0,-0.304800><2.082900,0.035000,0.304800> rotate<0,0.000000,0> translate<47.218500,0.000000,39.281200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<47.752000,0.000000,18.288000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.898000,0.000000,18.288000>}
box{<0,0,-0.304800><25.146000,0.035000,0.304800> rotate<0,0.000000,0> translate<47.752000,0.000000,18.288000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.260000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,17.780000>}
box{<0,0,-0.304800><24.130000,0.035000,0.304800> rotate<0,0.000000,0> translate<48.260000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.537300,0.000000,42.316400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.855100,0.000000,41.998700>}
box{<0,0,-0.304800><0.449366,0.035000,0.304800> rotate<0,44.988015,0> translate<48.537300,0.000000,42.316400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<48.723100,0.000000,44.043500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.066800,0.000000,44.043500>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,0.000000,0> translate<48.723100,0.000000,44.043500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.066800,0.000000,44.043500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.384100,0.000000,43.912000>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,22.509308,0> translate<49.066800,0.000000,44.043500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.172300,0.000000,27.076400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,26.947300>}
box{<0,0,-0.304800><0.182575,0.035000,0.304800> rotate<0,44.997030,0> translate<49.172300,0.000000,27.076400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,20.783100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.432900,0.000000,20.465800>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,67.484752,0> translate<49.301400,0.000000,20.783100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,21.126800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,20.783100>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,-90.000000,0> translate<49.301400,0.000000,20.783100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,23.406200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,21.126800>}
box{<0,0,-0.304800><2.279400,0.035000,0.304800> rotate<0,-90.000000,0> translate<49.301400,0.000000,21.126800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,26.947300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,26.123700>}
box{<0,0,-0.304800><0.823600,0.035000,0.304800> rotate<0,-90.000000,0> translate<49.301400,0.000000,26.123700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,34.118100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.432900,0.000000,33.800800>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,67.484752,0> translate<49.301400,0.000000,34.118100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,34.461800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,34.118100>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,-90.000000,0> translate<49.301400,0.000000,34.118100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,39.281200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.301400,0.000000,34.461800>}
box{<0,0,-0.304800><4.819400,0.035000,0.304800> rotate<0,-90.000000,0> translate<49.301400,0.000000,34.461800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.346400,0.000000,31.026200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.673700,0.000000,31.353500>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<49.346400,0.000000,31.026200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.346400,0.000000,33.743700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.673700,0.000000,33.416400>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<49.346400,0.000000,33.743700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.358100,0.000000,28.803500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.701800,0.000000,28.803500>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,0.000000,0> translate<49.358100,0.000000,28.803500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.384100,0.000000,43.912000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.654100,0.000000,42.642000>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<49.384100,0.000000,43.912000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.404900,0.000000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,43.891200>}
box{<0,0,-0.304800><6.921300,0.035000,0.304800> rotate<0,0.000000,0> translate<49.404900,0.000000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.409800,0.000000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.920100,0.000000,31.089600>}
box{<0,0,-0.304800><1.510300,0.035000,0.304800> rotate<0,0.000000,0> translate<49.409800,0.000000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.432900,0.000000,20.465800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.702900,0.000000,19.195800>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,44.997030,0> translate<49.432900,0.000000,20.465800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.432900,0.000000,33.800800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.656200,0.000000,32.577600>}
box{<0,0,-0.304800><1.729937,0.035000,0.304800> rotate<0,44.994688,0> translate<49.432900,0.000000,33.800800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.562100,0.000000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.705700,0.000000,33.528000>}
box{<0,0,-0.304800><0.143600,0.035000,0.304800> rotate<0,0.000000,0> translate<49.562100,0.000000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.673700,0.000000,31.353500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.673700,0.000000,33.416400>}
box{<0,0,-0.304800><2.062900,0.035000,0.304800> rotate<0,90.000000,0> translate<49.673700,0.000000,33.416400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.673700,0.000000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.656200,0.000000,31.699200>}
box{<0,0,-0.304800><0.982500,0.035000,0.304800> rotate<0,0.000000,0> translate<49.673700,0.000000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.673700,0.000000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.656200,0.000000,32.308800>}
box{<0,0,-0.304800><0.982500,0.035000,0.304800> rotate<0,0.000000,0> translate<49.673700,0.000000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.673700,0.000000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.315300,0.000000,32.918400>}
box{<0,0,-0.304800><0.641600,0.035000,0.304800> rotate<0,0.000000,0> translate<49.673700,0.000000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<49.701800,0.000000,28.803500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.019100,0.000000,28.672000>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,22.509308,0> translate<49.701800,0.000000,28.803500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.014500,0.000000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,43.281600>}
box{<0,0,-0.304800><6.311700,0.035000,0.304800> rotate<0,0.000000,0> translate<50.014500,0.000000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.019100,0.000000,28.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.654100,0.000000,28.037000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,44.997030,0> translate<50.019100,0.000000,28.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.039900,0.000000,28.651200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.545000,0.000000,28.651200>}
box{<0,0,-0.304800><8.505100,0.035000,0.304800> rotate<0,0.000000,0> translate<50.039900,0.000000,28.651200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.624100,0.000000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,42.672000>}
box{<0,0,-0.304800><5.702100,0.035000,0.304800> rotate<0,0.000000,0> translate<50.624100,0.000000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.649500,0.000000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.935400,0.000000,28.041600>}
box{<0,0,-0.304800><7.285900,0.035000,0.304800> rotate<0,0.000000,0> translate<50.649500,0.000000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.654100,0.000000,28.037000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.897000,0.000000,27.794100>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,44.997030,0> translate<50.654100,0.000000,28.037000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.654100,0.000000,42.642000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.897000,0.000000,42.399100>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,44.997030,0> translate<50.654100,0.000000,42.642000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.656200,0.000000,31.353500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.983500,0.000000,31.026200>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<50.656200,0.000000,31.353500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.656200,0.000000,32.577600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.656200,0.000000,31.353500>}
box{<0,0,-0.304800><1.224100,0.035000,0.304800> rotate<0,-90.000000,0> translate<50.656200,0.000000,31.353500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.702900,0.000000,19.195800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.945800,0.000000,18.952900>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,44.997030,0> translate<50.702900,0.000000,19.195800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.897000,0.000000,27.794100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,27.476800>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,67.484752,0> translate<50.897000,0.000000,27.794100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.897000,0.000000,42.399100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,42.081800>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,67.484752,0> translate<50.897000,0.000000,42.399100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.945800,0.000000,18.952900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.263100,0.000000,18.821400>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,22.509308,0> translate<50.945800,0.000000,18.952900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<50.983500,0.000000,31.026200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,31.026200>}
box{<0,0,-0.304800><3.962900,0.035000,0.304800> rotate<0,0.000000,0> translate<50.983500,0.000000,31.026200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,21.312600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,23.406200>}
box{<0,0,-0.304800><2.093600,0.035000,0.304800> rotate<0,90.000000,0> translate<51.028500,0.000000,23.406200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,21.312600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.792600,0.000000,20.548500>}
box{<0,0,-0.304800><1.080601,0.035000,0.304800> rotate<0,44.997030,0> translate<51.028500,0.000000,21.312600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.488700,0.000000,21.336000>}
box{<0,0,-0.304800><5.460200,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,21.945600>}
box{<0,0,-0.304800><5.297700,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,22.555200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,22.555200>}
box{<0,0,-0.304800><5.297700,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,22.555200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,23.164800>}
box{<0,0,-0.304800><5.297700,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,23.406200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,23.406200>}
box{<0,0,-0.304800><3.917900,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,23.406200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,26.123700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,27.476800>}
box{<0,0,-0.304800><1.353100,0.035000,0.304800> rotate<0,90.000000,0> translate<51.028500,0.000000,27.476800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,26.123700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,26.123700>}
box{<0,0,-0.304800><3.917900,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,26.123700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.471700,0.000000,26.212800>}
box{<0,0,-0.304800><4.443200,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.159500,0.000000,26.822400>}
box{<0,0,-0.304800><5.131000,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.556400,0.000000,27.432000>}
box{<0,0,-0.304800><6.527900,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,34.647600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,39.281200>}
box{<0,0,-0.304800><4.633600,0.035000,0.304800> rotate<0,90.000000,0> translate<51.028500,0.000000,39.281200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,34.647600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.932300,0.000000,33.743700>}
box{<0,0,-0.304800><1.278237,0.035000,0.304800> rotate<0,45.000200,0> translate<51.028500,0.000000,34.647600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.196000,0.000000,34.747200>}
box{<0,0,-0.304800><9.167500,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,35.356800>}
box{<0,0,-0.304800><9.677500,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,35.966400>}
box{<0,0,-0.304800><9.677500,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,36.576000>}
box{<0,0,-0.304800><9.677500,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,37.185600>}
box{<0,0,-0.304800><9.677500,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.862500,0.000000,37.795200>}
box{<0,0,-0.304800><9.834000,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.564900,0.000000,38.404800>}
box{<0,0,-0.304800><5.536400,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.649300,0.000000,39.014400>}
box{<0,0,-0.304800><4.620800,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,39.281200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,39.281200>}
box{<0,0,-0.304800><3.917900,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,39.281200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,41.998700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,42.081800>}
box{<0,0,-0.304800><0.083100,0.035000,0.304800> rotate<0,90.000000,0> translate<51.028500,0.000000,42.081800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,41.998700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,41.998700>}
box{<0,0,-0.304800><3.917900,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,41.998700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.028500,0.000000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,42.062400>}
box{<0,0,-0.304800><5.297700,0.035000,0.304800> rotate<0,0.000000,0> translate<51.028500,0.000000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.263100,0.000000,18.821400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.306800,0.000000,18.821400>}
box{<0,0,-0.304800><13.043700,0.035000,0.304800> rotate<0,0.000000,0> translate<51.263100,0.000000,18.821400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.538500,0.000000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.586400,0.000000,34.137600>}
box{<0,0,-0.304800><8.047900,0.035000,0.304800> rotate<0,0.000000,0> translate<51.538500,0.000000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.614700,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.955300,0.000000,20.726400>}
box{<0,0,-0.304800><12.340600,0.035000,0.304800> rotate<0,0.000000,0> translate<51.614700,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.792600,0.000000,20.548500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.777300,0.000000,20.548500>}
box{<0,0,-0.304800><11.984700,0.035000,0.304800> rotate<0,0.000000,0> translate<51.792600,0.000000,20.548500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<51.932300,0.000000,33.743700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,33.743700>}
box{<0,0,-0.304800><3.014100,0.035000,0.304800> rotate<0,0.000000,0> translate<51.932300,0.000000,33.743700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,23.406200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,23.733500>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.946400,0.000000,23.406200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,26.123700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.164500,0.000000,25.905600>}
box{<0,0,-0.304800><0.308440,0.035000,0.304800> rotate<0,44.997030,0> translate<54.946400,0.000000,26.123700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,31.026200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,31.353500>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<54.946400,0.000000,31.026200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,33.743700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,33.416400>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<54.946400,0.000000,33.743700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,39.281200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.164400,0.000000,39.499300>}
box{<0,0,-0.304800><0.308369,0.035000,0.304800> rotate<0,-45.010168,0> translate<54.946400,0.000000,39.281200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<54.946400,0.000000,41.998700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,41.671400>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<54.946400,0.000000,41.998700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.009800,0.000000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.006700,0.000000,31.089600>}
box{<0,0,-0.304800><12.996900,0.035000,0.304800> rotate<0,0.000000,0> translate<55.009800,0.000000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.162100,0.000000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.976800,0.000000,33.528000>}
box{<0,0,-0.304800><3.814700,0.035000,0.304800> rotate<0,0.000000,0> translate<55.162100,0.000000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.164400,0.000000,39.499300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.782900,0.000000,38.880800>}
box{<0,0,-0.304800><0.874691,0.035000,0.304800> rotate<0,44.997030,0> translate<55.164400,0.000000,39.499300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.164500,0.000000,25.905600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.782900,0.000000,26.524100>}
box{<0,0,-0.304800><0.874620,0.035000,0.304800> rotate<0,-45.001662,0> translate<55.164500,0.000000,25.905600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,23.733500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,23.901400>}
box{<0,0,-0.304800><0.167900,0.035000,0.304800> rotate<0,90.000000,0> translate<55.273700,0.000000,23.901400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,23.774400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.955300,0.000000,23.774400>}
box{<0,0,-0.304800><3.681600,0.035000,0.304800> rotate<0,0.000000,0> translate<55.273700,0.000000,23.774400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,23.901400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.416800,0.000000,23.901400>}
box{<0,0,-0.304800><0.143100,0.035000,0.304800> rotate<0,0.000000,0> translate<55.273700,0.000000,23.901400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,31.353500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,31.521400>}
box{<0,0,-0.304800><0.167900,0.035000,0.304800> rotate<0,90.000000,0> translate<55.273700,0.000000,31.521400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,31.521400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.883100,0.000000,31.521400>}
box{<0,0,-0.304800><3.609400,0.035000,0.304800> rotate<0,0.000000,0> translate<55.273700,0.000000,31.521400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,33.248500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,33.416400>}
box{<0,0,-0.304800><0.167900,0.035000,0.304800> rotate<0,90.000000,0> translate<55.273700,0.000000,33.416400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,33.248500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.697300,0.000000,33.248500>}
box{<0,0,-0.304800><3.423600,0.035000,0.304800> rotate<0,0.000000,0> translate<55.273700,0.000000,33.248500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,41.503500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,41.671400>}
box{<0,0,-0.304800><0.167900,0.035000,0.304800> rotate<0,90.000000,0> translate<55.273700,0.000000,41.671400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.273700,0.000000,41.503500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.416800,0.000000,41.503500>}
box{<0,0,-0.304800><0.143100,0.035000,0.304800> rotate<0,0.000000,0> translate<55.273700,0.000000,41.503500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.416800,0.000000,23.901400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.734100,0.000000,24.032900>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-22.509308,0> translate<55.416800,0.000000,23.901400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.416800,0.000000,41.503500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.734100,0.000000,41.372000>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,22.509308,0> translate<55.416800,0.000000,41.503500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.539200,0.000000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,41.452800>}
box{<0,0,-0.304800><3.327000,0.035000,0.304800> rotate<0,0.000000,0> translate<55.539200,0.000000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.734100,0.000000,24.032900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.463000,0.000000,24.761800>}
box{<0,0,-0.304800><1.030820,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.734100,0.000000,24.032900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.734100,0.000000,41.372000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.463000,0.000000,40.643100>}
box{<0,0,-0.304800><1.030820,0.035000,0.304800> rotate<0,44.997030,0> translate<55.734100,0.000000,41.372000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.782900,0.000000,26.524100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.025800,0.000000,26.767000>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<55.782900,0.000000,26.524100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<55.782900,0.000000,38.880800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.025800,0.000000,38.637900>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,44.997030,0> translate<55.782900,0.000000,38.880800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.025800,0.000000,26.767000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.343100,0.000000,26.898500>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-22.509308,0> translate<56.025800,0.000000,26.767000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.025800,0.000000,38.637900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.343100,0.000000,38.506400>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,22.509308,0> translate<56.025800,0.000000,38.637900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.085200,0.000000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,24.384000>}
box{<0,0,-0.304800><2.781000,0.035000,0.304800> rotate<0,0.000000,0> translate<56.085200,0.000000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.262900,0.000000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,40.843200>}
box{<0,0,-0.304800><2.603300,0.035000,0.304800> rotate<0,0.000000,0> translate<56.262900,0.000000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,21.498500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,21.171200>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<56.326200,0.000000,21.498500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,23.361400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,21.498500>}
box{<0,0,-0.304800><1.862900,0.035000,0.304800> rotate<0,-90.000000,0> translate<56.326200,0.000000,21.498500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,23.361400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,23.688700>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<56.326200,0.000000,23.361400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,42.043500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,41.716200>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<56.326200,0.000000,42.043500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,43.906400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,42.043500>}
box{<0,0,-0.304800><1.862900,0.035000,0.304800> rotate<0,-90.000000,0> translate<56.326200,0.000000,42.043500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.326200,0.000000,43.906400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,44.233700>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<56.326200,0.000000,43.906400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.343100,0.000000,26.898500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.463400,0.000000,26.898500>}
box{<0,0,-0.304800><0.120300,0.035000,0.304800> rotate<0,0.000000,0> translate<56.343100,0.000000,26.898500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.343100,0.000000,38.506400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.463400,0.000000,38.506400>}
box{<0,0,-0.304800><0.120300,0.035000,0.304800> rotate<0,0.000000,0> translate<56.343100,0.000000,38.506400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.463000,0.000000,24.761800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,24.571200>}
box{<0,0,-0.304800><0.269478,0.035000,0.304800> rotate<0,45.012064,0> translate<56.463000,0.000000,24.761800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.463000,0.000000,40.643100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,40.833700>}
box{<0,0,-0.304800><0.269478,0.035000,0.304800> rotate<0,-45.012064,0> translate<56.463000,0.000000,40.643100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.463400,0.000000,26.898500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,27.088700>}
box{<0,0,-0.304800><0.268913,0.035000,0.304800> rotate<0,-45.012095,0> translate<56.463400,0.000000,26.898500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.463400,0.000000,38.506400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,38.316200>}
box{<0,0,-0.304800><0.268913,0.035000,0.304800> rotate<0,45.012095,0> translate<56.463400,0.000000,38.506400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,21.171200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,21.171200>}
box{<0,0,-0.304800><2.212700,0.035000,0.304800> rotate<0,0.000000,0> translate<56.653500,0.000000,21.171200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,23.688700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.916400,0.000000,23.688700>}
box{<0,0,-0.304800><2.262900,0.035000,0.304800> rotate<0,0.000000,0> translate<56.653500,0.000000,23.688700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,24.571200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.164100,0.000000,24.571200>}
box{<0,0,-0.304800><1.510600,0.035000,0.304800> rotate<0,0.000000,0> translate<56.653500,0.000000,24.571200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,27.088700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.556400,0.000000,27.088700>}
box{<0,0,-0.304800><0.902900,0.035000,0.304800> rotate<0,0.000000,0> translate<56.653500,0.000000,27.088700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,38.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.916400,0.000000,38.316200>}
box{<0,0,-0.304800><2.262900,0.035000,0.304800> rotate<0,0.000000,0> translate<56.653500,0.000000,38.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,40.833700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,40.833700>}
box{<0,0,-0.304800><2.212700,0.035000,0.304800> rotate<0,0.000000,0> translate<56.653500,0.000000,40.833700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,41.716200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.916400,0.000000,41.716200>}
box{<0,0,-0.304800><2.262900,0.035000,0.304800> rotate<0,0.000000,0> translate<56.653500,0.000000,41.716200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<56.653500,0.000000,44.233700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.023800,0.000000,44.233700>}
box{<0,0,-0.304800><0.370300,0.035000,0.304800> rotate<0,0.000000,0> translate<56.653500,0.000000,44.233700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.023800,0.000000,44.233700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.052900,0.000000,44.304100>}
box{<0,0,-0.304800><0.076177,0.035000,0.304800> rotate<0,-67.537677,0> translate<57.023800,0.000000,44.233700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.052900,0.000000,44.304100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.295800,0.000000,44.547000>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.052900,0.000000,44.304100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.295800,0.000000,44.547000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.613100,0.000000,44.678500>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-22.509308,0> translate<57.295800,0.000000,44.547000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.556400,0.000000,27.476800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.556400,0.000000,27.088700>}
box{<0,0,-0.304800><0.388100,0.035000,0.304800> rotate<0,-90.000000,0> translate<57.556400,0.000000,27.088700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.556400,0.000000,27.476800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.687900,0.000000,27.794100>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-67.484752,0> translate<57.556400,0.000000,27.476800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.613100,0.000000,44.678500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.153100,0.000000,44.678500>}
box{<0,0,-0.304800><2.540000,0.035000,0.304800> rotate<0,0.000000,0> translate<57.613100,0.000000,44.678500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.687900,0.000000,27.794100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.930800,0.000000,28.037000>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.687900,0.000000,27.794100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<57.930800,0.000000,28.037000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.565800,0.000000,28.672000>}
box{<0,0,-0.304800><0.898026,0.035000,0.304800> rotate<0,-44.997030,0> translate<57.930800,0.000000,28.037000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.164100,0.000000,24.571200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.248100,0.000000,24.536400>}
box{<0,0,-0.304800><0.090923,0.035000,0.304800> rotate<0,22.502043,0> translate<58.164100,0.000000,24.571200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.248100,0.000000,24.536400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,24.536400>}
box{<0,0,-0.304800><0.618100,0.035000,0.304800> rotate<0,0.000000,0> translate<58.248100,0.000000,24.536400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.565800,0.000000,28.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.883100,0.000000,28.803500>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-22.509308,0> translate<58.565800,0.000000,28.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.697300,0.000000,33.248500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,35.257200>}
box{<0,0,-0.304800><2.840731,0.035000,0.304800> rotate<0,-44.997030,0> translate<58.697300,0.000000,33.248500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,21.063500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,20.736200>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<58.866200,0.000000,21.063500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,21.171200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,21.063500>}
box{<0,0,-0.304800><0.107700,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.866200,0.000000,21.063500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,23.863500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,23.536200>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<58.866200,0.000000,23.863500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,24.536400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,23.863500>}
box{<0,0,-0.304800><0.672900,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.866200,0.000000,23.863500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,41.541400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,40.833700>}
box{<0,0,-0.304800><0.707700,0.035000,0.304800> rotate<0,-90.000000,0> translate<58.866200,0.000000,40.833700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.866200,0.000000,41.541400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,41.868700>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<58.866200,0.000000,41.541400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.883100,0.000000,28.803500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.226800,0.000000,28.803500>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,0.000000,0> translate<58.883100,0.000000,28.803500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.883100,0.000000,31.521400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.226800,0.000000,31.521400>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,0.000000,0> translate<58.883100,0.000000,31.521400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.916400,0.000000,23.688700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.172400,0.000000,23.432600>}
box{<0,0,-0.304800><0.362109,0.035000,0.304800> rotate<0,45.008218,0> translate<58.916400,0.000000,23.688700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.916400,0.000000,38.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.106500,0.000000,38.506400>}
box{<0,0,-0.304800><0.268913,0.035000,0.304800> rotate<0,-45.012095,0> translate<58.916400,0.000000,38.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<58.916400,0.000000,41.716200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.172400,0.000000,41.972300>}
box{<0,0,-0.304800><0.362109,0.035000,0.304800> rotate<0,-45.008218,0> translate<58.916400,0.000000,41.716200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.004900,0.000000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.068900,0.000000,38.404800>}
box{<0,0,-0.304800><1.064000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.004900,0.000000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.106500,0.000000,38.506400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.967300,0.000000,38.506400>}
box{<0,0,-0.304800><0.860800,0.035000,0.304800> rotate<0,0.000000,0> translate<59.106500,0.000000,38.506400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.172400,0.000000,23.432600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,23.453700>}
box{<0,0,-0.304800><0.029840,0.035000,0.304800> rotate<0,-44.997030,0> translate<59.172400,0.000000,23.432600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.172400,0.000000,41.972300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,41.951200>}
box{<0,0,-0.304800><0.029840,0.035000,0.304800> rotate<0,44.997030,0> translate<59.172400,0.000000,41.972300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,20.736200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.456400,0.000000,20.736200>}
box{<0,0,-0.304800><2.262900,0.035000,0.304800> rotate<0,0.000000,0> translate<59.193500,0.000000,20.736200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,23.453700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.332500,0.000000,23.453700>}
box{<0,0,-0.304800><1.139000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.193500,0.000000,23.453700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,23.536200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.415100,0.000000,23.536200>}
box{<0,0,-0.304800><1.221600,0.035000,0.304800> rotate<0,0.000000,0> translate<59.193500,0.000000,23.536200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,41.868700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.780100,0.000000,41.868700>}
box{<0,0,-0.304800><0.586600,0.035000,0.304800> rotate<0,0.000000,0> translate<59.193500,0.000000,41.868700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.193500,0.000000,41.951200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.697600,0.000000,41.951200>}
box{<0,0,-0.304800><0.504100,0.035000,0.304800> rotate<0,0.000000,0> translate<59.193500,0.000000,41.951200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.226800,0.000000,28.803500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.602300,0.000000,28.803500>}
box{<0,0,-0.304800><1.375500,0.035000,0.304800> rotate<0,0.000000,0> translate<59.226800,0.000000,28.803500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.226800,0.000000,31.521400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.544100,0.000000,31.652900>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-22.509308,0> translate<59.226800,0.000000,31.521400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.243700,0.000000,26.302800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.243700,0.000000,26.402100>}
box{<0,0,-0.304800><0.099300,0.035000,0.304800> rotate<0,90.000000,0> translate<59.243700,0.000000,26.402100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.243700,0.000000,26.302800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.260000,0.000000,26.263500>}
box{<0,0,-0.304800><0.042546,0.035000,0.304800> rotate<0,67.468913,0> translate<59.243700,0.000000,26.302800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.243700,0.000000,26.402100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.283500,0.000000,26.498100>}
box{<0,0,-0.304800><0.103923,0.035000,0.304800> rotate<0,-67.477465,0> translate<59.243700,0.000000,26.402100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.260000,0.000000,26.263500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.496800,0.000000,26.263500>}
box{<0,0,-0.304800><1.236800,0.035000,0.304800> rotate<0,0.000000,0> translate<59.260000,0.000000,26.263500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.283500,0.000000,26.498100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.283500,0.000000,26.947300>}
box{<0,0,-0.304800><0.449200,0.035000,0.304800> rotate<0,90.000000,0> translate<59.283500,0.000000,26.947300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.283500,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.001400,0.000000,26.822400>}
box{<0,0,-0.304800><2.717900,0.035000,0.304800> rotate<0,0.000000,0> translate<59.283500,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.283500,0.000000,26.947300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.412600,0.000000,27.076400>}
box{<0,0,-0.304800><0.182575,0.035000,0.304800> rotate<0,-44.997030,0> translate<59.283500,0.000000,26.947300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.412600,0.000000,27.076400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.131800,0.000000,27.076400>}
box{<0,0,-0.304800><1.719200,0.035000,0.304800> rotate<0,0.000000,0> translate<59.412600,0.000000,27.076400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.544100,0.000000,31.652900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.084100,0.000000,34.192900>}
box{<0,0,-0.304800><3.592102,0.035000,0.304800> rotate<0,-44.997030,0> translate<59.544100,0.000000,31.652900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.590400,0.000000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.307400,0.000000,31.699200>}
box{<0,0,-0.304800><7.717000,0.035000,0.304800> rotate<0,0.000000,0> translate<59.590400,0.000000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.697600,0.000000,41.951200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.780100,0.000000,41.868700>}
box{<0,0,-0.304800><0.116673,0.035000,0.304800> rotate<0,44.997030,0> translate<59.697600,0.000000,41.951200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<59.967300,0.000000,38.506400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.470800,0.000000,38.002900>}
box{<0,0,-0.304800><0.712057,0.035000,0.304800> rotate<0,44.997030,0> translate<59.967300,0.000000,38.506400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.153100,0.000000,44.678500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.496800,0.000000,44.678500>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,0.000000,0> translate<60.153100,0.000000,44.678500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.200000,0.000000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,32.308800>}
box{<0,0,-0.304800><6.932200,0.035000,0.304800> rotate<0,0.000000,0> translate<60.200000,0.000000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.332500,0.000000,23.453700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.415100,0.000000,23.536200>}
box{<0,0,-0.304800><0.116743,0.035000,0.304800> rotate<0,-44.962329,0> translate<60.332500,0.000000,23.453700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.470800,0.000000,38.002900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.788100,0.000000,37.871400>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,22.509308,0> translate<60.470800,0.000000,38.002900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.496800,0.000000,26.263500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.520400,0.000000,26.253700>}
box{<0,0,-0.304800><0.025554,0.035000,0.304800> rotate<0,22.549387,0> translate<60.496800,0.000000,26.263500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.496800,0.000000,44.678500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.520400,0.000000,44.668700>}
box{<0,0,-0.304800><0.025554,0.035000,0.304800> rotate<0,22.549387,0> translate<60.496800,0.000000,44.678500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.520400,0.000000,26.253700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.456400,0.000000,26.253700>}
box{<0,0,-0.304800><0.936000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.520400,0.000000,26.253700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.520400,0.000000,44.668700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.456400,0.000000,44.668700>}
box{<0,0,-0.304800><0.936000,0.035000,0.304800> rotate<0,0.000000,0> translate<60.520400,0.000000,44.668700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.602300,0.000000,28.803500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,28.907200>}
box{<0,0,-0.304800><0.146654,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.602300,0.000000,28.803500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,30.642000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,28.907200>}
box{<0,0,-0.304800><1.734800,0.035000,0.304800> rotate<0,-90.000000,0> translate<60.706000,0.000000,28.907200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,30.642000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.033300,0.000000,30.969300>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<60.706000,0.000000,30.642000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,37.638800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,35.257200>}
box{<0,0,-0.304800><2.381600,0.035000,0.304800> rotate<0,-90.000000,0> translate<60.706000,0.000000,35.257200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.706000,0.000000,37.638800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.938700,0.000000,37.871400>}
box{<0,0,-0.304800><0.329017,0.035000,0.304800> rotate<0,-44.984717,0> translate<60.706000,0.000000,37.638800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.788100,0.000000,37.871400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.938700,0.000000,37.871400>}
box{<0,0,-0.304800><0.150600,0.035000,0.304800> rotate<0,0.000000,0> translate<60.788100,0.000000,37.871400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<60.809600,0.000000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.244400,0.000000,32.918400>}
box{<0,0,-0.304800><6.434800,0.035000,0.304800> rotate<0,0.000000,0> translate<60.809600,0.000000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.033300,0.000000,30.969300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.156600,0.000000,30.969300>}
box{<0,0,-0.304800><1.123300,0.035000,0.304800> rotate<0,0.000000,0> translate<61.033300,0.000000,30.969300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.131800,0.000000,27.076400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.449100,0.000000,27.207900>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-22.509308,0> translate<61.131800,0.000000,27.076400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.419200,0.000000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.761300,0.000000,33.528000>}
box{<0,0,-0.304800><6.342100,0.035000,0.304800> rotate<0,0.000000,0> translate<61.419200,0.000000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.449100,0.000000,27.207900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.692000,0.000000,27.450800>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<61.449100,0.000000,27.207900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.456400,0.000000,20.736200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,21.063500>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<61.456400,0.000000,20.736200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.456400,0.000000,26.253700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,25.926400>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<61.456400,0.000000,26.253700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.456400,0.000000,44.668700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,44.341400>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<61.456400,0.000000,44.668700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.497300,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,26.212800>}
box{<0,0,-0.304800><0.543900,0.035000,0.304800> rotate<0,0.000000,0> translate<61.497300,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.624300,0.000000,44.500800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,44.500800>}
box{<0,0,-0.304800><10.765700,0.035000,0.304800> rotate<0,0.000000,0> translate<61.624300,0.000000,44.500800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.673200,0.000000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.001400,0.000000,27.432000>}
box{<0,0,-0.304800><0.328200,0.035000,0.304800> rotate<0,0.000000,0> translate<61.673200,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.692000,0.000000,27.450800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.001400,0.000000,27.760300>}
box{<0,0,-0.304800><0.437628,0.035000,0.304800> rotate<0,-45.006287,0> translate<61.692000,0.000000,27.450800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,21.063500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,22.462500>}
box{<0,0,-0.304800><1.399000,0.035000,0.304800> rotate<0,90.000000,0> translate<61.783700,0.000000,22.462500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.203700,0.000000,21.336000>}
box{<0,0,-0.304800><0.420000,0.035000,0.304800> rotate<0,0.000000,0> translate<61.783700,0.000000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,21.945600>}
box{<0,0,-0.304800><0.257500,0.035000,0.304800> rotate<0,0.000000,0> translate<61.783700,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,22.462500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,22.720100>}
box{<0,0,-0.304800><0.364231,0.035000,0.304800> rotate<0,-45.008153,0> translate<61.783700,0.000000,22.462500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,24.904800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,25.926400>}
box{<0,0,-0.304800><1.021600,0.035000,0.304800> rotate<0,90.000000,0> translate<61.783700,0.000000,25.926400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,24.904800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,25.162400>}
box{<0,0,-0.304800><0.364231,0.035000,0.304800> rotate<0,-45.008153,0> translate<61.783700,0.000000,24.904800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,24.993600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.872500,0.000000,24.993600>}
box{<0,0,-0.304800><0.088800,0.035000,0.304800> rotate<0,0.000000,0> translate<61.783700,0.000000,24.993600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,25.603200>}
box{<0,0,-0.304800><0.257500,0.035000,0.304800> rotate<0,0.000000,0> translate<61.783700,0.000000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,39.591400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,40.500100>}
box{<0,0,-0.304800><0.908700,0.035000,0.304800> rotate<0,90.000000,0> translate<61.783700,0.000000,40.500100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,39.591400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.084100,0.000000,39.467000>}
box{<0,0,-0.304800><0.325139,0.035000,0.304800> rotate<0,22.493671,0> translate<61.783700,0.000000,39.591400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.659800,0.000000,39.624000>}
box{<0,0,-0.304800><0.876100,0.035000,0.304800> rotate<0,0.000000,0> translate<61.783700,0.000000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,40.233600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.050200,0.000000,40.233600>}
box{<0,0,-0.304800><0.266500,0.035000,0.304800> rotate<0,0.000000,0> translate<61.783700,0.000000,40.233600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,40.500100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,39.607600>}
box{<0,0,-0.304800><1.262186,0.035000,0.304800> rotate<0,44.997030,0> translate<61.783700,0.000000,40.500100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,42.942300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,44.341400>}
box{<0,0,-0.304800><1.399100,0.035000,0.304800> rotate<0,90.000000,0> translate<61.783700,0.000000,44.341400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,42.942300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,42.049800>}
box{<0,0,-0.304800><1.262186,0.035000,0.304800> rotate<0,44.997030,0> translate<61.783700,0.000000,42.942300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,43.281600>}
box{<0,0,-0.304800><0.892500,0.035000,0.304800> rotate<0,0.000000,0> translate<61.783700,0.000000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.783700,0.000000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,43.891200>}
box{<0,0,-0.304800><0.892500,0.035000,0.304800> rotate<0,0.000000,0> translate<61.783700,0.000000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<61.876300,0.000000,22.555200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,22.555200>}
box{<0,0,-0.304800><0.164900,0.035000,0.304800> rotate<0,0.000000,0> translate<61.876300,0.000000,22.555200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.001400,0.000000,26.498100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,26.402100>}
box{<0,0,-0.304800><0.103923,0.035000,0.304800> rotate<0,67.477465,0> translate<62.001400,0.000000,26.498100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.001400,0.000000,27.760300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.001400,0.000000,26.498100>}
box{<0,0,-0.304800><1.262200,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.001400,0.000000,26.498100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.028800,0.000000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,34.137600>}
box{<0,0,-0.304800><6.322600,0.035000,0.304800> rotate<0,0.000000,0> translate<62.028800,0.000000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,21.498500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.368500,0.000000,21.171200>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<62.041200,0.000000,21.498500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,22.720100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,21.498500>}
box{<0,0,-0.304800><1.221600,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.041200,0.000000,21.498500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,26.402100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.041200,0.000000,25.162400>}
box{<0,0,-0.304800><1.239700,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.041200,0.000000,25.162400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.054000,0.000000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,42.672000>}
box{<0,0,-0.304800><0.622200,0.035000,0.304800> rotate<0,0.000000,0> translate<62.054000,0.000000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.084100,0.000000,34.192900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.327000,0.000000,34.435800>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.084100,0.000000,34.192900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.084100,0.000000,39.467000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,38.874800>}
box{<0,0,-0.304800><0.837427,0.035000,0.304800> rotate<0,45.001868,0> translate<62.084100,0.000000,39.467000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.156600,0.000000,30.969300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.229900,0.000000,30.895900>}
box{<0,0,-0.304800><0.103733,0.035000,0.304800> rotate<0,45.036084,0> translate<62.156600,0.000000,30.969300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.229900,0.000000,30.895900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.303300,0.000000,30.969300>}
box{<0,0,-0.304800><0.103803,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.229900,0.000000,30.895900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.303300,0.000000,30.969300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.426600,0.000000,30.969300>}
box{<0,0,-0.304800><1.123300,0.035000,0.304800> rotate<0,0.000000,0> translate<62.303300,0.000000,30.969300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.327000,0.000000,34.435800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.458500,0.000000,34.753100>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-67.484752,0> translate<62.327000,0.000000,34.435800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.368500,0.000000,21.171200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.400100,0.000000,21.171200>}
box{<0,0,-0.304800><2.031600,0.035000,0.304800> rotate<0,0.000000,0> translate<62.368500,0.000000,21.171200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.456000,0.000000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,34.747200>}
box{<0,0,-0.304800><5.895400,0.035000,0.304800> rotate<0,0.000000,0> translate<62.456000,0.000000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.458500,0.000000,34.753100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.458500,0.000000,34.816600>}
box{<0,0,-0.304800><0.063500,0.035000,0.304800> rotate<0,90.000000,0> translate<62.458500,0.000000,34.816600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.458500,0.000000,34.816600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.426600,0.000000,34.816600>}
box{<0,0,-0.304800><0.968100,0.035000,0.304800> rotate<0,0.000000,0> translate<62.458500,0.000000,34.816600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.536700,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,39.014400>}
box{<0,0,-0.304800><0.139500,0.035000,0.304800> rotate<0,0.000000,0> translate<62.536700,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.663600,0.000000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,42.062400>}
box{<0,0,-0.304800><0.012600,0.035000,0.304800> rotate<0,0.000000,0> translate<62.663600,0.000000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,39.607600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,38.874800>}
box{<0,0,-0.304800><0.732800,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.676200,0.000000,38.874800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,43.906400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,42.049800>}
box{<0,0,-0.304800><1.856600,0.035000,0.304800> rotate<0,-90.000000,0> translate<62.676200,0.000000,42.049800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<62.676200,0.000000,43.906400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.003500,0.000000,44.233700>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<62.676200,0.000000,43.906400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.003500,0.000000,44.233700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.266400,0.000000,44.233700>}
box{<0,0,-0.304800><2.262900,0.035000,0.304800> rotate<0,0.000000,0> translate<63.003500,0.000000,44.233700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.009800,0.000000,41.716200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.742600,0.000000,41.716200>}
box{<0,0,-0.304800><0.732800,0.035000,0.304800> rotate<0,0.000000,0> translate<63.009800,0.000000,41.716200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.009800,0.000000,41.716200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.892300,0.000000,40.833700>}
box{<0,0,-0.304800><1.248043,0.035000,0.304800> rotate<0,44.997030,0> translate<63.009800,0.000000,41.716200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.234800,0.000000,38.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.271400,0.000000,38.279600>}
box{<0,0,-0.304800><0.051760,0.035000,0.304800> rotate<0,44.997030,0> translate<63.234800,0.000000,38.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.234800,0.000000,38.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.271400,0.000000,38.316200>}
box{<0,0,-0.304800><0.036600,0.035000,0.304800> rotate<0,0.000000,0> translate<63.234800,0.000000,38.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.271400,0.000000,38.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.271400,0.000000,38.279600>}
box{<0,0,-0.304800><0.036600,0.035000,0.304800> rotate<0,-90.000000,0> translate<63.271400,0.000000,38.279600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.273200,0.000000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.006000,0.000000,41.452800>}
box{<0,0,-0.304800><0.732800,0.035000,0.304800> rotate<0,0.000000,0> translate<63.273200,0.000000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.426600,0.000000,30.969300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.499900,0.000000,30.895900>}
box{<0,0,-0.304800><0.103733,0.035000,0.304800> rotate<0,45.036084,0> translate<63.426600,0.000000,30.969300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.426600,0.000000,34.816600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.499900,0.000000,34.890000>}
box{<0,0,-0.304800><0.103733,0.035000,0.304800> rotate<0,-45.036084,0> translate<63.426600,0.000000,34.816600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.499900,0.000000,30.895900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.573300,0.000000,30.969300>}
box{<0,0,-0.304800><0.103803,0.035000,0.304800> rotate<0,-44.997030,0> translate<63.499900,0.000000,30.895900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.499900,0.000000,34.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.573300,0.000000,34.816600>}
box{<0,0,-0.304800><0.103803,0.035000,0.304800> rotate<0,44.997030,0> translate<63.499900,0.000000,34.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.573300,0.000000,30.969300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.696600,0.000000,30.969300>}
box{<0,0,-0.304800><1.123300,0.035000,0.304800> rotate<0,0.000000,0> translate<63.573300,0.000000,30.969300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.573300,0.000000,34.816600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.696600,0.000000,34.816600>}
box{<0,0,-0.304800><1.123300,0.035000,0.304800> rotate<0,0.000000,0> translate<63.573300,0.000000,34.816600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.728500,0.000000,27.088700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.728500,0.000000,27.173700>}
box{<0,0,-0.304800><0.085000,0.035000,0.304800> rotate<0,90.000000,0> translate<63.728500,0.000000,27.173700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.728500,0.000000,27.088700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.933600,0.000000,27.088700>}
box{<0,0,-0.304800><0.205100,0.035000,0.304800> rotate<0,0.000000,0> translate<63.728500,0.000000,27.088700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.728500,0.000000,27.173700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.933600,0.000000,27.088700>}
box{<0,0,-0.304800><0.222016,0.035000,0.304800> rotate<0,22.509195,0> translate<63.728500,0.000000,27.173700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.742600,0.000000,41.716200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.625100,0.000000,40.833700>}
box{<0,0,-0.304800><1.248043,0.035000,0.304800> rotate<0,44.997030,0> translate<63.742600,0.000000,41.716200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.777300,0.000000,20.548500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.400100,0.000000,21.171200>}
box{<0,0,-0.304800><0.880701,0.035000,0.304800> rotate<0,-44.992430,0> translate<63.777300,0.000000,20.548500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.882800,0.000000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.615600,0.000000,40.843200>}
box{<0,0,-0.304800><0.732800,0.035000,0.304800> rotate<0,0.000000,0> translate<63.882800,0.000000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<63.892300,0.000000,40.833700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.625100,0.000000,40.833700>}
box{<0,0,-0.304800><0.732800,0.035000,0.304800> rotate<0,0.000000,0> translate<63.892300,0.000000,40.833700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.306800,0.000000,18.821400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.624100,0.000000,18.952900>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-22.509308,0> translate<64.306800,0.000000,18.821400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.490600,0.000000,18.897600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.954200,0.000000,18.897600>}
box{<0,0,-0.304800><2.463600,0.035000,0.304800> rotate<0,0.000000,0> translate<64.490600,0.000000,18.897600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.624100,0.000000,18.952900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.867000,0.000000,19.195800>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.624100,0.000000,18.952900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.696600,0.000000,30.969300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.769900,0.000000,30.895900>}
box{<0,0,-0.304800><0.103733,0.035000,0.304800> rotate<0,45.036084,0> translate<64.696600,0.000000,30.969300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.696600,0.000000,34.816600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.769900,0.000000,34.890000>}
box{<0,0,-0.304800><0.103733,0.035000,0.304800> rotate<0,-45.036084,0> translate<64.696600,0.000000,34.816600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.769900,0.000000,30.895900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.843300,0.000000,30.969300>}
box{<0,0,-0.304800><0.103803,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.769900,0.000000,30.895900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.769900,0.000000,34.890000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.843300,0.000000,34.816600>}
box{<0,0,-0.304800><0.103803,0.035000,0.304800> rotate<0,44.997030,0> translate<64.769900,0.000000,34.890000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.843300,0.000000,30.969300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.966600,0.000000,30.969300>}
box{<0,0,-0.304800><1.123300,0.035000,0.304800> rotate<0,0.000000,0> translate<64.843300,0.000000,30.969300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.843300,0.000000,34.816600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.966600,0.000000,34.816600>}
box{<0,0,-0.304800><1.123300,0.035000,0.304800> rotate<0,0.000000,0> translate<64.843300,0.000000,34.816600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.867000,0.000000,19.195800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.722500,0.000000,20.051300>}
box{<0,0,-0.304800><1.209860,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.867000,0.000000,19.195800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.998500,0.000000,38.279600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.998500,0.000000,38.316200>}
box{<0,0,-0.304800><0.036600,0.035000,0.304800> rotate<0,90.000000,0> translate<64.998500,0.000000,38.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.998500,0.000000,38.279600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.035100,0.000000,38.316200>}
box{<0,0,-0.304800><0.051760,0.035000,0.304800> rotate<0,-44.997030,0> translate<64.998500,0.000000,38.279600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<64.998500,0.000000,38.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.035100,0.000000,38.316200>}
box{<0,0,-0.304800><0.036600,0.035000,0.304800> rotate<0,0.000000,0> translate<64.998500,0.000000,38.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.178400,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.266500,0.000000,19.507200>}
box{<0,0,-0.304800><1.088100,0.035000,0.304800> rotate<0,0.000000,0> translate<65.178400,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.266400,0.000000,44.233700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.404900,0.000000,44.095100>}
box{<0,0,-0.304800><0.195939,0.035000,0.304800> rotate<0,45.017706,0> translate<65.266400,0.000000,44.233700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.404900,0.000000,44.095100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.543500,0.000000,44.233700>}
box{<0,0,-0.304800><0.196010,0.035000,0.304800> rotate<0,-44.997030,0> translate<65.404900,0.000000,44.095100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.543500,0.000000,44.233700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.806400,0.000000,44.233700>}
box{<0,0,-0.304800><2.262900,0.035000,0.304800> rotate<0,0.000000,0> translate<65.543500,0.000000,44.233700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.722500,0.000000,20.051300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.820800,0.000000,18.952900>}
box{<0,0,-0.304800><1.553301,0.035000,0.304800> rotate<0,44.999638,0> translate<65.722500,0.000000,20.051300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.966600,0.000000,30.969300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,30.642000>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<65.966600,0.000000,30.969300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<65.966600,0.000000,34.816600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,35.143900>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<65.966600,0.000000,34.816600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.171200,0.000000,27.711400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.268500,0.000000,27.476800>}
box{<0,0,-0.304800><0.253977,0.035000,0.304800> rotate<0,67.469390,0> translate<66.171200,0.000000,27.711400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.171200,0.000000,27.711400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.138100,0.000000,27.711400>}
box{<0,0,-0.304800><0.966900,0.035000,0.304800> rotate<0,0.000000,0> translate<66.171200,0.000000,27.711400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.268500,0.000000,27.088700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.268500,0.000000,27.476800>}
box{<0,0,-0.304800><0.388100,0.035000,0.304800> rotate<0,90.000000,0> translate<66.268500,0.000000,27.476800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.268500,0.000000,27.088700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,27.088700>}
box{<0,0,-0.304800><0.863700,0.035000,0.304800> rotate<0,0.000000,0> translate<66.268500,0.000000,27.088700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.268500,0.000000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,27.432000>}
box{<0,0,-0.304800><0.863700,0.035000,0.304800> rotate<0,0.000000,0> translate<66.268500,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,29.438500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,30.642000>}
box{<0,0,-0.304800><1.203500,0.035000,0.304800> rotate<0,90.000000,0> translate<66.293900,0.000000,30.642000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,29.438500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.952300,0.000000,29.438500>}
box{<0,0,-0.304800><0.658400,0.035000,0.304800> rotate<0,0.000000,0> translate<66.293900,0.000000,29.438500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,29.870400>}
box{<0,0,-0.304800><0.838300,0.035000,0.304800> rotate<0,0.000000,0> translate<66.293900,0.000000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.286500,0.000000,30.480000>}
box{<0,0,-0.304800><0.992600,0.035000,0.304800> rotate<0,0.000000,0> translate<66.293900,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,35.143900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,37.132700>}
box{<0,0,-0.304800><1.988800,0.035000,0.304800> rotate<0,90.000000,0> translate<66.293900,0.000000,37.132700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,35.356800>}
box{<0,0,-0.304800><2.057500,0.035000,0.304800> rotate<0,0.000000,0> translate<66.293900,0.000000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,35.966400>}
box{<0,0,-0.304800><2.057500,0.035000,0.304800> rotate<0,0.000000,0> translate<66.293900,0.000000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,36.576000>}
box{<0,0,-0.304800><2.057500,0.035000,0.304800> rotate<0,0.000000,0> translate<66.293900,0.000000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.293900,0.000000,37.132700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.164100,0.000000,38.002900>}
box{<0,0,-0.304800><1.230649,0.035000,0.304800> rotate<0,-44.997030,0> translate<66.293900,0.000000,37.132700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.346800,0.000000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,37.185600>}
box{<0,0,-0.304800><2.004600,0.035000,0.304800> rotate<0,0.000000,0> translate<66.346800,0.000000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.820800,0.000000,18.952900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.138100,0.000000,18.821400>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,22.509308,0> translate<66.820800,0.000000,18.952900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.952300,0.000000,29.438500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,29.618400>}
box{<0,0,-0.304800><0.254417,0.035000,0.304800> rotate<0,-44.997030,0> translate<66.952300,0.000000,29.438500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<66.956400,0.000000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,37.795200>}
box{<0,0,-0.304800><1.395000,0.035000,0.304800> rotate<0,0.000000,0> translate<66.956400,0.000000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.044800,0.000000,21.171200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.171400,0.000000,21.171200>}
box{<0,0,-0.304800><0.126600,0.035000,0.304800> rotate<0,0.000000,0> translate<67.044800,0.000000,21.171200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.044800,0.000000,21.171200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.667600,0.000000,20.548500>}
box{<0,0,-0.304800><0.880701,0.035000,0.304800> rotate<0,44.992430,0> translate<67.044800,0.000000,21.171200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,27.567700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,27.088700>}
box{<0,0,-0.304800><0.479000,0.035000,0.304800> rotate<0,-90.000000,0> translate<67.132200,0.000000,27.088700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,27.567700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.191800,0.000000,27.711400>}
box{<0,0,-0.304800><0.155569,0.035000,0.304800> rotate<0,-67.469173,0> translate<67.132200,0.000000,27.567700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,30.107700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,29.618400>}
box{<0,0,-0.304800><0.489300,0.035000,0.304800> rotate<0,-90.000000,0> translate<67.132200,0.000000,29.618400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,30.107700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.333300,0.000000,30.593100>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,-67.491441,0> translate<67.132200,0.000000,30.107700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,32.122200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.333300,0.000000,31.636800>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,67.491441,0> translate<67.132200,0.000000,32.122200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,32.647700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,32.122200>}
box{<0,0,-0.304800><0.525500,0.035000,0.304800> rotate<0,-90.000000,0> translate<67.132200,0.000000,32.122200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.132200,0.000000,32.647700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.333300,0.000000,33.133100>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,-67.491441,0> translate<67.132200,0.000000,32.647700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.138100,0.000000,18.821400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.481800,0.000000,18.821400>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,0.000000,0> translate<67.138100,0.000000,18.821400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.138100,0.000000,27.711400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.191800,0.000000,27.711400>}
box{<0,0,-0.304800><0.053700,0.035000,0.304800> rotate<0,0.000000,0> translate<67.138100,0.000000,27.711400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.164100,0.000000,38.002900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.407000,0.000000,38.245800>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<67.164100,0.000000,38.002900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.171400,0.000000,21.171200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,21.498500>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<67.171400,0.000000,21.171200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.333300,0.000000,30.593100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.704800,0.000000,30.964600>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,-44.997030,0> translate<67.333300,0.000000,30.593100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.333300,0.000000,31.636800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.704800,0.000000,31.265300>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,44.997030,0> translate<67.333300,0.000000,31.636800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.333300,0.000000,33.133100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.704800,0.000000,33.504600>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,-44.997030,0> translate<67.333300,0.000000,33.133100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.336200,0.000000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,21.336000>}
box{<0,0,-0.304800><0.420000,0.035000,0.304800> rotate<0,0.000000,0> translate<67.336200,0.000000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.407000,0.000000,38.245800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.436100,0.000000,38.316200>}
box{<0,0,-0.304800><0.076177,0.035000,0.304800> rotate<0,-67.537677,0> translate<67.407000,0.000000,38.245800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.436100,0.000000,38.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.806400,0.000000,38.316200>}
box{<0,0,-0.304800><0.370300,0.035000,0.304800> rotate<0,0.000000,0> translate<67.436100,0.000000,38.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.481800,0.000000,18.821400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.291800,0.000000,18.821400>}
box{<0,0,-0.304800><3.810000,0.035000,0.304800> rotate<0,0.000000,0> translate<67.481800,0.000000,18.821400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.489700,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.940200,0.000000,20.726400>}
box{<0,0,-0.304800><3.450500,0.035000,0.304800> rotate<0,0.000000,0> translate<67.489700,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,21.498500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,22.720100>}
box{<0,0,-0.304800><1.221600,0.035000,0.304800> rotate<0,90.000000,0> translate<67.498700,0.000000,22.720100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,21.945600>}
box{<0,0,-0.304800><0.257500,0.035000,0.304800> rotate<0,0.000000,0> translate<67.498700,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,22.555200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.663500,0.000000,22.555200>}
box{<0,0,-0.304800><0.164800,0.035000,0.304800> rotate<0,0.000000,0> translate<67.498700,0.000000,22.555200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,22.720100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,22.462500>}
box{<0,0,-0.304800><0.364231,0.035000,0.304800> rotate<0,45.008153,0> translate<67.498700,0.000000,22.720100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,24.986500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,26.391500>}
box{<0,0,-0.304800><1.405000,0.035000,0.304800> rotate<0,90.000000,0> translate<67.498700,0.000000,26.391500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,24.986500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,24.879700>}
box{<0,0,-0.304800><0.278770,0.035000,0.304800> rotate<0,22.525099,0> translate<67.498700,0.000000,24.986500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,24.993600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,24.993600>}
box{<0,0,-0.304800><0.257500,0.035000,0.304800> rotate<0,0.000000,0> translate<67.498700,0.000000,24.993600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,25.603200>}
box{<0,0,-0.304800><0.257500,0.035000,0.304800> rotate<0,0.000000,0> translate<67.498700,0.000000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.677300,0.000000,26.212800>}
box{<0,0,-0.304800><0.178600,0.035000,0.304800> rotate<0,0.000000,0> translate<67.498700,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.498700,0.000000,26.391500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.704800,0.000000,26.185300>}
box{<0,0,-0.304800><0.291540,0.035000,0.304800> rotate<0,45.010926,0> translate<67.498700,0.000000,26.391500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.667600,0.000000,20.548500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.762300,0.000000,20.548500>}
box{<0,0,-0.304800><3.094700,0.035000,0.304800> rotate<0,0.000000,0> translate<67.667600,0.000000,20.548500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.704800,0.000000,26.185300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.924300,0.000000,26.094400>}
box{<0,0,-0.304800><0.237577,0.035000,0.304800> rotate<0,22.494087,0> translate<67.704800,0.000000,26.185300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.704800,0.000000,30.964600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.067800,0.000000,31.114900>}
box{<0,0,-0.304800><0.392886,0.035000,0.304800> rotate<0,-22.490496,0> translate<67.704800,0.000000,30.964600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.704800,0.000000,31.265300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.067800,0.000000,31.114900>}
box{<0,0,-0.304800><0.392924,0.035000,0.304800> rotate<0,22.503968,0> translate<67.704800,0.000000,31.265300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.704800,0.000000,33.504600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.190200,0.000000,33.705700>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,-22.502619,0> translate<67.704800,0.000000,33.504600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,21.063500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.083500,0.000000,20.736200>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<67.756200,0.000000,21.063500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,22.462500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,21.063500>}
box{<0,0,-0.304800><1.399000,0.035000,0.304800> rotate<0,-90.000000,0> translate<67.756200,0.000000,21.063500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,25.926400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,24.879700>}
box{<0,0,-0.304800><1.046700,0.035000,0.304800> rotate<0,-90.000000,0> translate<67.756200,0.000000,24.879700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.756200,0.000000,25.926400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.924300,0.000000,26.094400>}
box{<0,0,-0.304800><0.237659,0.035000,0.304800> rotate<0,-44.979984,0> translate<67.756200,0.000000,25.926400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.806400,0.000000,38.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.044900,0.000000,38.554800>}
box{<0,0,-0.304800><0.337361,0.035000,0.304800> rotate<0,-45.009039,0> translate<67.806400,0.000000,38.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.806400,0.000000,44.233700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.044900,0.000000,43.995100>}
box{<0,0,-0.304800><0.337361,0.035000,0.304800> rotate<0,45.009039,0> translate<67.806400,0.000000,44.233700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<67.894900,0.000000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,38.404800>}
box{<0,0,-0.304800><0.456500,0.035000,0.304800> rotate<0,0.000000,0> translate<67.894900,0.000000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.044900,0.000000,38.554800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.083500,0.000000,38.516200>}
box{<0,0,-0.304800><0.054589,0.035000,0.304800> rotate<0,44.997030,0> translate<68.044900,0.000000,38.554800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.044900,0.000000,43.995100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.083500,0.000000,44.033700>}
box{<0,0,-0.304800><0.054589,0.035000,0.304800> rotate<0,-44.997030,0> translate<68.044900,0.000000,43.995100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.083500,0.000000,20.736200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,20.736200>}
box{<0,0,-0.304800><2.262900,0.035000,0.304800> rotate<0,0.000000,0> translate<68.083500,0.000000,20.736200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.083500,0.000000,38.516200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,38.516200>}
box{<0,0,-0.304800><0.267900,0.035000,0.304800> rotate<0,0.000000,0> translate<68.083500,0.000000,38.516200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.083500,0.000000,44.033700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,44.033700>}
box{<0,0,-0.304800><2.262900,0.035000,0.304800> rotate<0,0.000000,0> translate<68.083500,0.000000,44.033700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.190200,0.000000,33.705700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,33.705700>}
box{<0,0,-0.304800><0.161200,0.035000,0.304800> rotate<0,0.000000,0> translate<68.190200,0.000000,33.705700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,34.461800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,33.705700>}
box{<0,0,-0.304800><0.756100,0.035000,0.304800> rotate<0,-90.000000,0> translate<68.351400,0.000000,33.705700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,38.516200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<68.351400,0.000000,34.461800>}
box{<0,0,-0.304800><4.054400,0.035000,0.304800> rotate<0,-90.000000,0> translate<68.351400,0.000000,34.461800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.124800,0.000000,23.536200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.207400,0.000000,23.453700>}
box{<0,0,-0.304800><0.116743,0.035000,0.304800> rotate<0,44.962329,0> translate<69.124800,0.000000,23.536200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.124800,0.000000,23.536200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,23.536200>}
box{<0,0,-0.304800><1.221600,0.035000,0.304800> rotate<0,0.000000,0> translate<69.124800,0.000000,23.536200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.207400,0.000000,23.453700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,23.453700>}
box{<0,0,-0.304800><1.139000,0.035000,0.304800> rotate<0,0.000000,0> translate<69.207400,0.000000,23.453700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.443500,0.000000,41.233700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.443500,0.000000,41.316200>}
box{<0,0,-0.304800><0.082500,0.035000,0.304800> rotate<0,90.000000,0> translate<69.443500,0.000000,41.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.443500,0.000000,41.233700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,41.233700>}
box{<0,0,-0.304800><0.902900,0.035000,0.304800> rotate<0,0.000000,0> translate<69.443500,0.000000,41.233700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<69.443500,0.000000,41.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,41.316200>}
box{<0,0,-0.304800><0.902900,0.035000,0.304800> rotate<0,0.000000,0> translate<69.443500,0.000000,41.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,33.705700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,34.461800>}
box{<0,0,-0.304800><0.756100,0.035000,0.304800> rotate<0,90.000000,0> translate<70.078500,0.000000,34.461800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,33.705700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.239700,0.000000,33.705700>}
box{<0,0,-0.304800><0.161200,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,33.705700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,34.137600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,34.137600>}
box{<0,0,-0.304800><2.311500,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,34.137600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,34.461800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,38.516200>}
box{<0,0,-0.304800><4.054400,0.035000,0.304800> rotate<0,90.000000,0> translate<70.078500,0.000000,38.516200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,34.747200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,34.747200>}
box{<0,0,-0.304800><2.311500,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,34.747200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,35.356800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,35.356800>}
box{<0,0,-0.304800><2.311500,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,35.356800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,35.966400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,35.966400>}
box{<0,0,-0.304800><2.311500,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,35.966400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,36.576000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,36.576000>}
box{<0,0,-0.304800><2.311500,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,36.576000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,37.185600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,37.185600>}
box{<0,0,-0.304800><2.311500,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,37.185600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,37.795200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,37.795200>}
box{<0,0,-0.304800><2.311500,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,37.795200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,38.404800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,38.404800>}
box{<0,0,-0.304800><2.311500,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,38.404800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.078500,0.000000,38.516200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,38.516200>}
box{<0,0,-0.304800><0.267900,0.035000,0.304800> rotate<0,0.000000,0> translate<70.078500,0.000000,38.516200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.239700,0.000000,33.705700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.725100,0.000000,33.504600>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,22.502619,0> translate<70.239700,0.000000,33.705700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,20.736200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,21.063500>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.346400,0.000000,20.736200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,23.453700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,23.126400>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<70.346400,0.000000,23.453700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,23.536200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,23.863500>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.346400,0.000000,23.536200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,38.516200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,38.843500>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.346400,0.000000,38.516200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,41.233700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,40.906400>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<70.346400,0.000000,41.233700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,41.316200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,41.643500>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.346400,0.000000,41.316200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.346400,0.000000,44.033700>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,43.706400>}
box{<0,0,-0.304800><0.462872,0.035000,0.304800> rotate<0,44.997030,0> translate<70.346400,0.000000,44.033700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.362100,0.000000,31.114900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.725100,0.000000,30.964600>}
box{<0,0,-0.304800><0.392886,0.035000,0.304800> rotate<0,22.490496,0> translate<70.362100,0.000000,31.114900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.362100,0.000000,31.114900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.725100,0.000000,31.265300>}
box{<0,0,-0.304800><0.392924,0.035000,0.304800> rotate<0,-22.503968,0> translate<70.362100,0.000000,31.114900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.423300,0.000000,31.089600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,31.089600>}
box{<0,0,-0.304800><1.966700,0.035000,0.304800> rotate<0,0.000000,0> translate<70.423300,0.000000,31.089600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.483000,0.000000,41.452800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,41.452800>}
box{<0,0,-0.304800><1.907000,0.035000,0.304800> rotate<0,0.000000,0> translate<70.483000,0.000000,41.452800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.488900,0.000000,43.891200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,43.891200>}
box{<0,0,-0.304800><1.901100,0.035000,0.304800> rotate<0,0.000000,0> translate<70.488900,0.000000,43.891200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.505600,0.000000,26.094400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,25.926400>}
box{<0,0,-0.304800><0.237659,0.035000,0.304800> rotate<0,44.979984,0> translate<70.505600,0.000000,26.094400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.505600,0.000000,26.094400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.725100,0.000000,26.185300>}
box{<0,0,-0.304800><0.237577,0.035000,0.304800> rotate<0,-22.494087,0> translate<70.505600,0.000000,26.094400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.584600,0.000000,23.774400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,23.774400>}
box{<0,0,-0.304800><0.941800,0.035000,0.304800> rotate<0,0.000000,0> translate<70.584600,0.000000,23.774400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.635300,0.000000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,23.164800>}
box{<0,0,-0.304800><0.891100,0.035000,0.304800> rotate<0,0.000000,0> translate<70.635300,0.000000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.668700,0.000000,33.528000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,33.528000>}
box{<0,0,-0.304800><1.721300,0.035000,0.304800> rotate<0,0.000000,0> translate<70.668700,0.000000,33.528000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,21.063500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,23.126400>}
box{<0,0,-0.304800><2.062900,0.035000,0.304800> rotate<0,90.000000,0> translate<70.673700,0.000000,23.126400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,21.336000>}
box{<0,0,-0.304800><0.852700,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,21.945600>}
box{<0,0,-0.304800><0.852700,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,22.555200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,22.555200>}
box{<0,0,-0.304800><0.852700,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,22.555200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,23.863500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,25.926400>}
box{<0,0,-0.304800><2.062900,0.035000,0.304800> rotate<0,90.000000,0> translate<70.673700,0.000000,25.926400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,24.384000>}
box{<0,0,-0.304800><0.852700,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,24.993600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,24.993600>}
box{<0,0,-0.304800><0.852700,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,24.993600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,25.603200>}
box{<0,0,-0.304800><0.852700,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,38.843500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,40.906400>}
box{<0,0,-0.304800><2.062900,0.035000,0.304800> rotate<0,90.000000,0> translate<70.673700,0.000000,40.906400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,39.014400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,39.014400>}
box{<0,0,-0.304800><1.716300,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,39.014400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,39.624000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,39.624000>}
box{<0,0,-0.304800><1.716300,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,39.624000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,40.233600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,40.233600>}
box{<0,0,-0.304800><1.716300,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,40.233600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,40.843200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,40.843200>}
box{<0,0,-0.304800><1.716300,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,40.843200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,41.643500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,43.706400>}
box{<0,0,-0.304800><2.062900,0.035000,0.304800> rotate<0,90.000000,0> translate<70.673700,0.000000,43.706400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,42.062400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,42.062400>}
box{<0,0,-0.304800><1.716300,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,42.062400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,42.672000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,42.672000>}
box{<0,0,-0.304800><1.716300,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,42.672000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.673700,0.000000,43.281600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,43.281600>}
box{<0,0,-0.304800><1.716300,0.035000,0.304800> rotate<0,0.000000,0> translate<70.673700,0.000000,43.281600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.725100,0.000000,26.185300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.096600,0.000000,26.556800>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.725100,0.000000,26.185300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.725100,0.000000,30.964600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.096600,0.000000,30.593100>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,44.997030,0> translate<70.725100,0.000000,30.964600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.725100,0.000000,31.265300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.096600,0.000000,31.636800>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.725100,0.000000,31.265300> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.725100,0.000000,33.504600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.096600,0.000000,33.133100>}
box{<0,0,-0.304800><0.525380,0.035000,0.304800> rotate<0,44.997030,0> translate<70.725100,0.000000,33.504600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.752600,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,26.212800>}
box{<0,0,-0.304800><0.773800,0.035000,0.304800> rotate<0,0.000000,0> translate<70.752600,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<70.762300,0.000000,20.548500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,21.312600>}
box{<0,0,-0.304800><1.080601,0.035000,0.304800> rotate<0,-44.997030,0> translate<70.762300,0.000000,20.548500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.096600,0.000000,26.556800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.297700,0.000000,27.042200>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,-67.491441,0> translate<71.096600,0.000000,26.556800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.096600,0.000000,30.593100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.297700,0.000000,30.107700>}
box{<0,0,-0.304800><0.525409,0.035000,0.304800> rotate<0,67.491441,0> translate<71.096600,0.000000,30.593100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.096600,0.000000,31.636800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.194700,0.000000,31.873500>}
box{<0,0,-0.304800><0.256224,0.035000,0.304800> rotate<0,-67.484049,0> translate<71.096600,0.000000,31.636800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.096600,0.000000,33.133100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.194700,0.000000,32.896400>}
box{<0,0,-0.304800><0.256224,0.035000,0.304800> rotate<0,67.484049,0> translate<71.096600,0.000000,33.133100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.122400,0.000000,31.699200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,31.699200>}
box{<0,0,-0.304800><1.267600,0.035000,0.304800> rotate<0,0.000000,0> translate<71.122400,0.000000,31.699200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.143500,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,30.480000>}
box{<0,0,-0.304800><1.246500,0.035000,0.304800> rotate<0,0.000000,0> translate<71.143500,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.185600,0.000000,32.918400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,32.918400>}
box{<0,0,-0.304800><1.204400,0.035000,0.304800> rotate<0,0.000000,0> translate<71.185600,0.000000,32.918400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.194700,0.000000,31.873500>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.217000,0.000000,31.895800>}
box{<0,0,-0.304800><0.031537,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.194700,0.000000,31.873500> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.194700,0.000000,32.896400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.217000,0.000000,32.874100>}
box{<0,0,-0.304800><0.031537,0.035000,0.304800> rotate<0,44.997030,0> translate<71.194700,0.000000,32.896400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.206600,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,26.822400>}
box{<0,0,-0.304800><0.319800,0.035000,0.304800> rotate<0,0.000000,0> translate<71.206600,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.217000,0.000000,31.895800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.348500,0.000000,32.213100>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-67.484752,0> translate<71.217000,0.000000,31.895800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.217000,0.000000,32.874100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.348500,0.000000,32.556800>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,67.484752,0> translate<71.217000,0.000000,32.874100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.291800,0.000000,18.821400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.609100,0.000000,18.952900>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-22.509308,0> translate<71.291800,0.000000,18.821400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.297700,0.000000,27.042200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.297700,0.000000,27.176100>}
box{<0,0,-0.304800><0.133900,0.035000,0.304800> rotate<0,90.000000,0> translate<71.297700,0.000000,27.176100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.297700,0.000000,27.176100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,26.947300>}
box{<0,0,-0.304800><0.323501,0.035000,0.304800> rotate<0,45.009553,0> translate<71.297700,0.000000,27.176100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.297700,0.000000,29.618400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.297700,0.000000,30.107700>}
box{<0,0,-0.304800><0.489300,0.035000,0.304800> rotate<0,90.000000,0> translate<71.297700,0.000000,30.107700> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.297700,0.000000,29.618400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.879100,0.000000,28.037000>}
box{<0,0,-0.304800><2.236437,0.035000,0.304800> rotate<0,44.997030,0> translate<71.297700,0.000000,29.618400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.297700,0.000000,29.870400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,29.870400>}
box{<0,0,-0.304800><1.092300,0.035000,0.304800> rotate<0,0.000000,0> translate<71.297700,0.000000,29.870400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.348500,0.000000,32.213100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.348500,0.000000,32.556800>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,90.000000,0> translate<71.348500,0.000000,32.556800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.348500,0.000000,32.308800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,32.308800>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<71.348500,0.000000,32.308800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.475600,0.000000,18.897600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.507600,0.000000,18.897600>}
box{<0,0,-0.304800><2.032000,0.035000,0.304800> rotate<0,0.000000,0> translate<71.475600,0.000000,18.897600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,26.947300>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.526400,0.000000,21.312600>}
box{<0,0,-0.304800><5.634700,0.035000,0.304800> rotate<0,-90.000000,0> translate<71.526400,0.000000,21.312600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.609100,0.000000,18.952900>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.852000,0.000000,19.195800>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.609100,0.000000,18.952900> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.655300,0.000000,29.260800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.974200,0.000000,29.260800>}
box{<0,0,-0.304800><1.318900,0.035000,0.304800> rotate<0,0.000000,0> translate<71.655300,0.000000,29.260800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<71.852000,0.000000,19.195800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.122000,0.000000,20.465800>}
box{<0,0,-0.304800><1.796051,0.035000,0.304800> rotate<0,-44.997030,0> translate<71.852000,0.000000,19.195800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.163400,0.000000,19.507200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.117200,0.000000,19.507200>}
box{<0,0,-0.304800><1.953800,0.035000,0.304800> rotate<0,0.000000,0> translate<72.163400,0.000000,19.507200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.264900,0.000000,28.651200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.583800,0.000000,28.651200>}
box{<0,0,-0.304800><1.318900,0.035000,0.304800> rotate<0,0.000000,0> translate<72.264900,0.000000,28.651200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,17.780000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,19.685000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,-44.997030,0> translate<72.390000,0.000000,17.780000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,27.940000>}
box{<0,0,-0.304800><2.694077,0.035000,0.304800> rotate<0,44.997030,0> translate<72.390000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.390000,0.000000,29.845000>}
box{<0,0,-0.304800><15.240000,0.035000,0.304800> rotate<0,-90.000000,0> translate<72.390000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.773000,0.000000,20.116800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,20.116800>}
box{<0,0,-0.304800><1.522000,0.035000,0.304800> rotate<0,0.000000,0> translate<72.773000,0.000000,20.116800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.874500,0.000000,28.041600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.193400,0.000000,28.041600>}
box{<0,0,-0.304800><1.318900,0.035000,0.304800> rotate<0,0.000000,0> translate<72.874500,0.000000,28.041600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<72.879100,0.000000,28.037000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.122000,0.000000,27.794100>}
box{<0,0,-0.304800><0.343512,0.035000,0.304800> rotate<0,44.997030,0> translate<72.879100,0.000000,28.037000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.122000,0.000000,20.465800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,20.783100>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,-67.484752,0> translate<73.122000,0.000000,20.465800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.122000,0.000000,27.794100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,27.476800>}
box{<0,0,-0.304800><0.343470,0.035000,0.304800> rotate<0,67.484752,0> translate<73.122000,0.000000,27.794100> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.230000,0.000000,20.726400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,20.726400>}
box{<0,0,-0.304800><1.065000,0.035000,0.304800> rotate<0,0.000000,0> translate<73.230000,0.000000,20.726400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,20.783100>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,21.126800>}
box{<0,0,-0.304800><0.343700,0.035000,0.304800> rotate<0,90.000000,0> translate<73.253500,0.000000,21.126800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,21.126800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,27.476800>}
box{<0,0,-0.304800><6.350000,0.035000,0.304800> rotate<0,90.000000,0> translate<73.253500,0.000000,27.476800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,21.336000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,21.336000>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,21.336000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,21.945600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,21.945600>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,21.945600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,22.555200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,22.555200>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,22.555200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,23.164800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,23.164800>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,23.164800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,23.774400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,23.774400>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,23.774400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,24.384000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,24.384000>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,24.384000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,24.993600>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,24.993600>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,24.993600> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,25.603200>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,25.603200>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,25.603200> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,26.212800>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,26.212800>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,26.212800> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,26.822400>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,26.822400>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,26.822400> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<73.253500,0.000000,27.432000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,27.432000>}
box{<0,0,-0.304800><1.041500,0.035000,0.304800> rotate<0,0.000000,0> translate<73.253500,0.000000,27.432000> }
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.304800 translate<74.295000,0.000000,19.685000>}
box{<0,0,-0.304800><8.255000,0.035000,0.304800> rotate<0,-90.000000,0> translate<74.295000,0.000000,19.685000> }
texture{col_pol}
}
#end
union{
cylinder{<43.180000,0.038000,38.100000><43.180000,-1.538000,38.100000>0.508000}
cylinder{<43.180000,0.038000,40.640000><43.180000,-1.538000,40.640000>0.508000}
cylinder{<69.215000,0.038000,32.385000><69.215000,-1.538000,32.385000>0.508000}
cylinder{<69.215000,0.038000,29.845000><69.215000,-1.538000,29.845000>0.508000}
cylinder{<69.215000,0.038000,27.305000><69.215000,-1.538000,27.305000>0.508000}
cylinder{<44.450000,0.038000,25.400000><44.450000,-1.538000,25.400000>0.508000}
cylinder{<44.450000,0.038000,27.940000><44.450000,-1.538000,27.940000>0.508000}
cylinder{<44.450000,0.038000,30.480000><44.450000,-1.538000,30.480000>0.508000}
//Furatok(valós)/Átvezetések
//Furatok(valós)/Panel
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Szitanyomat
union{
//C1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.538000,0.000000,22.530000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.538000,0.000000,24.460000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<59.538000,0.000000,24.460000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.112000,0.000000,22.530000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.112000,0.000000,24.460000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<61.112000,0.000000,24.460000> }
box{<-0.375000,0,-0.850000><0.375000,0.036000,0.850000> rotate<0,-90.000000,0> translate<60.325800,0.000000,22.168300>}
box{<-0.375000,0,-0.850000><0.375000,0.036000,0.850000> rotate<0,-90.000000,0> translate<60.324100,0.000000,24.821700>}
//C2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.428000,0.000000,22.530000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.428000,0.000000,24.460000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<68.428000,0.000000,24.460000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.002000,0.000000,22.530000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.002000,0.000000,24.460000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<70.002000,0.000000,24.460000> }
box{<-0.375000,0,-0.850000><0.375000,0.036000,0.850000> rotate<0,-90.000000,0> translate<69.215800,0.000000,22.168300>}
box{<-0.375000,0,-0.850000><0.375000,0.036000,0.850000> rotate<0,-90.000000,0> translate<69.214100,0.000000,24.821700>}
//C3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.538000,0.000000,40.945000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<59.538000,0.000000,42.875000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<59.538000,0.000000,42.875000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.112000,0.000000,40.945000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<61.112000,0.000000,42.875000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<61.112000,0.000000,42.875000> }
box{<-0.375000,0,-0.850000><0.375000,0.036000,0.850000> rotate<0,-90.000000,0> translate<60.325800,0.000000,40.583300>}
box{<-0.375000,0,-0.850000><0.375000,0.036000,0.850000> rotate<0,-90.000000,0> translate<60.324100,0.000000,43.236700>}
//C4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.428000,0.000000,40.310000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<68.428000,0.000000,42.240000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<68.428000,0.000000,42.240000> }
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.002000,0.000000,40.310000>}
cylinder{<0,0,0><0,0.036000,0>0.050800 translate<70.002000,0.000000,42.240000>}
box{<0,0,-0.050800><1.930000,0.036000,0.050800> rotate<0,90.000000,0> translate<70.002000,0.000000,42.240000> }
box{<-0.375000,0,-0.850000><0.375000,0.036000,0.850000> rotate<0,-90.000000,0> translate<69.215800,0.000000,39.948300>}
box{<-0.375000,0,-0.850000><0.375000,0.036000,0.850000> rotate<0,-90.000000,0> translate<69.214100,0.000000,42.601700>}
//E$1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.835000,0.000000,35.523800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.835000,0.000000,33.401000>}
box{<0,0,-0.076200><2.122800,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.835000,0.000000,33.401000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.835000,0.000000,33.401000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.835000,0.000000,32.385000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.835000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.835000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.835000,0.000000,30.262200>}
box{<0,0,-0.076200><2.122800,0.036000,0.076200> rotate<0,-90.000000,0> translate<60.835000,0.000000,30.262200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.835000,0.000000,30.262200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.165000,0.000000,30.262200>}
box{<0,0,-0.076200><5.330000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.835000,0.000000,30.262200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.165000,0.000000,30.262200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.165000,0.000000,35.523800>}
box{<0,0,-0.076200><5.261600,0.036000,0.076200> rotate<0,90.000000,0> translate<66.165000,0.000000,35.523800> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.165000,0.000000,35.523800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<60.835000,0.000000,35.523800>}
box{<0,0,-0.076200><5.330000,0.036000,0.076200> rotate<0,0.000000,0> translate<60.835000,0.000000,35.523800> }
object{ARC(0.508000,0.152400,270.000000,450.000000,0.036000) translate<60.835000,0.000000,32.893000>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<60.835000,0.000000,30.617800>}
cylinder{<0,0,0><0,0.036000,0>0.025400 translate<66.040000,0.000000,30.617800>}
box{<0,0,-0.025400><5.205000,0.036000,0.025400> rotate<0,0.000000,0> translate<60.835000,0.000000,30.617800> }
box{<-0.254000,0,-0.697100><0.254000,0.036000,0.697100> rotate<0,-0.000000,0> translate<65.405000,0.000000,36.220900>}
box{<-0.254000,0,-0.697100><0.254000,0.036000,0.697100> rotate<0,-0.000000,0> translate<61.595000,0.000000,29.565100>}
box{<-0.254000,0,-0.697100><0.254000,0.036000,0.697100> rotate<0,-0.000000,0> translate<62.865000,0.000000,29.565100>}
box{<-0.254000,0,-0.709800><0.254000,0.036000,0.709800> rotate<0,-0.000000,0> translate<64.135000,0.000000,29.577800>}
box{<-0.254000,0,-0.697100><0.254000,0.036000,0.697100> rotate<0,-0.000000,0> translate<65.405000,0.000000,29.565100>}
box{<-0.254000,0,-0.697100><0.254000,0.036000,0.697100> rotate<0,-0.000000,0> translate<64.135000,0.000000,36.220900>}
box{<-0.254000,0,-0.697100><0.254000,0.036000,0.697100> rotate<0,-0.000000,0> translate<62.865000,0.000000,36.220900>}
box{<-0.254000,0,-0.697100><0.254000,0.036000,0.697100> rotate<0,-0.000000,0> translate<61.595000,0.000000,36.220900>}
//E$2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,38.735000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.910000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,39.370000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.910000,0.000000,38.735000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,39.370000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,38.735000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.815000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,36.830000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,36.830000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.910000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,37.465000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.815000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,38.735000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,37.465000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,40.005000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<41.910000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,41.275000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<41.910000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<41.910000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,41.910000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<41.910000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<42.545000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,41.910000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<42.545000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,41.275000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.815000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,40.005000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<44.450000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<44.450000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,39.370000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.815000,0.000000,39.370000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<43.180000,0.000000,38.100000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<43.180000,0.000000,40.640000>}
//E$3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.913000,0.000000,42.595800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.913000,0.000000,39.954200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.913000,0.000000,39.954200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,42.595800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.437000,0.000000,39.954200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<67.437000,0.000000,39.954200> }
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<66.675000,0.000000,39.700200>}
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<66.675000,0.000000,42.849800>}
//E$4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.278000,0.000000,25.450800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<65.278000,0.000000,22.809200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<65.278000,0.000000,22.809200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,25.450800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<66.802000,0.000000,22.809200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<66.802000,0.000000,22.809200> }
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<66.040000,0.000000,22.555200>}
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<66.040000,0.000000,25.704800>}
//E$5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,31.750000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.485000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,31.115000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.850000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,31.115000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.580000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,31.750000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<67.945000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,30.480000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<69.850000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,29.210000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.485000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,28.575000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.850000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,28.575000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.580000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,29.210000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<67.945000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,30.480000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.945000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,31.115000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.945000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,33.655000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.580000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,33.655000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<69.850000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,33.020000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.945000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,33.020000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.945000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,27.940000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<69.850000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,26.670000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<70.485000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<70.485000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,26.035000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<69.850000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<69.850000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,26.035000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<68.580000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,26.670000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<67.945000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,27.940000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<67.945000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<67.945000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<68.580000,0.000000,28.575000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<67.945000,0.000000,27.940000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<69.215000,0.000000,29.845000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<69.215000,0.000000,32.385000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-270.000000,0> translate<69.215000,0.000000,27.305000>}
//E$6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,26.035000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.180000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,26.670000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.180000,0.000000,26.035000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,26.670000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.815000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,26.035000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<45.085000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,27.305000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.180000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,28.575000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.180000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,29.210000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.180000,0.000000,28.575000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,29.210000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.815000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,28.575000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<45.085000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,28.575000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,27.305000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.720000,0.000000,27.305000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,27.305000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,26.670000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<45.085000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,24.130000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.815000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,24.130000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.180000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,24.130000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,24.765000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<45.085000,0.000000,24.130000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,26.035000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,24.765000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.720000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,29.845000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<43.180000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,31.115000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,90.000000,0> translate<43.180000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.180000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,31.750000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<43.180000,0.000000,31.115000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<43.815000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,31.750000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,0.000000,0> translate<43.815000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,31.115000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,44.997030,0> translate<45.085000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,31.115000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,29.845000>}
box{<0,0,-0.076200><1.270000,0.036000,0.076200> rotate<0,-90.000000,0> translate<45.720000,0.000000,29.845000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.720000,0.000000,29.845000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<45.085000,0.000000,29.210000>}
box{<0,0,-0.076200><0.898026,0.036000,0.076200> rotate<0,-44.997030,0> translate<45.085000,0.000000,29.210000> }
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<44.450000,0.000000,27.940000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<44.450000,0.000000,25.400000>}
box{<-0.254000,0,-0.254000><0.254000,0.036000,0.254000> rotate<0,-90.000000,0> translate<44.450000,0.000000,30.480000>}
//E$10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.916000,0.000000,38.811200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,38.811200>}
box{<0,0,-0.101600><0.049000,0.036000,0.101600> rotate<0,0.000000,0> translate<47.916000,0.000000,38.811200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.776100,0.000000,39.014400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,39.014400>}
box{<0,0,-0.101600><0.188900,0.036000,0.101600> rotate<0,0.000000,0> translate<47.776100,0.000000,39.014400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.662200,0.000000,39.217600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,39.217600>}
box{<0,0,-0.101600><0.302800,0.036000,0.101600> rotate<0,0.000000,0> translate<47.662200,0.000000,39.217600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.559900,0.000000,39.420800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,39.420800>}
box{<0,0,-0.101600><0.405100,0.036000,0.101600> rotate<0,0.000000,0> translate<47.559900,0.000000,39.420800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.486900,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,39.624000>}
box{<0,0,-0.101600><0.478100,0.036000,0.101600> rotate<0,0.000000,0> translate<47.486900,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.417300,0.000000,39.827200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,39.827200>}
box{<0,0,-0.101600><0.547700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.417300,0.000000,39.827200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.377300,0.000000,40.030400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,40.030400>}
box{<0,0,-0.101600><0.587700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.377300,0.000000,40.030400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.337900,0.000000,40.233600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,40.233600>}
box{<0,0,-0.101600><0.627100,0.036000,0.101600> rotate<0,0.000000,0> translate<47.337900,0.000000,40.233600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.326500,0.000000,40.436800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,40.436800>}
box{<0,0,-0.101600><0.638500,0.036000,0.101600> rotate<0,0.000000,0> translate<47.326500,0.000000,40.436800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.315000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,40.640000>}
box{<0,0,-0.101600><0.650000,0.036000,0.101600> rotate<0,0.000000,0> translate<47.315000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.330800,0.000000,40.843200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,40.843200>}
box{<0,0,-0.101600><0.634200,0.036000,0.101600> rotate<0,0.000000,0> translate<47.330800,0.000000,40.843200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.346600,0.000000,41.046400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,41.046400>}
box{<0,0,-0.101600><0.618400,0.036000,0.101600> rotate<0,0.000000,0> translate<47.346600,0.000000,41.046400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.388500,0.000000,41.249600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,41.249600>}
box{<0,0,-0.101600><0.576500,0.036000,0.101600> rotate<0,0.000000,0> translate<47.388500,0.000000,41.249600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.431300,0.000000,41.452800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,41.452800>}
box{<0,0,-0.101600><0.533700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.431300,0.000000,41.452800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.500800,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,41.656000>}
box{<0,0,-0.101600><0.464200,0.036000,0.101600> rotate<0,0.000000,0> translate<47.500800,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.574300,0.000000,41.859200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,41.859200>}
box{<0,0,-0.101600><0.390700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.574300,0.000000,41.859200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.673800,0.000000,42.062400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,42.062400>}
box{<0,0,-0.101600><0.291200,0.036000,0.101600> rotate<0,0.000000,0> translate<47.673800,0.000000,42.062400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.784500,0.000000,42.265600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,42.265600>}
box{<0,0,-0.101600><0.180500,0.036000,0.101600> rotate<0,0.000000,0> translate<47.784500,0.000000,42.265600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.918100,0.000000,42.468800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,42.468800>}
box{<0,0,-0.101600><0.046900,0.036000,0.101600> rotate<0,0.000000,0> translate<47.918100,0.000000,42.468800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,42.540000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,38.740000>}
box{<0,0,-0.101600><3.800000,0.036000,0.101600> rotate<0,-90.000000,0> translate<47.965000,0.000000,38.740000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,38.740000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.732900,0.000000,39.077000>}
box{<0,0,-0.101600><0.409194,0.036000,0.101600> rotate<0,55.440222,0> translate<47.732900,0.000000,39.077000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.732900,0.000000,39.077000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.548900,0.000000,39.442600>}
box{<0,0,-0.101600><0.409291,0.036000,0.101600> rotate<0,63.280521,0> translate<47.548900,0.000000,39.442600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.548900,0.000000,39.442600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.416400,0.000000,39.829800>}
box{<0,0,-0.101600><0.409243,0.036000,0.101600> rotate<0,71.104339,0> translate<47.416400,0.000000,39.829800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.416400,0.000000,39.829800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.338000,0.000000,40.231400>}
box{<0,0,-0.101600><0.409181,0.036000,0.101600> rotate<0,78.948486,0> translate<47.338000,0.000000,40.231400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.338000,0.000000,40.231400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.315000,0.000000,40.640000>}
box{<0,0,-0.101600><0.409247,0.036000,0.101600> rotate<0,86.772507,0> translate<47.315000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.315000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.346700,0.000000,41.046800>}
box{<0,0,-0.101600><0.408033,0.036000,0.101600> rotate<0,-85.538570,0> translate<47.315000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.346700,0.000000,41.046800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.429200,0.000000,41.446500>}
box{<0,0,-0.101600><0.408125,0.036000,0.101600> rotate<0,-78.332482,0> translate<47.346700,0.000000,41.046800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.429200,0.000000,41.446500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.561300,0.000000,41.832600>}
box{<0,0,-0.101600><0.408073,0.036000,0.101600> rotate<0,-71.107472,0> translate<47.429200,0.000000,41.446500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.561300,0.000000,41.832600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.740800,0.000000,42.199000>}
box{<0,0,-0.101600><0.408006,0.036000,0.101600> rotate<0,-63.895469,0> translate<47.561300,0.000000,41.832600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.740800,0.000000,42.199000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,42.540000>}
box{<0,0,-0.101600><0.408101,0.036000,0.101600> rotate<0,-56.672220,0> translate<47.740800,0.000000,42.199000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,43.840000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,43.840000>}
box{<0,0,-0.101600><5.600000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.965000,0.000000,43.840000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,43.840000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,43.040000>}
box{<0,0,-0.101600><1.131371,0.036000,0.101600> rotate<0,44.997030,0> translate<52.565000,0.000000,43.840000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,43.040000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,38.240000>}
box{<0,0,-0.101600><4.800000,0.036000,0.101600> rotate<0,-90.000000,0> translate<53.365000,0.000000,38.240000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,38.240000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,37.440000>}
box{<0,0,-0.101600><1.131371,0.036000,0.101600> rotate<0,-44.997030,0> translate<52.565000,0.000000,37.440000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,37.440000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,37.440000>}
box{<0,0,-0.101600><5.600000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.965000,0.000000,37.440000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,37.440000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,43.840000>}
box{<0,0,-0.101600><6.400000,0.036000,0.101600> rotate<0,90.000000,0> translate<46.965000,0.000000,43.840000> }
difference{
cylinder{<50.165000,0,40.640000><50.165000,0.036000,40.640000>3.051600 translate<0,0.000000,0>}
cylinder{<50.165000,-0.1,40.640000><50.165000,0.135000,40.640000>2.848400 translate<0,0.000000,0>}}
//E$11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.916000,0.000000,30.556200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,30.556200>}
box{<0,0,-0.101600><0.049000,0.036000,0.101600> rotate<0,0.000000,0> translate<47.916000,0.000000,30.556200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.776100,0.000000,30.759400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,30.759400>}
box{<0,0,-0.101600><0.188900,0.036000,0.101600> rotate<0,0.000000,0> translate<47.776100,0.000000,30.759400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.662200,0.000000,30.962600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,30.962600>}
box{<0,0,-0.101600><0.302800,0.036000,0.101600> rotate<0,0.000000,0> translate<47.662200,0.000000,30.962600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.559900,0.000000,31.165800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,31.165800>}
box{<0,0,-0.101600><0.405100,0.036000,0.101600> rotate<0,0.000000,0> translate<47.559900,0.000000,31.165800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.486900,0.000000,31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,31.369000>}
box{<0,0,-0.101600><0.478100,0.036000,0.101600> rotate<0,0.000000,0> translate<47.486900,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.417300,0.000000,31.572200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,31.572200>}
box{<0,0,-0.101600><0.547700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.417300,0.000000,31.572200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.377300,0.000000,31.775400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,31.775400>}
box{<0,0,-0.101600><0.587700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.377300,0.000000,31.775400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.337900,0.000000,31.978600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,31.978600>}
box{<0,0,-0.101600><0.627100,0.036000,0.101600> rotate<0,0.000000,0> translate<47.337900,0.000000,31.978600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.326500,0.000000,32.181800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,32.181800>}
box{<0,0,-0.101600><0.638500,0.036000,0.101600> rotate<0,0.000000,0> translate<47.326500,0.000000,32.181800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.315000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,32.385000>}
box{<0,0,-0.101600><0.650000,0.036000,0.101600> rotate<0,0.000000,0> translate<47.315000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.330800,0.000000,32.588200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,32.588200>}
box{<0,0,-0.101600><0.634200,0.036000,0.101600> rotate<0,0.000000,0> translate<47.330800,0.000000,32.588200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.346600,0.000000,32.791400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,32.791400>}
box{<0,0,-0.101600><0.618400,0.036000,0.101600> rotate<0,0.000000,0> translate<47.346600,0.000000,32.791400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.388500,0.000000,32.994600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,32.994600>}
box{<0,0,-0.101600><0.576500,0.036000,0.101600> rotate<0,0.000000,0> translate<47.388500,0.000000,32.994600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.431300,0.000000,33.197800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,33.197800>}
box{<0,0,-0.101600><0.533700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.431300,0.000000,33.197800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.500800,0.000000,33.401000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,33.401000>}
box{<0,0,-0.101600><0.464200,0.036000,0.101600> rotate<0,0.000000,0> translate<47.500800,0.000000,33.401000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.574300,0.000000,33.604200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,33.604200>}
box{<0,0,-0.101600><0.390700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.574300,0.000000,33.604200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.673800,0.000000,33.807400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,33.807400>}
box{<0,0,-0.101600><0.291200,0.036000,0.101600> rotate<0,0.000000,0> translate<47.673800,0.000000,33.807400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.784500,0.000000,34.010600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,34.010600>}
box{<0,0,-0.101600><0.180500,0.036000,0.101600> rotate<0,0.000000,0> translate<47.784500,0.000000,34.010600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.918100,0.000000,34.213800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,34.213800>}
box{<0,0,-0.101600><0.046900,0.036000,0.101600> rotate<0,0.000000,0> translate<47.918100,0.000000,34.213800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,34.285000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,30.485000>}
box{<0,0,-0.101600><3.800000,0.036000,0.101600> rotate<0,-90.000000,0> translate<47.965000,0.000000,30.485000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,30.485000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.732900,0.000000,30.822000>}
box{<0,0,-0.101600><0.409194,0.036000,0.101600> rotate<0,55.440222,0> translate<47.732900,0.000000,30.822000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.732900,0.000000,30.822000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.548900,0.000000,31.187600>}
box{<0,0,-0.101600><0.409291,0.036000,0.101600> rotate<0,63.280521,0> translate<47.548900,0.000000,31.187600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.548900,0.000000,31.187600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.416400,0.000000,31.574800>}
box{<0,0,-0.101600><0.409243,0.036000,0.101600> rotate<0,71.104339,0> translate<47.416400,0.000000,31.574800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.416400,0.000000,31.574800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.338000,0.000000,31.976400>}
box{<0,0,-0.101600><0.409181,0.036000,0.101600> rotate<0,78.948486,0> translate<47.338000,0.000000,31.976400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.338000,0.000000,31.976400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.315000,0.000000,32.385000>}
box{<0,0,-0.101600><0.409247,0.036000,0.101600> rotate<0,86.772507,0> translate<47.315000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.315000,0.000000,32.385000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.346700,0.000000,32.791800>}
box{<0,0,-0.101600><0.408033,0.036000,0.101600> rotate<0,-85.538570,0> translate<47.315000,0.000000,32.385000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.346700,0.000000,32.791800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.429200,0.000000,33.191500>}
box{<0,0,-0.101600><0.408125,0.036000,0.101600> rotate<0,-78.332482,0> translate<47.346700,0.000000,32.791800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.429200,0.000000,33.191500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.561300,0.000000,33.577600>}
box{<0,0,-0.101600><0.408073,0.036000,0.101600> rotate<0,-71.107472,0> translate<47.429200,0.000000,33.191500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.561300,0.000000,33.577600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.740800,0.000000,33.944000>}
box{<0,0,-0.101600><0.408006,0.036000,0.101600> rotate<0,-63.895469,0> translate<47.561300,0.000000,33.577600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.740800,0.000000,33.944000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,34.285000>}
box{<0,0,-0.101600><0.408101,0.036000,0.101600> rotate<0,-56.672220,0> translate<47.740800,0.000000,33.944000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,35.585000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,35.585000>}
box{<0,0,-0.101600><5.600000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.965000,0.000000,35.585000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,35.585000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,34.785000>}
box{<0,0,-0.101600><1.131371,0.036000,0.101600> rotate<0,44.997030,0> translate<52.565000,0.000000,35.585000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,34.785000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,29.985000>}
box{<0,0,-0.101600><4.800000,0.036000,0.101600> rotate<0,-90.000000,0> translate<53.365000,0.000000,29.985000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,29.985000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,29.185000>}
box{<0,0,-0.101600><1.131371,0.036000,0.101600> rotate<0,-44.997030,0> translate<52.565000,0.000000,29.185000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,29.185000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,29.185000>}
box{<0,0,-0.101600><5.600000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.965000,0.000000,29.185000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,29.185000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,35.585000>}
box{<0,0,-0.101600><6.400000,0.036000,0.101600> rotate<0,90.000000,0> translate<46.965000,0.000000,35.585000> }
difference{
cylinder{<50.165000,0,32.385000><50.165000,0.036000,32.385000>3.051600 translate<0,0.000000,0>}
cylinder{<50.165000,-0.1,32.385000><50.165000,0.135000,32.385000>2.848400 translate<0,0.000000,0>}}
//E$12 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.916000,0.000000,22.936200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,22.936200>}
box{<0,0,-0.101600><0.049000,0.036000,0.101600> rotate<0,0.000000,0> translate<47.916000,0.000000,22.936200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.776100,0.000000,23.139400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,23.139400>}
box{<0,0,-0.101600><0.188900,0.036000,0.101600> rotate<0,0.000000,0> translate<47.776100,0.000000,23.139400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.662200,0.000000,23.342600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,23.342600>}
box{<0,0,-0.101600><0.302800,0.036000,0.101600> rotate<0,0.000000,0> translate<47.662200,0.000000,23.342600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.559900,0.000000,23.545800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,23.545800>}
box{<0,0,-0.101600><0.405100,0.036000,0.101600> rotate<0,0.000000,0> translate<47.559900,0.000000,23.545800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.486900,0.000000,23.749000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,23.749000>}
box{<0,0,-0.101600><0.478100,0.036000,0.101600> rotate<0,0.000000,0> translate<47.486900,0.000000,23.749000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.417300,0.000000,23.952200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,23.952200>}
box{<0,0,-0.101600><0.547700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.417300,0.000000,23.952200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.377300,0.000000,24.155400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,24.155400>}
box{<0,0,-0.101600><0.587700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.377300,0.000000,24.155400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.337900,0.000000,24.358600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,24.358600>}
box{<0,0,-0.101600><0.627100,0.036000,0.101600> rotate<0,0.000000,0> translate<47.337900,0.000000,24.358600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.326500,0.000000,24.561800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,24.561800>}
box{<0,0,-0.101600><0.638500,0.036000,0.101600> rotate<0,0.000000,0> translate<47.326500,0.000000,24.561800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.315000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,24.765000>}
box{<0,0,-0.101600><0.650000,0.036000,0.101600> rotate<0,0.000000,0> translate<47.315000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.330800,0.000000,24.968200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,24.968200>}
box{<0,0,-0.101600><0.634200,0.036000,0.101600> rotate<0,0.000000,0> translate<47.330800,0.000000,24.968200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.346600,0.000000,25.171400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,25.171400>}
box{<0,0,-0.101600><0.618400,0.036000,0.101600> rotate<0,0.000000,0> translate<47.346600,0.000000,25.171400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.388500,0.000000,25.374600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,25.374600>}
box{<0,0,-0.101600><0.576500,0.036000,0.101600> rotate<0,0.000000,0> translate<47.388500,0.000000,25.374600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.431300,0.000000,25.577800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,25.577800>}
box{<0,0,-0.101600><0.533700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.431300,0.000000,25.577800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.500800,0.000000,25.781000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,25.781000>}
box{<0,0,-0.101600><0.464200,0.036000,0.101600> rotate<0,0.000000,0> translate<47.500800,0.000000,25.781000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.574300,0.000000,25.984200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,25.984200>}
box{<0,0,-0.101600><0.390700,0.036000,0.101600> rotate<0,0.000000,0> translate<47.574300,0.000000,25.984200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.673800,0.000000,26.187400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,26.187400>}
box{<0,0,-0.101600><0.291200,0.036000,0.101600> rotate<0,0.000000,0> translate<47.673800,0.000000,26.187400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.784500,0.000000,26.390600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,26.390600>}
box{<0,0,-0.101600><0.180500,0.036000,0.101600> rotate<0,0.000000,0> translate<47.784500,0.000000,26.390600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.918100,0.000000,26.593800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,26.593800>}
box{<0,0,-0.101600><0.046900,0.036000,0.101600> rotate<0,0.000000,0> translate<47.918100,0.000000,26.593800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,26.665000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,22.865000>}
box{<0,0,-0.101600><3.800000,0.036000,0.101600> rotate<0,-90.000000,0> translate<47.965000,0.000000,22.865000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,22.865000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.732900,0.000000,23.202000>}
box{<0,0,-0.101600><0.409194,0.036000,0.101600> rotate<0,55.440222,0> translate<47.732900,0.000000,23.202000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.732900,0.000000,23.202000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.548900,0.000000,23.567600>}
box{<0,0,-0.101600><0.409291,0.036000,0.101600> rotate<0,63.280521,0> translate<47.548900,0.000000,23.567600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.548900,0.000000,23.567600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.416400,0.000000,23.954800>}
box{<0,0,-0.101600><0.409243,0.036000,0.101600> rotate<0,71.104339,0> translate<47.416400,0.000000,23.954800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.416400,0.000000,23.954800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.338000,0.000000,24.356400>}
box{<0,0,-0.101600><0.409181,0.036000,0.101600> rotate<0,78.948486,0> translate<47.338000,0.000000,24.356400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.338000,0.000000,24.356400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.315000,0.000000,24.765000>}
box{<0,0,-0.101600><0.409247,0.036000,0.101600> rotate<0,86.772507,0> translate<47.315000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.315000,0.000000,24.765000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.346700,0.000000,25.171800>}
box{<0,0,-0.101600><0.408033,0.036000,0.101600> rotate<0,-85.538570,0> translate<47.315000,0.000000,24.765000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.346700,0.000000,25.171800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.429200,0.000000,25.571500>}
box{<0,0,-0.101600><0.408125,0.036000,0.101600> rotate<0,-78.332482,0> translate<47.346700,0.000000,25.171800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.429200,0.000000,25.571500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.561300,0.000000,25.957600>}
box{<0,0,-0.101600><0.408073,0.036000,0.101600> rotate<0,-71.107472,0> translate<47.429200,0.000000,25.571500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.561300,0.000000,25.957600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.740800,0.000000,26.324000>}
box{<0,0,-0.101600><0.408006,0.036000,0.101600> rotate<0,-63.895469,0> translate<47.561300,0.000000,25.957600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.740800,0.000000,26.324000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<47.965000,0.000000,26.665000>}
box{<0,0,-0.101600><0.408101,0.036000,0.101600> rotate<0,-56.672220,0> translate<47.740800,0.000000,26.324000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,27.965000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,27.965000>}
box{<0,0,-0.101600><5.600000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.965000,0.000000,27.965000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,27.965000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,27.165000>}
box{<0,0,-0.101600><1.131371,0.036000,0.101600> rotate<0,44.997030,0> translate<52.565000,0.000000,27.965000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,27.165000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,22.365000>}
box{<0,0,-0.101600><4.800000,0.036000,0.101600> rotate<0,-90.000000,0> translate<53.365000,0.000000,22.365000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<53.365000,0.000000,22.365000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,21.565000>}
box{<0,0,-0.101600><1.131371,0.036000,0.101600> rotate<0,-44.997030,0> translate<52.565000,0.000000,21.565000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<52.565000,0.000000,21.565000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,21.565000>}
box{<0,0,-0.101600><5.600000,0.036000,0.101600> rotate<0,0.000000,0> translate<46.965000,0.000000,21.565000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,21.565000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<46.965000,0.000000,27.965000>}
box{<0,0,-0.101600><6.400000,0.036000,0.101600> rotate<0,90.000000,0> translate<46.965000,0.000000,27.965000> }
difference{
cylinder{<50.165000,0,24.765000><50.165000,0.036000,24.765000>3.051600 translate<0,0.000000,0>}
cylinder{<50.165000,-0.1,24.765000><50.165000,0.135000,24.765000>2.848400 translate<0,0.000000,0>}}
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,25.450800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.738000,0.000000,22.809200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.738000,0.000000,22.809200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.262000,0.000000,25.450800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.262000,0.000000,22.809200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.262000,0.000000,22.809200> }
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<63.500000,0.000000,22.555200>}
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<63.500000,0.000000,25.704800>}
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.023000,0.000000,25.450800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.023000,0.000000,22.809200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.023000,0.000000,22.809200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.547000,0.000000,25.450800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.547000,0.000000,22.809200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.547000,0.000000,22.809200> }
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<57.785000,0.000000,22.555200>}
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<57.785000,0.000000,25.704800>}
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.023000,0.000000,42.595800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<57.023000,0.000000,39.954200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<57.023000,0.000000,39.954200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.547000,0.000000,42.595800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<58.547000,0.000000,39.954200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<58.547000,0.000000,39.954200> }
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<57.785000,0.000000,39.700200>}
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<57.785000,0.000000,42.849800>}
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.373000,0.000000,42.595800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.373000,0.000000,39.954200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<63.373000,0.000000,39.954200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.897000,0.000000,42.595800>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<64.897000,0.000000,39.954200>}
box{<0,0,-0.076200><2.641600,0.036000,0.076200> rotate<0,-90.000000,0> translate<64.897000,0.000000,39.954200> }
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<64.135000,0.000000,39.700200>}
box{<-0.279400,0,-0.838200><0.279400,0.036000,0.838200> rotate<0,-90.000000,0> translate<64.135000,0.000000,42.849800>}
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  HEADAMP(-57.785000,0,-31.432500,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//C1	220p	C3216
//C2	3,3uf	C3216
//C3	220p	C3216
//C4	3,3uf	C3216
