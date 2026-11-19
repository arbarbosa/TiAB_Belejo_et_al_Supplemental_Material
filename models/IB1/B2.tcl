

wipe;

# puts "Model Generation Started"

# #Model Builder------------------------

model basic -ndm 3 -ndf 6
set g 386.4

set Qake_X "X_Eake.g3";
set Qake_Y "Y_Eake.g3";
set Qake_factor "$g*100000";
set npts 100000;
set dt 100000; 

set cover 1.5
set D_Nr3 0.375
set D_Nr11 1.41

set A_Nr3 0.11
set A_Nr11 1.56





set h 24.0
set Lp 36.
set Lsplice 36.
# set Lsplice 180

set c1 [expr $cover+$D_Nr3+$D_Nr11]
set c2 [expr $h-$c1]
set H 144

set Lret 60.

set NdivZ_Lp 1
set NdivZ_ret 1
set dZlp [expr $Lp/$NdivZ_Lp]
set dZret [expr ($Lret-$Lp)/$NdivZ_ret]

set NdivZ_col 4
set NdivZ_colB1 $NdivZ_col
set NdivZ_colB2 $NdivZ_col
set NdivZ_colB3 $NdivZ_col
set NdivZ_colB4 $NdivZ_col


#COLUMN LENGTH

set L_ColB1 [expr 16*12.]; #ABUTMENTS


#COLUMNS FORMAT 123 (L1=7ft; L2=16ft; L3=22ft ----> approximately 16th 50th and 84th percentiles)

set L_ColB2 [expr (10+5)*12.]; #1st column
set L_ColB3 [expr (16+5)*12.]; #middle column
set L_ColB4 [expr (22+5)*12.]; #3rd column


 set dZcolB1 [expr ($L_ColB1-$Lret)/$NdivZ_colB1]
 set dZcolB2 [expr ($L_ColB2-$Lret)/$NdivZ_colB2]
 set dZcolB3 [expr ($L_ColB3-$Lret)/$NdivZ_colB3]
 set dZcolB4 [expr ($L_ColB4-$Lret)/$NdivZ_colB4]
 
# set dYcolumn 0.0
# set dYcolumn $dYsplice
# set NdivY_col [expr ($H-$Lsplice)/$dYcolumn]


# #materials
# unconfined concrete
# MATERIAL parameters -------------------------------------------------------------------
set UNCONFINED 10
set concreteSpl 1; 
set concreteCol 2;			# material ID tag -- unconfined cover concrete
set steel 3; 				# material ID tag -- reinforcement
set concrete2Spl 4;
set concrete2Col 5;
set steel2 6;
set concrete 7
# nominal concrete compressive strength
set fc -3.3; 				# CONCRETE Compressive Strength (+Tension, -Compression)
set Ec [expr 57.*sqrt(-1*$fc*1000.)]; 		# Concrete Elastic Modulus (the term in sqr root needs to be in psi
set G [expr $Ec/2.4]

# unconfined concrete
set fc1U 		$fc;			# UNCONFINED concrete (todeschini parabolic model), maximum stress
set eps1U	-0.003;			# strain at maximum strength of unconfined concrete
set fc2U 		-0.1;		# ultimate stress
set eps2U	-0.02;			# strain at ultimate stress
set lambda 0.1;				# ratio between unloading slope at $eps2 and initial slope $Ec
# tensile-strength properties
set ftU [expr -0.14*$fc1U];			# tensile strength +tension
set Ets [expr $ftU/0.003];			# tension softening stiffness

# confined concrete
set fc1C 		[expr 1.03*$fc];			# UNCONFINED concrete (todeschini parabolic model), maximum stress
set eps1C	-0.0036;			# strain at maximum strength of unconfined concrete
set fc2C 		-3.23;		# ultimate stress
set eps2C	-0.027;			# strain at ultimate stress


# -----------
set Fy 44.;				# STEEL yield stress
set Es 29000.;				# modulus of steel
set Bs 0.01;				# strain-hardening ratio 
set R0 18;				# control the transition from elastic to plastic branches
set cR1 0.925;				# control the transition from elastic to plastic branches
set cR2 0.15;				# control the transition from elastic to plastic branches



set ConcFiberVsplice 10
set ConcFiberVcol 20
set ConcFiberHsplice 30
set ConcFiberHcolumn 40
set ConcFiberDiagonal 50
set SteelFiberH 60
set SteelFiber 70
set SteelFiberHCol 80

set cover 1.5
set D_Nr3 0.375
set D_Nr11 1.41

set A_Nr3 0.11
set A_Nr11 1.56

set g 386.4;
set W 200.



set Fy2 44.;

set ft [expr (0.33*sqrt(-$fc*6.89475728))*0.145]

set pl_splice  [expr 8*$A_Nr11/($h*$h)]
set pl_col  [expr 4*$A_Nr11/($h*$h)]
set pl_hor  [expr 2*$A_Nr3/($h*$h/2)]

set ct 2.953

set M_splice [expr $ct*$pl_splice/$D_Nr11]


set M_col [expr $ct*$pl_col/$D_Nr11]
set M_hor [expr $ct*$pl_hor/$D_Nr3]



# # Concrete for Truss 
# set betaint 0.5
# set betaext 0.1




 #BONDSLIP
# Ratio of maximum deformation at which reloading begins
# Pos_env. Neg_env.
set rDisp [list 0.48 0.48]
# Ratio of envelope force (corresponding to maximum deformation) at which reloading begins
# Pos_env. Neg_env.
set rForce [list 1.0 1.0]
# Ratio of monotonic strength developed upon unloading
# Pos_env. Neg_env.
set uForce [list -0.2 -0.2]
# Coefficients for Unloading Stiffness degradation
# gammaK1 gammaK2 gammaK3 gammaK4 gammaKLimit
# set gammaK [list 1.0 0.2 0.3 0.2 0.9]
set gammaK [list 0.5 0.5 0.5 0.5 0.5]
# Coefficients for Reloading Stiffness degradation
# gammaD1 gammaD2 gammaD3 gammaD4 gammaDLimit
# set gammaD [list 0.5 0.5 2.0 2.0 0.5]
set gammaD [list 0.5 0.5 0.5 0.5 0.5]
# Coefficients for Strength degradation
# gammaF1 gammaF2 gammaF3 gammaF4 gammaFLimit
# set gammaF [list 1.0 0.0 1.0 1.0 0.9]
set gammaF [list 0.0 0.0 0.0 0.0 0.0]
set gammaE 10.
# damage type (option: "energy", "cycle")
set damage "cycle"



#CONCRETE VERTICAL

uniaxialMaterial ConcretewBeta $concreteSpl $fc1U $eps1U  $fc1C $eps1C  $fc2C $eps2C $ftU 0.2 0.1 0.1 0.2 -M $M_splice
uniaxialMaterial ConcretewBeta $concreteCol $fc1U $eps1U  $fc1C $eps1C  $fc2C $eps2C $ftU 0.2 0.1 0.1 0.2 -M $M_col
# uniaxialMaterial ConcretewBeta $UNCONFINED $fc1U $eps1U  $fc1U $eps1U  $fc2U $eps2U $ftU 0.2 0.1 0.1 0.2 -M $M_col

# uniaxialMaterial Concrete02 $concreteSpl $fc1C $eps1C $fc2C $eps2C $lambda $ftU $Ets;	# build cover concrete (unconfined)
# uniaxialMaterial Concrete02 $concreteCol $fc1C $eps1C $fc2C $eps2C $lambda $ftU $Ets;	# build cover concrete (unconfined)
uniaxialMaterial Concrete02 $UNCONFINED $fc1U $eps1U $fc2U $eps2U $lambda $ftU $Ets;	# build cover concrete (unconfined)
# set perim [expr 2*($cover+$D_Nr3+$D_Nr10)]
set ls $Lsplice

# uniaxialMaterial Concrete02 $concrete $fc1U $eps1U $fc2U $eps2U $lambda $ftU $Ets;	# build cover concrete (unconfined)
uniaxialMaterial Steel02 $steel $Fy $Es $Bs $R0 $cR1 $cR2;				# build reinforcement material

set BondSlip1 27

