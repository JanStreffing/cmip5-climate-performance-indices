#!/bin/bash

##############################################################################
# This script prepares OIFS output for Tido Semmlers climate indicies script #
# Author: Jan Streffing 2019-01-21					     #
##############################################################################

origdir=$1

cd $origdir

rm -f SH_monthly_analysis_period.nc GG_monthly_analysis_period.nc

for i in `seq 5 6`;
do
	cdo cat ICMPPSH$(printf "%05d" $i)_monmean.nc SH_monthly_analysis_period.nc
	cdo cat ICMPPGG$(printf "%05d" $i)_monmean.nc GG_monthly_analysis_period.nc
done

cdo remapbil,r180x91 SH_monthly_analysis_period.nc SH_monthly_analysis_period_remap.nc
cdo remapbil,r180x91 GG_monthly_analysis_period.nc GG_monthly_analysis_period_remap.nc

cdo selvar,CI GG_monthly_analysis_period_remap.nc CI.nc
cdo chname,CI,seaice CI.nc seaice.nc
cdo timmean -select,season=MAM seaice.nc SICE_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA seaice.nc SICE_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON seaice.nc SICE_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF seaice.nc SICE_2010_2020_avg_DJF.nc

cdo selvar,T2M GG_monthly_analysis_period_remap.nc T2M.nc
cdo chname,T2M,temp2 T2M.nc temp2.nc
cdo timmean -select,season=MAM temp2.nc T2M_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA temp2.nc T2M_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON temp2.nc T2M_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF temp2.nc T2M_2010_2020_avg_DJF.nc

cdo selvar,TCC GG_monthly_analysis_period_remap.nc TCC.nc
cdo chname,TCC,aclcov TCC.nc aclcov.nc
cdo timmean -select,season=MAM aclcov.nc TCC_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA aclcov.nc TCC_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON aclcov.nc TCC_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF aclcov.nc TCC_2010_2020_avg_DJF.nc

cdo selvar,CP GG_monthly_analysis_period_remap.nc CP.nc
cdo selvar,LSP GG_monthly_analysis_period_remap.nc LSP.nc
cdo chname,LSP,CP LSP.nc LSP_r.nc
cdo add CP.nc LSP_r.nc TP.nc
cdo chname,CP,aprc TP.nc aprc.nc
cdo timmean -select,season=MAM aprc.nc TP_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA aprc.nc TP_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON aprc.nc TP_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF aprc.nc TP_2010_2020_avg_DJF.nc

cdo selvar,TTR GG_monthly_analysis_period_remap.nc TTR.nc
cdo chname,TTR,trad0 TTR.nc trad0.nc
cdo timmean -select,season=MAM trad0.nc TTR_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA trad0.nc TTR_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON trad0.nc TTR_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF trad0.nc TTR_2010_2020_avg_DJF.nc

cdo selvar,U10M GG_monthly_analysis_period_remap.nc U10M.nc
cdo chname,U10M,u10 U10M.nc u10.nc
cdo timmean -select,season=MAM u10.nc U10M_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA u10.nc U10M_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON u10.nc U10M_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF u10.nc U10M_2010_2020_avg_DJF.nc

cdo selvar,V10M GG_monthly_analysis_period_remap.nc V10M.nc
cdo chname,V10M,v10 V10M.nc v10.nc
cdo timmean -select,season=MAM v10.nc V10M_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA v10.nc V10M_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON v10.nc V10M_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF v10.nc V10M_2010_2020_avg_DJF.nc

cdo selvar,U SH_monthly_analysis_period_remap.nc U.nc
cdo chname,U,var131 U.nc var131.nc
cdo timmean -select,season=MAM var131.nc U_300_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA var131.nc U_300_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON var131.nc U_300_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF var131.nc U_300_2010_2020_avg_DJF.nc


cdo selvar,U SH_monthly_analysis_period_remap.nc U.nc
cdo sellevel,30000 U.nc U_300.nc
cdo chname,U,var131 U_300.nc var131.nc
cdo timmean -select,season=MAM var131.nc U_300_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA var131.nc U_300_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON var131.nc U_300_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF var131.nc U_300_2010_2020_avg_DJF.nc


cdo selvar,Z SH_monthly_analysis_period_remap.nc Z.nc
cdo sellevel,50000 Z.nc Z_500.nc
cdo chname,Z,var129 Z_500.nc var129.nc
cdo timmean -select,season=MAM var129.nc GEOPOT_500_2010_2020_avg_MAM.nc
cdo timmean -select,season=JJA var129.nc GEOPOT_500_2010_2020_avg_JJA.nc
cdo timmean -select,season=SON var129.nc GEOPOT_500_2010_2020_avg_SON.nc
cdo timmean -select,season=DJF var129.nc GEOPOT_500_2010_2020_avg_DJF.nc

