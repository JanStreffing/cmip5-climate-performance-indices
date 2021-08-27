#!/bin/bash

##############################################################################
# This script prepares OIFS output for Tido Semmlers climate indicies script #
# Author: Jan Streffing 2019-01-21					     #
##############################################################################

origdir=$1 # e.g. /p/scratch/chhb19/jstreffi/runtime/awicm-3.1/PICT/outdata/oifs/links

cd $origdir
printf "#################################"
pwd
printf "#################################"

for i in `seq 10 11`;
do
	for var in CI T2M TTR TCC CP LSP U10M V10M U V Z;
	do
		printf "working on", $var
		cdo cat ${var}_$(printf "%05d" $i).nc ${var}_analysis_period.nc
		cdo remapbil,r180x91 ${var}_analysis_period.nc ${var}_analysis_period_remap.nc
	done
done

cdo chname,CI,seaice CI_analysis_period_remap.nc SICE.nc
cdo chname,T2M,temp2 T2M_analysis_period_remap.nc T2M.nc
cdo chname,TCC,aclcov TCC_analysis_period_remap.nc TCC.nc
cdo chname,LSP,CP LSP_analysis_period_remap.nc LSP_r.nc
cdo add CP_analysis_period_remap.nc LSP_r.nc TP_t.nc
cdo chname,CP,aprc TP_t.nc TP.nc
cdo chname,TTR,trad0 TTR_analysis_period_remap.nc TTR.nc
cdo chname,U10M,u10 U10M_analysis_period_remap.nc U10M.nc
cdo chname,V10M,v10 V10M_analysis_period_remap.nc V10M.nc
cdo chname,U,var131 U_analysis_period_remap.nc var131.nc
cdo sellevel,30000 U_analysis_period_remap.nc U_300s.nc
cdo chname,U,var131 U_300s.nc U_300.nc
cdo sellevel,50000 Z_analysis_period_remap.nc GEOPOT_500s.nc
cdo chname,Z,var129 GEOPOT_500s.nc GEOPOT_500.nc


for var in SICE T2M TCC TP TTR U10M V10M U_300 GEOPOT_500;
do
	cdo timmean -select,season=MAM $var.nc ${var}_2010_2020_avg_MAM.nc
	cdo timmean -select,season=JJA $var.nc ${var}_2010_2020_avg_JJA.nc
	cdo timmean -select,season=SON $var.nc ${var}_2010_2020_avg_SON.nc
	cdo timmean -select,season=DJF $var.nc ${var}_2010_2020_avg_DJF.nc
done