set BSpEnvelopeStress [list [expr 62.8/$A_Nr11] [expr  90.71/$A_Nr11] [expr 57.76/$A_Nr11] [expr 1.17/$A_Nr11]]
set BSnEnvelopeStress [list [expr -62.8/$A_Nr11] [expr -90.71/$A_Nr11] [expr -57.76/$A_Nr11] [expr -1.17/$A_Nr11]]
# Positive/Negative envelope Strain/Deformation
# strain1 strain2 strain3 strain4
set BSpEnvelopeStrain [list [expr 0.038/$ls] [expr 0.08/$ls] [expr 0.08/$ls] [expr 0.401/$ls]]
set BSnEnvelopeStrain [list [expr -0.038/$ls] [expr -0.08/$ls] [expr -0.08/$ls] [expr -0.401/$ls]]
uniaxialMaterial Pinching4 $BondSlip1 [lindex $BSpEnvelopeStress 0] [lindex $BSpEnvelopeStrain 0] [lindex $BSpEnvelopeStress 1] [lindex $BSpEnvelopeStrain 1] [lindex $BSpEnvelopeStress 2] [lindex $BSpEnvelopeStrain 2] [lindex $BSpEnvelopeStress 3] [lindex $BSpEnvelopeStrain 3] [lindex $BSnEnvelopeStress 0] [lindex $BSnEnvelopeStrain 0] [lindex $BSnEnvelopeStress 1] [lindex $BSnEnvelopeStrain 1] [lindex $BSnEnvelopeStress 2] [lindex $BSnEnvelopeStrain 2] [lindex $BSnEnvelopeStress 3] [lindex $BSnEnvelopeStrain 3] [lindex $rDisp 0] [lindex $rForce 0] [lindex $uForce 0] [lindex $rDisp 1] [lindex $rForce 1] [lindex $uForce 1] [lindex $gammaK 0] [lindex $gammaK 1] [lindex $gammaK 2] [lindex $gammaK 3] [lindex $gammaK 4] [lindex $gammaD 0] [lindex $gammaD 1] [lindex $gammaD 2] [lindex $gammaD 3] [lindex $gammaD 4] [lindex $gammaF 0] [lindex $gammaF 1] [lindex $gammaF 2] [lindex $gammaF 3] [lindex $gammaF 4] $gammaE $damage


set J_Col 46725.12


set A_SteelFiber [expr $A_Nr11]


    
# #elements

set ColTransf 1
set BeamTransf 2
 geomTransf PDelta $ColTransf 1 0 0 
 geomTransf Linear $BeamTransf 0 0 1

#ele


# set Mass [expr $W/$g]

 set coverLong1 [expr $cover+$D_Nr3+$D_Nr11/2]
 set coverLong2 [expr $cover+$D_Nr3+$D_Nr11/2+$D_Nr11]


set nIP 5

#SECTIONS


set Beam_cover 1.5
set Col_cover 1.5
set Deckup_cover 1.5
set Deckbot_cover 1.0
set Flange_cover 2.0

set th_deck 6.
set deck_b 378.

set D_Nr3 0.375
set D_Nr4 0.5
set D_Nr5 0.625
set D_Nr6 0.750
set D_Nr8 1.0
set D_Nr9 1.128
set D_Nr10 1.27
set D_Nr11 1.41

set A_Nr3 0.11
set A_Nr4 0.2
set A_Nr5 0.31
set A_Nr6 0.44
set A_Nr8 0.79
set A_Nr9 1.0
set A_Nr10 1.27
set A_Nr11 1.56


set nfib_deck_b 40
set nfib_deck_h 2
set nfib_beam_h 20
set nfib_beam_b 5
set nfib_flange_b 20
set nfib_flange_h 2
set nfib_col 8


#Deck beams
set sB 108.
set bB 13.
set hB 48.
set sbarB 3.5
set cgB 33.226
#Transversal beams
set sE 150.
set bE 9.
set hE 46.
set cgE 36.429
#Cap Beams
set sH 150.
set bH 16.5
set hH 75.
set cgH 51.056
set sbarH 3.5
set J_BeamH 107707.74

set A_BeamH [expr $bH*$hH]

set hCol 24.


#Z|
# |___Y

set Deck 15
set BeamE 16
set BeamH 17
set Column 18


set J_Deck 145608.22; #SAP2000
set J_BeamH 107707.74
set J_BeamE 20056.882
set J_Col 46725.12





#ABUTMENTS

set Abut_long 12
set Abut_long_edge 13
set Abut_tran 14

set Kmax_Longmid 1087.9 ; #kip/in
set Kmax_Longedge 1056.9 ; #kip/in
set Kmax_Trans 300.3 ; #kip/in

set Kur_Longmid $Kmax_Longmid
set Kur_Longedge $Kmax_Longedge
set Kur_Trans $Kmax_Trans


set Rf 0.7


set Tran_Pult -10.91; #kip
set Long_Pult -98.22; #kip
set Long_Pult_edge -93.85; #kip 


set Long_gap -1.0; #in
set Tran_gap -0.0000001; #in

uniaxialMaterial HyperbolicGapMaterial $Abut_long 		$Kmax_Longmid $Kur_Longmid $Rf $Long_Pult $Long_gap
uniaxialMaterial HyperbolicGapMaterial $Abut_long_edge  $Kmax_Longedge $Kur_Longedge $Rf $Long_Pult_edge $Long_gap
uniaxialMaterial HyperbolicGapMaterial $Abut_tran 		$Kmax_Trans $Kur_Trans $Rf $Tran_Pult $Tran_gap

set LoadBar 11
set SecElastic 6
set BS 8
set SecRigid 12
 
set ConcSplice 9
set RCColumn 10
set RCColumnRet 14

set GJ [expr $Ec/2.4*$J_Col]



 section Fiber $ConcSplice -GJ [expr 0.1*$GJ] {
 patch rect $concreteSpl 8 8 [expr -$h/2+$cover+$D_Nr3/2] [expr -$h/2+$cover+$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2]
 patch rect $UNCONFINED 2 12 [expr -$h/2] [expr -$h/2] [expr -$h/2+$cover+$D_Nr3/2] [expr $h/2]
 patch rect $UNCONFINED 2 12 [expr $h/2-$cover-$D_Nr3/2] [expr -$h/2] [expr $h/2] [expr $h/2]
 patch rect $UNCONFINED 8 2 [expr -$h/2+$cover+$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2] [expr $h/2]
 patch rect $UNCONFINED 8 2 [expr -$h/2+$cover+$D_Nr3/2] [expr -$h/2] [expr $h/2-$cover-$D_Nr3/2] [expr -$h/2+$cover+$D_Nr3/2]
 layer straight $BondSlip1 2 1. [expr -$h/2+$c1] [expr -$h/2+$c1] [expr -$h/2+$c1] [expr $h/2-$c1]
 layer straight $BondSlip1 2 1. [expr $h/2-$c1] [expr -$h/2+$c1] [expr $h/2-$c1] [expr $h/2-$c1]
 }
 
 
 section Fiber $RCColumnRet -GJ [expr 0.1*$GJ] {
 patch rect $concreteCol 8 8 [expr -$h/2+$cover+$D_Nr3/2] [expr -$h/2+$cover+$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2]
 patch rect $UNCONFINED 2 12 [expr -$h/2] [expr -$h/2] [expr -$h/2+$cover+$D_Nr3/2] [expr $h/2]
 patch rect $UNCONFINED 2 12 [expr $h/2-$cover-$D_Nr3/2] [expr -$h/2] [expr $h/2] [expr $h/2]
 patch rect $UNCONFINED 8 2 [expr -$h/2+$cover+$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2] [expr $h/2]
 patch rect $UNCONFINED 8 2 [expr -$h/2+$cover+$D_Nr3/2] [expr -$h/2] [expr $h/2-$cover-$D_Nr3/2] [expr -$h/2+$cover+$D_Nr3/2]
 layer straight $steel 2 $A_Nr11 [expr -$h/2+$c1] [expr -$h/2+$c1] [expr -$h/2+$c1] [expr $h/2-$c1]
 layer straight $steel 2 $A_Nr11 [expr $h/2-$c1] [expr -$h/2+$c1] [expr $h/2-$c1] [expr $h/2-$c1]
 }
 
 
 section Fiber $RCColumn -GJ [expr 0.1*$GJ] {
 patch rect $concreteCol 8 8 [expr -$h/2+$cover+$D_Nr3/2] [expr -$h/2+$cover+$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2]
 patch rect $UNCONFINED 2 12 [expr -$h/2] [expr -$h/2] [expr -$h/2+$cover+$D_Nr3/2] [expr $h/2]
 patch rect $UNCONFINED 2 12 [expr $h/2-$cover-$D_Nr3/2] [expr -$h/2] [expr $h/2] [expr $h/2]
 patch rect $UNCONFINED 8 2 [expr -$h/2+$cover+$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2] [expr $h/2-$cover-$D_Nr3/2] [expr $h/2]
 patch rect $UNCONFINED 8 2 [expr -$h/2+$cover+$D_Nr3/2] [expr -$h/2] [expr $h/2-$cover-$D_Nr3/2] [expr -$h/2+$cover+$D_Nr3/2]
 layer straight $steel 2 $A_Nr11 [expr -$h/2+$c1] [expr -$h/2+$c1] [expr -$h/2+$c1] [expr $h/2-$c1]
 layer straight $steel 2 $A_Nr11 [expr $h/2+$c1] [expr -$h/2+$c1] [expr $h/2+$c1] [expr $h/2-$c1]
 }

   
  # section Fiber $BS {
# fiber 0. 0. 1.0 $BondSlip1
# }



#SPRINGS IN EACH FOOTING


set k1_1 0.013;
set k2_1 0.701;
set qstc_1 0.04538297;
set Pult_1 22.63;

set Bequiv_1 67.72 


set k1_2 0.013;
set k2_2 0.701;
set qstc_2 0.045459;
set Pult_2 31.69;

set Bequiv_2 94.81 

#Vertical Spring Parameters
set Nsprings 1; #odd number	

set gap 0.0
#Horizontal spring Parameters
set Kmax_1 630.1; #(kip/in)
set Kur_1 $Kmax_1
set Kmax_2 865.7; #(kip/in)
set Kur_2 $Kmax_2

set Rf 0.85
set gap_h -0.00000001

set B_foot_1 60.; #Footing width (in)
set L_foot_1  $B_foot_1; #Footing length - assuming a square footing
set B_foot_2 84.; #Footing width (in)
set L_foot_2  $B_foot_2; #Footing length - assuming a square footing


set H_1 18.; #Footing height/depth (in)
set Df_1 $H_1; #Embedment depth (in)

set H_2 24.; #Footing height/depth (in)
set Df_2 $H_2; #Embedment depth (in)

set dB_1 [expr $B_foot_1]
set dB_2 [expr $B_foot_2]


#"Vertical" SPRINGS ON THE EDGES
set SpringH_1 51
set SpringV_1 52
set SpringM_1 53
set SpringH_2 54
set SpringV_2 55
set SpringM_2 56 

set Ainf_1 [expr $dB_1*$L_foot_1]
set Ainf_2 [expr $dB_2*$L_foot_2]

#FOUNDATION #1

#Soil Resistance/Bearing Pressure-Displacement Response
#k1 and k2 are the normalized bearing presure-displacement parameters, k1=0.013 k2=0.701 (to be replaced by random)
#qstc is the slope tangent capacity, estimated as Mstc*qult.  Mstc=0.643 (to be replaced by random)
#qult for this assumes su=70kPa, gamma=19.7kN/m^3

set Qstc_1 [expr -$qstc_1*$Ainf_1]; #slope tangent load (kN) over area of influence of each vertical spring
set kur_1 [expr 1./$k1_1];

set Qstc_2 [expr -$qstc_2*$Ainf_2]; #slope tangent load (kN) over area of influence of each vertical spring
set kur_2 [expr 1./$k1_2];



# uniaxialMaterial HyperbolicQyMaterial $SpringM_1 $Bequiv_1 $k1_1 $kur_1 $k2_1 [expr $B_foot_1*$Qstc_1*0.22] $gap
# uniaxialMaterial HyperbolicQyMaterial $SpringV_1 $Bequiv_1 $k1_1 $kur_1 $k2_1 [expr $Qstc_1] $gap
# uniaxialMaterial HyperbolicGapMaterial $SpringH_1 $Kmax_1 $Kur_1 $Rf [expr -1*$Pult_1] $gap_h

# uniaxialMaterial HyperbolicQyMaterial $SpringM_2 $Bequiv_2 $k1_2 $kur_2 $k2_2 [expr $B_foot_2*$Qstc_2*0.22] $gap
# uniaxialMaterial HyperbolicQyMaterial $SpringV_2 $Bequiv_2 $k1_2 $kur_2 $k2_2 [expr $Qstc_2] $gap
# uniaxialMaterial HyperbolicGapMaterial $SpringH_2 $Kmax_2 $Kur_2 $Rf [expr -1*$Pult_2] $gap_h



#GEOMETRY


set span [expr 50.*12.]
set sCol_B1 [expr 9.*12.]
set sCol_B2 [expr 26.5*12.]
set sCol_B3 [expr 26.5*12.]
set sCol_B4 [expr 26.5*12.]

set z0_ColB1 [expr $L_ColB4-$L_ColB1]
set z0_ColB2 [expr $L_ColB4-$L_ColB2]
set z0_ColB3 [expr $L_ColB4-$L_ColB3]
set z0_ColB4 0.0



set C1 10000
set C2 20000
set C3 30000
set C4 40000
set C5 50000
set C6 60000
set C7 70000
set C8 80000
set C9 90000
set C10 100000
set C11 110000
set C12 120000
set C13 130000
set C14 140000
set C20 200000




set X1 [expr -1.5*$sCol_B1] 
set X2 [expr -0.5*$sCol_B1] 
set X3 [expr 0.5*$sCol_B1] 
set X4 [expr 1.5*$sCol_B1] 

set X5 [expr -1.5*$sCol_B1] 
set X6 [expr 1.5*$sCol_B1] 

set X7 [expr -1.5*$sCol_B1] 
set X8 [expr 1.5*$sCol_B1] 

set X9  [expr -1.5*$sCol_B1]
set X10 [expr 1.5*$sCol_B1]

set X11 [expr -1.5*$sCol_B1] 
set X12 [expr -0.5*$sCol_B1] 
set X13 [expr 0.5*$sCol_B1] 
set X14 [expr 1.5*$sCol_B1] 

set X20 [expr 0.0]


set Y1 [expr -2*$span]
set Y2 [expr -2*$span]
set Y3 [expr -2*$span]
set Y4 [expr -2*$span]

set Y5 [expr -$span]
set Y6 [expr -$span]

set Y7 0.0
set Y8 0.0

set Y9 [expr $span]
set Y10 [expr $span]

set Y11 [expr 2*$span]
set Y12 [expr 2*$span]
set Y13 [expr 2*$span]
set Y14 [expr 2*$span]

set Y20 0.0

set Z1  $z0_ColB1  
set Z2  $z0_ColB1  
set Z3  $z0_ColB1  
set Z4  $z0_ColB1 
 
set Z5  $z0_ColB2  
set Z6  $z0_ColB2  

set Z7  $z0_ColB3  
set Z8  $z0_ColB3 
 
set Z9  $z0_ColB4  
set Z10 $z0_ColB4 
 
set Z11 $z0_ColB1  
set Z12 $z0_ColB1  
set Z13 $z0_ColB1  
set Z14 $z0_ColB1 

# set Erig [expr $Ec*100]
# set Arig 1200.
# set IZrig 1000000.
# set IYrig 1000000.
# set Jrig 1000.
# set Grig [expr $Erig/2.4]


# #elements


set nIP 5

#NODES

#Column C1
#Column C1
# for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
# if {$z == 0} {

# node [expr $C1+$z*100] [expr $X1+0.0] [expr $Y1+0.0] [expr $Z1+$z*$dZlp]
# fix [expr $C1+$z*100] 1 1 1 1 1 1


# } else {

# node [expr $C1+$z*100] [expr $X1+0.0] [expr $Y1+0.0] [expr $Z1+$z*$dZlp]
# element dispBeamColumn [expr $C1+$z*100] [expr $C1+($z-1)*100]	[expr $C1+$z*100] $nIP $ConcSplice $ColTransf
# }
# } 

# for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
# node [expr $C1+$z*100] [expr $X1+0.0] [expr $Y1+0.0] [expr $Z1+($z-$NdivZ_Lp)*$dZret+$Lp]
# element dispBeamColumn [expr $C1+$z*100] [expr $C1+($z-1)*100]	[expr $C1+$z*100] $nIP $RCColumnRet $ColTransf 
# }

# for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
 node [expr $C1+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] [expr $X1+0.0] [expr $Y1+0.0] [expr $Z1+$NdivZ_col*$dZcolB1+$Lret]
fix [expr $C1+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] 0 0 1 1 1 1
# element dispBeamColumn [expr $C1+$z*100] [expr $C1+($z-1)*100]	[expr $C1+$z*100] $nIP $RCColumn $ColTransf 
# }


# #Column C2

# for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
# if {$z == 0} {

# node [expr $C2+$z*100] [expr $X2+0.0] [expr $Y2+0.0] [expr $Z2+$z*$dZlp]
# fix [expr $C2+$z*100] 1 1 1 1 1 1


# } else {

# node [expr $C2+$z*100] [expr $X2+0.0] [expr $Y2+0.0] [expr $Z2+$z*$dZlp]
# element dispBeamColumn [expr $C2+$z*100] [expr $C2+($z-1)*100]	[expr $C2+$z*100] $nIP $ConcSplice $ColTransf
# # element truss [expr $C2+$z*100+70] [expr $C2+($z-1)*100]	[expr $C2+$z*100] $Shell


# }
# } 
# #Vertical Concrete elements COLUMN
# for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
# node [expr $C2+$z*100] [expr $X2+0.0] [expr $Y2+0.0] [expr $Z2+($z-$NdivZ_Lp)*$dZret+$Lp]
# element dispBeamColumn [expr $C2+$z*100] [expr $C2+($z-1)*100]	[expr $C2+$z*100] $nIP $RCColumnRet $ColTransf 
# # element truss [expr $C2+$z*100+70] [expr $C2+($z-1)*100]	[expr $C2+$z*100] $Shell

# }


# for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
 node [expr $C2+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] [expr $X2+0.0] [expr $Y2+0.0] [expr $Z2+$NdivZ_col*$dZcolB1+$Lret]
 fix [expr $C2+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] 0 0 1 1 1 1
# element dispBeamColumn [expr $C2+$z*100] [expr $C2+($z-1)*100]	[expr $C2+$z*100] $nIP $RCColumn $ColTransf 
# }

# #column C3
# #Column C3
# for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
# if {$z == 0} {

# node [expr $C3+$z*100] [expr $X3+0.0] [expr $Y3+0.0] [expr $Z3+$z*$dZlp]
# fix [expr $C3+$z*100] 1 1 1 1 1 1


# } else {

# node [expr $C3+$z*100] [expr $X3+0.0] [expr $Y3+0.0] [expr $Z3+$z*$dZlp]
# element dispBeamColumn [expr $C3+$z*100] [expr $C3+($z-1)*100]	[expr $C3+$z*100] $nIP $ConcSplice $ColTransf
# # element truss [expr $C3+$z*100+70] [expr $C3+($z-1)*100]	[expr $C3+$z*100] $Shell
# }
# } 
# #Vertical Concrete elements COLUMN
# for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
# node [expr $C3+$z*100] [expr $X3+0.0] [expr $Y3+0.0] [expr $Z3+($z-$NdivZ_Lp)*$dZret+$Lp]
# element dispBeamColumn [expr $C3+$z*100] [expr $C3+($z-1)*100]	[expr $C3+$z*100] $nIP $RCColumnRet $ColTransf 
# # element truss [expr $C3+$z*100+70] [expr $C3+($z-1)*100]	[expr $C3+$z*100] $Shell


# }

# for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
 node [expr $C3+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] [expr $X3+0.0] [expr $Y3+0.0] [expr $Z3+$NdivZ_col*$dZcolB1+$Lret]
 fix [expr $C3+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] 0 0 1 1 1 1
# element dispBeamColumn [expr $C3+$z*100] [expr $C3+($z-1)*100]	[expr $C3+$z*100] $nIP $RCColumn $ColTransf 
# }
# #column C4
# #Column C4
# for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
# if {$z == 0} {

# node [expr $C4+$z*100] [expr $X4+0.0] [expr $Y4+0.0] [expr $Z4+$z*$dZlp]


# fix [expr $C4+$z*100] 1 1 1 1 1 1


# } else {

# node [expr $C4+$z*100] [expr $X4+0.0] [expr $Y4+0.0] [expr $Z4+$z*$dZlp]
# element dispBeamColumn [expr $C4+$z*100] [expr $C4+($z-1)*100]	[expr $C4+$z*100] $nIP $ConcSplice $ColTransf
# # element truss [expr $C4+$z*100+70] [expr $C4+($z-1)*100]	[expr $C4+$z*100] $Shell


# }
# } 
# #Vertical Concrete elements COLUMN
# for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
# node [expr $C4+$z*100] [expr $X4+0.0] [expr $Y4+0.0] [expr $Z4+($z-$NdivZ_Lp)*$dZret+$Lp]
# element dispBeamColumn [expr $C4+$z*100] [expr $C4+($z-1)*100]	[expr $C4+$z*100] $nIP $RCColumnRet $ColTransf 
# # element truss [expr $C4+$z*100+70] [expr $C4+($z-1)*100]	[expr $C4+$z*100] $Shell


# }


# for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
 node [expr $C4+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] [expr $X4+0.0] [expr $Y4+0.0] [expr $Z4+$NdivZ_col*$dZcolB1+$Lret]
 fix [expr $C4+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] 0 0 1 1 1 1
# element dispBeamColumn [expr $C4+$z*100] [expr $C4+($z-1)*100]	[expr $C4+$z*100] $nIP $RCColumn $ColTransf 
# }

#column C5
#Column C5
for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
if {$z == 0} {
node [expr $C5+$z*100] [expr $X5+0.0] [expr $Y5+0.0] [expr $Z5+$z*$dZlp]

fix [expr $C5+$z*100] 1 1 1 1 1 1


} else {

node [expr $C5+$z*100] [expr $X5+0.0] [expr $Y5+0.0] [expr $Z5+$z*$dZlp]
element dispBeamColumn [expr $C5+$z*100] [expr $C5+($z-1)*100]	[expr $C5+$z*100] $nIP $ConcSplice $ColTransf
# element truss [expr $C5+$z*100+70] [expr $C5+($z-1)*100]	[expr $C5+$z*100] $Shell

}
} 
#Vertical Concrete elements COLUMN
for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
node [expr $C5+$z*100] [expr $X5+0.0] [expr $Y5+0.0] [expr $Z5+($z-$NdivZ_Lp)*$dZret+$Lp]
element dispBeamColumn [expr $C5+$z*100] [expr $C5+($z-1)*100]	[expr $C5+$z*100] $nIP $RCColumnRet $ColTransf 
# element truss [expr $C5+$z*100+70] [expr $C5+($z-1)*100]	[expr $C5+$z*100] $Shell

}


for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
node [expr $C5+$z*100] [expr $X5+0.0] [expr $Y5+0.0] [expr $Z5+($z-$NdivZ_Lp-$NdivZ_ret)*$dZcolB2+$Lret]
element dispBeamColumn [expr $C5+$z*100] [expr $C5+($z-1)*100]	[expr $C5+$z*100] $nIP $RCColumn $ColTransf 
}
#column C6
#Column C6
for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
if {$z == 0} {

node [expr $C6+$z*100] [expr $X6+0.0] [expr $Y6+0.0] [expr $Z6+$z*$dZlp]

fix [expr $C6+$z*100] 1 1 1 1 1 1


} else {

node [expr $C6+$z*100] [expr $X6+0.0] [expr $Y6+0.0] [expr $Z6+$z*$dZlp]
element dispBeamColumn [expr $C6+$z*100] [expr $C6+($z-1)*100]	[expr $C6+$z*100] $nIP $ConcSplice $ColTransf
# element truss [expr $C6+$z*100+70] [expr $C6+($z-1)*100]	[expr $C6+$z*100] $Shell

}
} 
#Vertical Concrete elements COLUMN
for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
node [expr $C6+$z*100] [expr $X6+0.0] [expr $Y6+0.0] [expr $Z6+($z-$NdivZ_Lp)*$dZret+$Lp]
element dispBeamColumn [expr $C6+$z*100] [expr $C6+($z-1)*100]	[expr $C6+$z*100] $nIP $RCColumnRet $ColTransf 
# element truss [expr $C6+$z*100+70] [expr $C6+($z-1)*100]	[expr $C6+$z*100] $Shell

}


for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
node [expr $C6+$z*100] [expr $X6+0.0] [expr $Y6+0.0] [expr $Z6+($z-$NdivZ_Lp-$NdivZ_ret)*$dZcolB2+$Lret]
element dispBeamColumn [expr $C6+$z*100] [expr $C6+($z-1)*100]	[expr $C6+$z*100] $nIP $RCColumn $ColTransf 
}


#column C7
#Column C7
for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
if {$z == 0} {

node [expr $C7+$z*100] [expr $X7+0.0] [expr $Y7+0.0] [expr $Z7+$z*$dZlp]


fix [expr $C7+$z*100] 1 1 1 1 1 1


} else {

node [expr $C7+$z*100] [expr $X7+0.0] [expr $Y7+0.0] [expr $Z7+$z*$dZlp]
element dispBeamColumn [expr $C7+$z*100] [expr $C7+($z-1)*100]	[expr $C7+$z*100] $nIP $ConcSplice $ColTransf
# element truss [expr $C7+$z*100+70] [expr $C7+($z-1)*100]	[expr $C7+$z*100] $Shell


}
} 
#Vertical Concrete elements COLUMN
for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
node [expr $C7+$z*100] [expr $X7+0.0] [expr $Y7+0.0] [expr $Z7+($z-$NdivZ_Lp)*$dZret+$Lp]
element dispBeamColumn [expr $C7+$z*100] [expr $C7+($z-1)*100]	[expr $C7+$z*100] $nIP $RCColumnRet $ColTransf 
# element truss [expr $C7+$z*100+70] [expr $C7+($z-1)*100]	[expr $C7+$z*100] $Shell

}


for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
node [expr $C7+$z*100] [expr $X7+0.0] [expr $Y7+0.0] [expr $Z7+($z-$NdivZ_Lp-$NdivZ_ret)*$dZcolB3+$Lret]
element dispBeamColumn [expr $C7+$z*100] [expr $C7+($z-1)*100]	[expr $C7+$z*100] $nIP $RCColumn $ColTransf 
}

#Column C8
for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
if {$z == 0} {

node [expr $C8+$z*100] [expr $X8+0.0] [expr $Y8+0.0] [expr $Z8+$z*$dZlp]

fix [expr $C8+$z*100] 1 1 1 1 1 1


} else {

node [expr $C8+$z*100] [expr $X8+0.0] [expr $Y8+0.0] [expr $Z8+$z*$dZlp]
element dispBeamColumn [expr $C8+$z*100] [expr $C8+($z-1)*100]	[expr $C8+$z*100] $nIP $ConcSplice $ColTransf
# element truss [expr $C8+$z*100+70] [expr $C8+($z-1)*100]	[expr $C8+$z*100] $Shell

}
} 
#Vertical Concrete elements COLUMN
for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
node [expr $C8+$z*100] [expr $X8+0.0] [expr $Y8+0.0] [expr $Z8+($z-$NdivZ_Lp)*$dZret+$Lp]
element dispBeamColumn [expr $C8+$z*100] [expr $C8+($z-1)*100]	[expr $C8+$z*100] $nIP $RCColumnRet $ColTransf 
# element truss [expr $C8+$z*100+70] [expr $C8+($z-1)*100]	[expr $C8+$z*100] $Shell

}


for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
node [expr $C8+$z*100] [expr $X8+0.0] [expr $Y8+0.0] [expr $Z8+($z-$NdivZ_Lp-$NdivZ_ret)*$dZcolB3+$Lret]
element dispBeamColumn [expr $C8+$z*100] [expr $C8+($z-1)*100]	[expr $C8+$z*100] $nIP $RCColumn $ColTransf 
}

# #column C9
# # #Column C9
for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
if {$z == 0} {

node [expr $C9+$z*100] [expr $X9+0.0] [expr $Y9+0.0] [expr $Z9+$z*$dZlp]

fix [expr $C9+$z*100] 1 1 1 1 1 1


} else {

node [expr $C9+$z*100] [expr $X9+0.0] [expr $Y9+0.0] [expr $Z9+$z*$dZlp]
element dispBeamColumn [expr $C9+$z*100] [expr $C9+($z-1)*100]	[expr $C9+$z*100] $nIP $ConcSplice $ColTransf
# element truss [expr $C9+$z*100+70] [expr $C9+($z-1)*100]	[expr $C9+$z*100] $Shell

}
} 
#Vertical Concrete elements COLUMN
for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
node [expr $C9+$z*100] [expr $X9+0.0] [expr $Y9+0.0] [expr $Z9+($z-$NdivZ_Lp)*$dZret+$Lp]
element dispBeamColumn [expr $C9+$z*100] [expr $C9+($z-1)*100]	[expr $C9+$z*100] $nIP $RCColumnRet $ColTransf 
# element truss [expr $C9+$z*100+70] [expr $C9+($z-1)*100]	[expr $C9+$z*100] $Shell
}


for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
node [expr $C9+$z*100] [expr $X9+0.0] [expr $Y9+0.0] [expr $Z9+($z-$NdivZ_Lp-$NdivZ_ret)*$dZcolB4+$Lret]
element dispBeamColumn [expr $C9+$z*100] [expr $C9+($z-1)*100]	[expr $C9+$z*100] $nIP $RCColumn $ColTransf 
}

# column C10
#Column C10
for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
if {$z == 0} {

node [expr $C10+$z*100] [expr $X10+0.0] [expr $Y10+0.0] [expr $Z10+$z*$dZlp]

fix [expr $C10+$z*100] 1 1 1 1 1 1


} else {

node [expr $C10+$z*100] [expr $X10+0.0] [expr $Y10+0.0] [expr $Z10+$z*$dZlp]
element dispBeamColumn [expr $C10+$z*100] [expr $C10+($z-1)*100]	[expr $C10+$z*100] $nIP $ConcSplice $ColTransf
# element truss [expr $C10+$z*100+70] [expr $C10+($z-1)*100]	[expr $C10+$z*100] $Shell

}
} 
#Vertical Concrete elements COLUMN
for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
node [expr $C10+$z*100] [expr $X10+0.0] [expr $Y10+0.0] [expr $Z10+($z-$NdivZ_Lp)*$dZret+$Lp]
element dispBeamColumn [expr $C10+$z*100] [expr $C10+($z-1)*100]	[expr $C10+$z*100] $nIP $RCColumnRet $ColTransf 
# element truss [expr $C10+$z*100+70] [expr $C10+($z-1)*100]	[expr $C10+$z*100] $Shell

}


for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
node [expr $C10+$z*100] [expr $X10+0.0] [expr $Y10+0.0] [expr $Z10+($z-$NdivZ_Lp-$NdivZ_ret)*$dZcolB4+$Lret]
element dispBeamColumn [expr $C10+$z*100] [expr $C10+($z-1)*100]	[expr $C10+$z*100] $nIP $RCColumn $ColTransf 
}


#column C11
# #Column C11
# for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
# if {$z == 0} {

# node [expr $C11+$z*100] [expr $X11+0.0] [expr $Y11+0.0] [expr $Z11+$z*$dZlp]

# fix [expr $C11+$z*100] 1 1 1 1 1 1


# } else {

# node [expr $C11+$z*100] [expr $X11+0.0] [expr $Y11+0.0] [expr $Z11+$z*$dZlp]
# element dispBeamColumn [expr $C11+$z*100] [expr $C11+($z-1)*100]	[expr $C11+$z*100] $nIP $ConcSplice $ColTransf
# # element truss [expr $C11+$z*100+70] [expr $C11+($z-1)*100]	[expr $C11+$z*100] $Shell

# }
# } 
# #Vertical Concrete elements COLUMN
# for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
# node [expr $C11+$z*100] [expr $X11+0.0] [expr $Y11+0.0] [expr $Z11+($z-$NdivZ_Lp)*$dZret+$Lp]
# element dispBeamColumn [expr $C11+$z*100] [expr $C11+($z-1)*100]	[expr $C11+$z*100] $nIP $RCColumnRet $ColTransf 
# # element truss [expr $C11+$z*100+70] [expr $C11+($z-1)*100]	[expr $C11+$z*100] $Shell
# }


# for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
 node [expr $C11+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] [expr $X11+0.0] [expr $Y11+0.0] [expr $Z11+$NdivZ_col*$dZcolB1+$Lret]
 fix [expr $C11+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] 0 0 1 1 1 1
# element dispBeamColumn [expr $C11+$z*100] [expr $C11+($z-1)*100]	[expr $C11+$z*100] $nIP $RCColumn $ColTransf 
# }


#column C12
#Column C12
# for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
# if {$z == 0} {

# node [expr $C12+$z*100] [expr $X12+0.0] [expr $Y12+0.0] [expr $Z12+$z*$dZlp]

# fix [expr $C12+$z*100] 1 1 1 1 1 1


# } else {

# node [expr $C12+$z*100] [expr $X12+0.0] [expr $Y12+0.0] [expr $Z12+$z*$dZlp]
# element dispBeamColumn [expr $C12+$z*100] [expr $C12+($z-1)*100]	[expr $C12+$z*100] $nIP $ConcSplice $ColTransf
# # element truss [expr $C12+$z*100+70] [expr $C12+($z-1)*100]	[expr $C12+$z*100] $Shell

# }
# } 
# #Vertical Concrete elements COLUMN
# for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
# node [expr $C12+$z*100] [expr $X12+0.0] [expr $Y12+0.0] [expr $Z12+($z-$NdivZ_Lp)*$dZret+$Lp]
# element dispBeamColumn [expr $C12+$z*100] [expr $C12+($z-1)*100]	[expr $C12+$z*100] $nIP $RCColumnRet $ColTransf 
# # element truss [expr $C12+$z*100+70] [expr $C12+($z-1)*100]	[expr $C12+$z*100] $Shell

# }


# for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
 node [expr $C12+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] [expr $X12+0.0] [expr $Y12+0.0] [expr $Z12+$NdivZ_col*$dZcolB1+$Lret]
 fix [expr $C12+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] 0 0 1 1 1 1
# element dispBeamColumn [expr $C12+$z*100] [expr $C12+($z-1)*100]	[expr $C12+$z*100] $nIP $RCColumn $ColTransf 
# }



#column C13

# for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
# if {$z == 0} {

# node [expr $C13+$z*100] [expr $X13+0.0] [expr $Y13+0.0] [expr $Z13+$z*$dZlp]

# fix [expr $C13+$z*100] 1 1 1 1 1 1


# } else {

# node [expr $C13+$z*100] [expr $X13+0.0] [expr $Y13+0.0] [expr $Z13+$z*$dZlp]
# element dispBeamColumn [expr $C13+$z*100] [expr $C13+($z-1)*100]	[expr $C13+$z*100] $nIP $ConcSplice $ColTransf
# # element truss [expr $C13+$z*100+70] [expr $C13+($z-1)*100]	[expr $C13+$z*100] $Shell

# }
# } 
# #Vertical Concrete elements COLUMN
# for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
# node [expr $C13+$z*100] [expr $X13+0.0] [expr $Y13+0.0] [expr $Z13+($z-$NdivZ_Lp)*$dZret+$Lp]
# element dispBeamColumn [expr $C13+$z*100] [expr $C13+($z-1)*100]	[expr $C13+$z*100] $nIP $RCColumnRet $ColTransf 
# # element truss [expr $C13+$z*100+70] [expr $C13+($z-1)*100]	[expr $C13+$z*100] $Shell

# }


# for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
node [expr $C13+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] [expr $X13+0.0] [expr $Y13+0.0] [expr $Z13+$NdivZ_col*$dZcolB1+$Lret]
 fix [expr $C13+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] 0 0 1 1 1 1
# element dispBeamColumn [expr $C13+$z*100] [expr $C13+($z-1)*100]	[expr $C13+$z*100] $nIP $RCColumn $ColTransf 
# }

#column C14
#Column C14
# for {set z 0} {$z <= [expr $NdivZ_Lp]} {incr z 1} {
# if {$z == 0} {

# node [expr $C14+$z*100] [expr $X14+0.0] [expr $Y14+0.0] [expr $Z14+$z*$dZlp]

# fix [expr $C14+$z*100] 1 1 1 1 1 1


# } else {

# node [expr $C14+$z*100] [expr $X14+0.0] [expr $Y14+0.0] [expr $Z14+$z*$dZlp]
# element dispBeamColumn [expr $C14+$z*100] [expr $C14+($z-1)*100]	[expr $C14+$z*100] $nIP $ConcSplice $ColTransf
# # element truss [expr $C14+$z*100+70] [expr $C14+($z-1)*100]	[expr $C14+$z*100] $Shell

# }
# } 
# #Vertical Concrete elements COLUMN
# for {set z [expr $NdivZ_Lp+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret]} {incr z 1} {
# node [expr $C14+$z*100] [expr $X14+0.0] [expr $Y14+0.0] [expr $Z14+($z-$NdivZ_Lp)*$dZret+$Lp]
# element dispBeamColumn [expr $C14+$z*100] [expr $C14+($z-1)*100]	[expr $C14+$z*100] $nIP $RCColumnRet $ColTransf 
# # element truss [expr $C14+$z*100+70] [expr $C14+($z-1)*100]	[expr $C14+$z*100] $Shell

# }


# for {set z [expr $NdivZ_Lp+$NdivZ_ret+1]} {$z <= [expr $NdivZ_Lp+$NdivZ_ret+$NdivZ_col]} {incr z 1} {
node [expr $C14+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] [expr $X14+0.0] [expr $Y14+0.0] [expr $Z14+$NdivZ_col*$dZcolB1+$Lret]
 fix [expr $C14+($NdivZ_Lp+$NdivZ_ret+$NdivZ_col)*100] 0 0 1 1 1 1
# element dispBeamColumn [expr $C14+$z*100] [expr $C14+($z-1)*100]	[expr $C14+$z*100] $nIP $RCColumn $ColTransf 
# }


node [expr $C1+10] 0.0 [expr $Y1] [expr $Z1+$NdivZ_Lp*$dZlp+$NdivZ_ret*$dZret+$NdivZ_colB1*$dZcolB1] 
node [expr $C5+10] 0.0 [expr $Y5] [expr $Z5+$NdivZ_Lp*$dZlp+$NdivZ_ret*$dZret+$NdivZ_colB2*$dZcolB2] 
node [expr $C7+10] 0.0 [expr $Y7] [expr $Z7+$NdivZ_Lp*$dZlp+$NdivZ_ret*$dZret+$NdivZ_colB3*$dZcolB3]  
node [expr $C9+10] 0.0 [expr $Y9] [expr $Z9+$NdivZ_Lp*$dZlp+$NdivZ_ret*$dZret+$NdivZ_colB4*$dZcolB4]  
node [expr $C11+10] 0.0 [expr $Y11] [expr $Z11+$NdivZ_Lp*$dZlp+$NdivZ_ret*$dZret+$NdivZ_colB1*$dZcolB1] 



set A_Deck 4452.
set Iy_Deck 968712.
set Iz_Deck 58878554.



#Deck
element elasticBeamColumn 10 [expr $C1+10] [expr $C5+10] $A_Deck [expr 0.5*$Ec] $G $J_Deck $Iy_Deck $Iz_Deck $BeamTransf 
element elasticBeamColumn 20 [expr $C5+10] [expr $C7+10] $A_Deck [expr 0.5*$Ec] $G $J_Deck $Iy_Deck $Iz_Deck $BeamTransf 
element elasticBeamColumn 30 [expr $C7+10] [expr $C9+10] $A_Deck [expr 0.5*$Ec] $G $J_Deck $Iy_Deck $Iz_Deck $BeamTransf 
element elasticBeamColumn 40 [expr $C9+10] [expr $C11+10] $A_Deck [expr 0.5*$Ec] $G $J_Deck $Iy_Deck $Iz_Deck $BeamTransf 



set EH $Ec

set GH [expr $EH/2.4]
set JH [expr 1.*$J_BeamH]
set IYH [expr pow($hH,3)*$bH/12]
set IZH [expr 1000.*pow($bH,3)*$hH/12]
set A_BeamH [expr $bH*$hH]



element elasticBeamColumn 101 [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] $A_BeamH [expr $EH] [expr $GH] $JH $IYH $IZH $BeamTransf 
element elasticBeamColumn 102 [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C1+10] 							  $A_BeamH [expr $EH] [expr $GH] $JH $IYH $IZH $BeamTransf 
element elasticBeamColumn 103 [expr $C1+10] 							  [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] $A_BeamH [expr $EH] [expr $GH] $JH $IYH $IZH $BeamTransf 
element elasticBeamColumn 104 [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] $A_BeamH [expr $EH] [expr $GH] $JH $IYH $IZH $BeamTransf 
                                                                                                                                               
element elasticBeamColumn 201 [expr $C5+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C5+10]							  $A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf
element elasticBeamColumn 202 [expr $C5+10] [expr $C6+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100]							  $A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf
                                                                                                                                               
element elasticBeamColumn 301 [expr $C7+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C7+10]							  $A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf
element elasticBeamColumn 302 [expr $C7+10] [expr $C8+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100]							  $A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf

element elasticBeamColumn 401 [expr $C9+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] [expr $C9+10]							  $A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf
element elasticBeamColumn 402 [expr $C9+10] [expr $C10+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100]							  $A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf
                                                                                                                    
element elasticBeamColumn 501 [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] $A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf
element elasticBeamColumn 502 [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C11+10]							    $A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf
element elasticBeamColumn 503 [expr $C11+10]								   [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] 	$A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf
element elasticBeamColumn 504 [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] $A_BeamH [expr $EH] [expr $GH] $JH  $IYH $IZH $BeamTransf



#Abutments


node [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $X1+0.0] [expr $Y1+0.0] [expr $Z1+$NdivZ_colB1*$dZcolB1+$Lret]
node [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $X2+0.0] [expr $Y2+0.0] [expr $Z2+$NdivZ_colB1*$dZcolB1+$Lret]
node [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $X3+0.0] [expr $Y3+0.0] [expr $Z3+$NdivZ_colB1*$dZcolB1+$Lret]
node [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $X4+0.0] [expr $Y4+0.0] [expr $Z4+$NdivZ_colB1*$dZcolB1+$Lret]
                                                        
node [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $X11+0.0] [expr $Y11+0.0] [expr $Z11+$NdivZ_colB1*$dZcolB1+$Lret]
node [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $X12+0.0] [expr $Y12+0.0] [expr $Z12+$NdivZ_colB1*$dZcolB1+$Lret]
node [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $X13+0.0] [expr $Y13+0.0] [expr $Z13+$NdivZ_colB1*$dZcolB1+$Lret]
node [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $X14+0.0] [expr $Y14+0.0] [expr $Z14+$NdivZ_colB1*$dZcolB1+$Lret]

fix [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  1 1 1 1 1 1
fix [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  1 1 1 1 1 1
fix [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  1 1 1 1 1 1
fix [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  1 1 1 1 1 1

fix [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]   1 1 1 1 1 1
fix [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]   1 1 1 1 1 1
fix [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]   1 1 1 1 1 1
fix [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]   1 1 1 1 1 1


element zeroLength [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  -mat $Abut_long_edge -dir 2
element zeroLength [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  -mat $Abut_long -dir 2
element zeroLength [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  -mat $Abut_long -dir 2
element zeroLength [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  -mat $Abut_long_edge -dir 2
                                                                                                                                                         
element zeroLength [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  -mat $Abut_long_edge -dir 2
element zeroLength [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] -mat $Abut_long -dir 2
element zeroLength [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] -mat $Abut_long -dir 2
element zeroLength [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] -mat $Abut_long_edge -dir 2

element zeroLength [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+11]  [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  -mat $Abut_tran -dir 1
element zeroLength [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+11]  [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  -mat $Abut_tran -dir 1

element zeroLength [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+11]  [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10]  [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  -mat $Abut_tran -dir 1
element zeroLength [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+11] [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100+10] -mat $Abut_tran -dir 1

# set h 20
# recorder display "Mode Shape 1" 10 10 500 500 -wipe
# prp 9.700 $h 1;
# vup  0 0 1;
# # vup  1  1 1;
# vpn  1 1 1;
# viewWindow -1000 1000 -1000 1000
# display 1 2 50


mass [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  [expr 30.1/$g] [expr 30.1/$g] [expr 30.1/$g] 0.0 0.0 0.0
mass [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  [expr 30.1/$g] [expr 30.1/$g] [expr 30.1/$g] 0.0 0.0 0.0
mass [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  [expr 30.1/$g] [expr 30.1/$g] [expr 30.1/$g] 0.0 0.0 0.0
mass [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  [expr 30.1/$g] [expr 30.1/$g] [expr 30.1/$g] 0.0 0.0 0.0
mass [expr $C5+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100]  [expr 178.2/$g] [expr 178.2/$g] [expr 178.2/$g] 0.0 0.0 0.0
mass [expr $C6+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100]  [expr 178.2/$g] [expr 178.2/$g] [expr 178.2/$g] 0.0 0.0 0.0
mass [expr $C7+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100]  [expr 178.2/$g] [expr 178.2/$g] [expr 178.2/$g] 0.0 0.0 0.0
mass [expr $C8+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100]  [expr 178.2/$g] [expr 178.2/$g] [expr 178.2/$g] 0.0 0.0 0.0
mass [expr $C9+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100]  [expr 178.2/$g] [expr 178.2/$g] [expr 178.2/$g] 0.0 0.0 0.0
mass [expr $C10+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] [expr 178.2/$g] [expr 178.2/$g] [expr 178.2/$g] 0.0 0.0 0.0
mass [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr 30.1/$g] [expr 30.1/$g] [expr 30.1/$g] 0.0 0.0 0.0
mass [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr 30.1/$g] [expr 30.1/$g] [expr 30.1/$g] 0.0 0.0 0.0
mass [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr 30.1/$g] [expr 30.1/$g] [expr 30.1/$g] 0.0 0.0 0.0
mass [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr 30.1/$g] [expr 30.1/$g] [expr 30.1/$g] 0.0 0.0 0.0
 


#DEAD LOAD  
# 238.4 kip / 150 ft
#LIVE LOAD

#lumped load

 pattern Plain 1 Linear {
 
load [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] 0.0 0.0 -30.1 0.0 0.0 0.0
load [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] 0.0 0.0 -30.1 0.0 0.0 0.0
load [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] 0.0 0.0 -30.1 0.0 0.0 0.0
load [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] 0.0 0.0 -30.1 0.0 0.0 0.0
load [expr $C5+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] 0.0 0.0 -178.2 0.0 0.0 0.0
load [expr $C6+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] 0.0 0.0 -178.2 0.0 0.0 0.0
load [expr $C7+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] 0.0 0.0 -178.2 0.0 0.0 0.0
load [expr $C8+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] 0.0 0.0 -178.2 0.0 0.0 0.0
load [expr $C9+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] 0.0 0.0 -178.2 0.0 0.0 0.0
load [expr $C10+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] 0.0 0.0 -178.2 0.0 0.0 0.0
load [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] 0.0 0.0 -30.1 0.0 0.0 0.0
load [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] 0.0 0.0 -30.1 0.0 0.0 0.0
load [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] 0.0 0.0 -30.1 0.0 0.0 0.0
load [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] 0.0 0.0 -30.1 0.0 0.0 0.0

 }
 

set xDamp      0.05; # damping ratio
set MpropSwitch 1.0;
set KcurrSwitch 1.0;
set KcommSwitch 0.0;
set KinitSwitch 0.0;

set nEigenI       1; # mode 1
set nEigenJ       5; # mode 6

set PI 3.1415
set nEigenModes 6;
set lambdaN [eigen -generalized $nEigenModes]; # eigenvalue analysis for nEigenJ modes
set lambda0 [lindex $lambdaN 0]; # eigenvalue mode i
set lambda1 [lindex $lambdaN 1]; # eigenvalue mode i
set lambda2 [lindex $lambdaN 2]; # eigenvalue mode i
set lambda3 [lindex $lambdaN 3]; # eigenvalue mode i
set lambda4 [lindex $lambdaN 4]; # eigenvalue mode i
set lambda5 [lindex $lambdaN 5]; # eigenvalue mode i
# set lambda6 [lindex $lambdaN 6]; # eigenvalue mode i
# set lambda7 [lindex $lambdaN 7]; # eigenvalue mode i
set omega0 [expr pow($lambda0,0.5)];
set omega1 [expr pow($lambda1,0.5)];
set omega2 [expr pow($lambda2,0.5)];
set omega3 [expr pow($lambda3,0.5)];
set omega4 [expr pow($lambda4,0.5)];
set omega5 [expr pow($lambda5,0.5)];
# set omega6 [expr pow($lambda6,0.5)];
# set omega7 [expr pow($lambda7,0.5)];
set T0 [expr (2.*$PI)/$omega0];
set T1 [expr (2.*$PI)/$omega1];
set T2 [expr (2.*$PI)/$omega2];
set T3 [expr (2.*$PI)/$omega3];
set T4 [expr (2.*$PI)/$omega4];
set T5 [expr (2.*$PI)/$omega5];
# set T6 [expr (2.*$PI)/$omega6];
# set T7 [expr (2.*$PI)/$omega7];
# set omega1 [expr (2.*$PI)/$T0];
# set omega5 [expr (2.*$PI)/0.1];
 puts "T = $T0 $T1 $T2 $T3 $T4 $T5";





recorder Node -file ReactionsX.out -time -node $C5 $C6 $C7 $C8 $C9 $C10 -dof 1 reaction;
 recorder Node -file ReactionsY.out -time -node $C5 $C6 $C7 $C8 $C9 $C10 -dof 2 reaction;
 recorder Node -file ReactionsZ.out -time -node $C5 $C6 $C7 $C8 $C9 $C10 -dof 3 reaction;
 
recorder Node -file DispX.out -time -node [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C1+10] [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C5+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C5+10] [expr $C6+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C7+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C7+10] [expr $C8+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C9+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] [expr $C9+10] [expr $C10+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100]  [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C11+10] [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] -dof 1 disp;
 
  
 recorder Node -file DispY.out -time -node [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C1+10] [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C5+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C5+10] [expr $C6+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C7+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C7+10] [expr $C8+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C9+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] [expr $C9+10] [expr $C10+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100]  [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C11+10] [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] -dof 2 disp;
  
 recorder Drift -file DriftX.out -time -iNode $C5 $C5 $C6 $C7 $C7 $C8 $C9 $C9 $C10 -jNode [expr $C5+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C5+10] [expr $C6+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C7+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C7+10] [expr $C8+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C9+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] [expr $C9+10] [expr $C10+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100]  -dof  1   -perpDirn      3
  
 recorder Drift -file DriftY.out -time -iNode $C5 $C5 $C6 $C7 $C7 $C8 $C9 $C9 $C10 -jNode  [expr $C5+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C5+10] [expr $C6+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C7+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C7+10] [expr $C8+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C9+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] [expr $C9+10] [expr $C10+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100]  -dof   2   -perpDirn      3
 
 recorder Element -file ForcesColumnsA.out -time -ele [expr $C5+100] [expr $C6+100] [expr $C7+100] [expr $C8+100] [expr $C9+100] [expr $C10+100]  globalForce
 recorder Element -file ForcesColumnsB.out -time -ele [expr $C5+100*($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)] [expr $C6+100*($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)] [expr $C7+100*($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)] [expr $C8+100*($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)] [expr $C9+100*($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)] [expr $C10+100*($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)] globalForce

 recorder Element -file DeformationColumnsA.out -time -ele [expr $C5+100] [expr $C6+100] [expr $C7+100] [expr $C8+100] [expr $C9+100] [expr $C10+100]  basicDeformation
 recorder Element -file DeformationColumnsB.out -time -ele [expr $C5+100*($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)] [expr $C6+100*($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)] [expr $C7+100*($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)] [expr $C8+100*($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)] [expr $C9+100*($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)] [expr $C10+100*($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)] basicDeformation
 
  recorder Element -file C5C8C9_Core_fiberX.out -time -ele [expr $C5+100] [expr $C8+100] [expr $C9+100] section 1 fiber 6.0 0.0 stressStrain
 recorder Element -file C5C8C9_Core_fiberY.out -time -ele [expr $C5+100] [expr $C8+100] [expr $C9+100] section 1 fiber 0.0 6.0 stressStrain
 recorder Element -file C5C8C9_Cover_fiberX.out -time -ele [expr $C5+100] [expr $C8+100] [expr $C9+100] section 1 fiber 11.0 0.0 stressStrain
 recorder Element -file C5C8C9_Cover_fiberY.out -time -ele [expr $C5+100] [expr $C8+100] [expr $C9+100] section 1 fiber 0.0 11.0 stressStrain
 recorder Element -file C5C8C9_Bar_fiber.out -time -ele [expr $C5+100] [expr $C8+100] [expr $C9+100] section 1 fiber [expr -$h/2+$c1] [expr $h/2-$c1] stressStrain
 
 

 
# Create a Plain load pattern with a linear TimeSeries
 
 # ------------------------------
# Analysis generation
# ------------------------------
system ProfileSPD
constraints Transformation
test NormDispIncr 1.0e-8 20
algorithm Newton
numberer RCM
integrator LoadControl 0.1
analysis Static

analyze 10

loadConst -time 0.0

puts "Gravity Analysis complete!"
 
 
 set PI 3.1415
set nEigenModes 6;
set lambdaN [eigen -generalized $nEigenModes]; # eigenvalue analysis for nEigenJ modes
set lambda0 [lindex $lambdaN 0]; # eigenvalue mode i
set lambda1 [lindex $lambdaN 1]; # eigenvalue mode i
set lambda2 [lindex $lambdaN 2]; # eigenvalue mode i
set lambda3 [lindex $lambdaN 3]; # eigenvalue mode i
set lambda4 [lindex $lambdaN 4]; # eigenvalue mode i
set lambda5 [lindex $lambdaN 5]; # eigenvalue mode i
# set lambda6 [lindex $lambdaN 6]; # eigenvalue mode i
# set lambda7 [lindex $lambdaN 7]; # eigenvalue mode i
set omega0 [expr pow($lambda0,0.5)];
set omega1 [expr pow($lambda1,0.5)];
set omega2 [expr pow($lambda2,0.5)];
set omega3 [expr pow($lambda3,0.5)];
set omega4 [expr pow($lambda4,0.5)];
set omega5 [expr pow($lambda5,0.5)];
# set omega6 [expr pow($lambda6,0.5)];
# set omega7 [expr pow($lambda7,0.5)];
set T0 [expr (2.*$PI)/$omega0];
set T1 [expr (2.*$PI)/$omega1];
set T2 [expr (2.*$PI)/$omega2];
set T3 [expr (2.*$PI)/$omega3];
set T4 [expr (2.*$PI)/$omega4];
set T5 [expr (2.*$PI)/$omega5];
# set T6 [expr (2.*$PI)/$omega6];
# set T7 [expr (2.*$PI)/$omega7];
# set omega1 [expr (2.*$PI)/$T0];
# set omega5 [expr (2.*$PI)/0.1];
 puts "T = $T0 $T1 $T2 $T3 $T4 $T5";
 

set alphaM    [expr $MpropSwitch*$xDamp*(2.*$omega0*$omega5)/($omega1+$omega5)]; # M-prop. damping; D = alphaM*M
set betaKcurr                  [expr $KcurrSwitch*2.*$xDamp/($omega1+$omega5)]; # current-K;         + betaKcurr*KCurrent
set betaKcomm                  [expr $KcommSwitch*2.*$xDamp/($omega1+$omega5)]; # last-committed K;  + betaKcomm*KlastCommitt
set betaKinit                  [expr $KinitSwitch*2.*$xDamp/($omega1+$omega5)]; # initial-K;         + betaKinit*Kini

rayleigh $alphaM $betaKcurr $betaKinit $betaKcomm; # RAYLEIGH damping


#RUNNING GROUND MOTION

	
# Uniform Earthquake ground motion (uniform acceleration input at all support nodes)
set GMdirectionX 2;				    # ground-motion direction in global X direction
set GMdirectionY 1;				    # ground-motion direction in global Z direction
set GMXfile $Qake_X ;	# ground-motion filenames in global X direction
set GMYfile $Qake_Y ;	# ground-motion filenames in global Z direction
set GMXfact $Qake_factor; 				    # ground-motion scaling factor in global X direction
set GMYfact $Qake_factor; 				    # ground-motion scaling factor in global Z direction
set DtAnalysis	0.005;	# time-step Dt for lateral analysis
# set up ground-motion-analysis parameters
set TmaxAnalysis	[expr $npts*$dt + 5];	# maximum duration of ground-motion analysis 

#  ---------------------------------    perform Dynamic Ground-Motion Analysis
# the following commands are unique to the Uniform Earthquake excitation
set IDloadTagX 6000 
set IDloadTagY 7000
# Uniform EXCITATION: acceleration input

set GMXfatt [expr 1.0*$GMXfact];
set GMYfatt [expr 1.0*$GMYfact];


#timeSeries Path    $tag     -dt $dt -filePath $filePath <-factor $cFactor>
 timeSeries Path $IDloadTagX -dt $dt -filePath $GMXfile   -factor $GMXfatt;		# time series information in X-direction
 timeSeries Path $IDloadTagY -dt $dt -filePath $GMYfile   -factor $GMYfatt;		# time series information in Z-direction

#pattern UniformExcitation  $patternTag       $dir     -accel     $tsTag 
 pattern UniformExcitation  $IDloadTagX  $GMdirectionX -accel  $IDloadTagX  ;	# create Uniform excitation in X-direction
 pattern UniformExcitation  $IDloadTagY  $GMdirectionY -accel  $IDloadTagY  ;	# create Uniform excitation in Z-direction 
 
 
  recorder Node -file Accel_X.out -timeSeries $IDloadTagX -time -node [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C1+10] [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C5+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C5+10] [expr $C6+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C7+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C7+10] [expr $C8+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C9+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] [expr $C9+10] [expr $C10+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100]  [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C11+10] [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  -dof 1 accel;
 recorder Node -file Accel_Y.out -timeSeries $IDloadTagY -time -node [expr $C1+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C2+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C1+10] [expr $C3+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C4+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C5+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C5+10] [expr $C6+($NdivZ_Lp+$NdivZ_colB2+$NdivZ_ret)*100] [expr $C7+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C7+10] [expr $C8+($NdivZ_Lp+$NdivZ_colB3+$NdivZ_ret)*100] [expr $C9+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100] [expr $C9+10] [expr $C10+($NdivZ_Lp+$NdivZ_colB4+$NdivZ_ret)*100]  [expr $C11+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C12+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C11+10] [expr $C13+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100] [expr $C14+($NdivZ_Lp+$NdivZ_colB1+$NdivZ_ret)*100]  -dof 2 accel;
 
 
# 
 
# ----------- set up analysis parameters

# DYNAMIC ANALYSIS PARAMETERS
constraints Transformation ;
 # constraints Penalty 1e15 1e15 ;
numberer RCM
# system BandGeneral
# system ProfileSPD
system SparseSYM
# system UmfPack
set Tol 1.e-6;                        # Convergence Test: tolerance
test NormDispIncr $Tol 20 ;
algorithm Newton;        
set NewmarkGamma 0.5;	# Newmark-integrator gamma parameter (also HHT)
set NewmarkBeta 0.25;	# Newmark-integrator beta parameter
integrator Newmark $NewmarkGamma $NewmarkBeta 
analysis Transient

 
 
puts "perform analysis"

#--------------------------------  perform analysis-------------------------
set NumSteps [expr int($TmaxAnalysis/$DtAnalysis)];

set Niter 1;

puts "running Ground Motion..." ;

set failure 0;
set failure2 0;
set collapse 0;
set time_ajust 0;
set time 0;
set ok 0;




while {$time < $TmaxAnalysis  &&  $ok == 0} {    

	algorithm KrylovNewton;
	test NormDispIncr $Tol 20 ;
	set ok [analyze 1 $DtAnalysis];	# ok = 0 if analysis was completed

if {$ok != 0} {      					# analysis was not successful.
	# --------------------------------------------------------------------------------------------------
	# change some analysis parameters to achieve convergence
	# performance is slower inside this loop
	#    Time-controlled analysis
	set ok 0;
	set controlTime [getTime];
#ARB	test NormDispIncr $Tol 1000 ;
#	set controlTime [getTime];
#	while {$controlTime < $GMtime && $ok == 0} 
#		set controlTime [getTime]

		puts "trying with a smaller time-step";
		set dt_analysis_2 [expr $DtAnalysis/10.];
		set ok [analyze 10 $dt_analysis_2];
		if {$ok != 0} {
		puts "trying with a larger tolerance";
			set Tol_2 [expr $Tol*1000];
			algorithm Newton;
			test NormDispIncr $Tol_2 20;
			set ok [analyze 1 $DtAnalysis]
		}
		
			# if {$ok != 0} {
			# puts "Trying with Modified Newton..."
			# algorithm ModifiedNewton;
			# test NormDispIncr $Tol_2 50;
			# set ok [analyze 1 $DtAnalysis]
			
			# }
		if {$ok != 0} {
		puts "trying with even larger tolerance";
			set Tol_3 [expr $Tol*100000];
			algorithm Newton -initial;
			test NormDispIncr $Tol_3 20 ;
			set ok [analyze 1 $DtAnalysis]
		
		}
		
				if {$ok != 0} {
			puts "Trying with Modified Newton 2..."
			algorithm ModifiedNewton;
			test NormDispIncr $Tol_2 50;
			set ok [analyze 1 $DtAnalysis]	
			}
		# if {$ok != 0} {
		# puts "largest tolerance";
			# set Tol_4 [expr $Tol*1000000000];
			# algorithm Newton -initial;
			# test NormDispIncr $Tol_4 20 ;
			# set ok [analyze 1 $DtAnalysis]
		# }
		# if {$ok != 0} {
			# puts "Trying with Modified Newton 3..."
			# algorithm ModifiedNewton;
			# test NormDispIncr $Tol_4 50;
			# set ok [analyze 1 $DtAnalysis]
			
			# }

if {$ok == 0} {
puts "problem solved; time: [getTime]";
}
};			# end if ok !0

	if { $ok < 0 } {
	puts "Incomplete Dynamic Analysis";
	set Niter [expr $NumSteps+1];
	set time_ajust 1E5;
	}
	
	set Niter [expr $Niter +1 ];
	set time [expr [getTime] + $time_ajust];

}
# output time at end of analysis	
set currentTime [getTime];	# get current analysis time	(after dynamic analysis)
puts "The current time is: $currentTime (Total time: $TmaxAnalysis)";

wipe;


wipe;
