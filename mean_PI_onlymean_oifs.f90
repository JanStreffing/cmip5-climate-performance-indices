program meanpi
!!! Original by Tido Semmler
!!! With modifications from Jan Streffing

!!! Now my PI programme PI.job gives not any longer the normalized squared error
!!! as a second value. Instead the mean absolute error of the interannual
!!! standard deviation. The normalized squared error can be retrieved by 
!!! using the original programme PI_orig.job.

implicit none

integer, parameter :: numpi = 32          ! number of variables * seasons
integer, parameter :: numpolpi = 4        ! number of polar variables * seasons
integer, parameter :: nummodel = 6        ! number of models
integer, parameter :: numregions = 7      ! number of regions
integer, parameter :: numpolregions = 2   ! number of polar regions
integer :: i,j,k,l,numfiles
real :: abs(numpi+numpolpi,nummodel,numregions)    ! mean absolute error
real :: nse(numpi+numpolpi,nummodel,numregions)    ! normalized squared error
real :: meanabs(numpi+numpolpi,numregions)         ! mean absolute error averaged over all models but ECHAM-FESOM
real :: meannse(numpi+numpolpi,numregions)         ! normalized squared error averaged over all models but ECHAM-FESOM
real :: ecfesabs(numpi+numpolpi,numregions)        ! ECHAM-FESOM mean absolute error divided by meanabs
real :: ecfesnse(numpi+numpolpi,numregions)        ! ECHAM-FESOM normalized squared error divided by meannse
real :: ecfesabsall(numregions)           ! ECHAM-FESOM PI based on mean absolute error (average over all numpi)
real :: ecfesnseall(numregions)           ! ECHAM-FESOM PI based on normalized squared error (average over all numpi)
character*10 :: par(numpi+numpolpi)
character*3 :: season(numpi+numpolpi)
character*3 :: dummy
character(len=4096) :: nmlfile, dir_in, dir_obs

nmlfile ='namelist.nml'
open (20,file=nmlfile)
read (20,NML=config)
NAMELIST /config/ dir_in, dir_obs
close (20)

open (10,FILE=TRIM(dir_in)//'/PI.txt',&
FORM='formatted')
open (11,FILE=TRIM(dir_obs)//'/GFDL-CM3_PI_SEMMLER_detrend/PI.txt',FORM='formatted')
open (12,FILE=TRIM(dir_obs)//'/CCSM4_PI_SEMMLER_detrend/PI.txt',FORM='formatted')
open (13,FILE=TRIM(dir_obs)//'/ECHAM_MPIOM_LR_PI_SEMMLER_detrend/PI.txt',FORM='formatted')
open (14,FILE=TRIM(dir_obs)//'/HadGEM2-ES_PI_SEMMLER_detrend/PI.txt',FORM='formatted')
open (15,FILE=TRIM(dir_obs)//'/MIROC-ESM_PI_SEMMLER_detrend/PI.txt',FORM='formatted')
open (16,FILE=TRIM(dir_in)//'/PI_tropics.txt',&
FORM='formatted')
open (17,FILE=TRIM(dir_obs)//'/GFDL-CM3_PI_SEMMLER_detrend/PI_tropics.txt',FORM='formatted')
open (18,FILE=TRIM(dir_obs)//'/CCSM4_PI_SEMMLER_detrend/PI_tropics.txt',FORM='formatted')
open (19,FILE=TRIM(dir_obs)//'/ECHAM_MPIOM_LR_PI_SEMMLER_detrend/PI_tropics.txt',FORM='formatted')
open (20,FILE=TRIM(dir_obs)//'/HadGEM2-ES_PI_SEMMLER_detrend/PI_tropics.txt',FORM='formatted')
open (21,FILE=TRIM(dir_obs)//'/MIROC-ESM_PI_SEMMLER_detrend/PI_tropics.txt',FORM='formatted')
open (22,FILE=TRIM(dir_in)//'/PI_antarctic.txt',&
FORM='formatted')
open (23,FILE=TRIM(dir_obs)//'/GFDL-CM3_PI_SEMMLER_detrend/PI_antarctic.txt',FORM='formatted')
open (24,FILE=TRIM(dir_obs)//'/CCSM4_PI_SEMMLER_detrend/PI_antarctic.txt',FORM='formatted')
open (25,FILE=TRIM(dir_obs)//'/ECHAM_MPIOM_LR_PI_SEMMLER_detrend/PI_antarctic.txt',FORM='formatted')
open (26,FILE=TRIM(dir_obs)//'/HadGEM2-ES_PI_SEMMLER_detrend/PI_antarctic.txt',FORM='formatted')
open (27,FILE=TRIM(dir_obs)//'/MIROC-ESM_PI_SEMMLER_detrend/PI_antarctic.txt',FORM='formatted')
open (28,FILE=TRIM(dir_in)//'/PI_southmid.txt',&
FORM='formatted')
open (29,FILE=TRIM(dir_obs)//'/GFDL-CM3_PI_SEMMLER_detrend/PI_southmid.txt',FORM='formatted')
open (30,FILE=TRIM(dir_obs)//'/CCSM4_PI_SEMMLER_detrend/PI_southmid.txt',FORM='formatted')
open (31,FILE=TRIM(dir_obs)//'/ECHAM_MPIOM_LR_PI_SEMMLER_detrend/PI_southmid.txt',FORM='formatted')
open (32,FILE=TRIM(dir_obs)//'/HadGEM2-ES_PI_SEMMLER_detrend/PI_southmid.txt',FORM='formatted')
open (33,FILE=TRIM(dir_obs)//'/MIROC-ESM_PI_SEMMLER_detrend/PI_southmid.txt',FORM='formatted')
open (34,FILE=TRIM(dir_in)//'/PI_arctic.txt',&
FORM='formatted')
open (35,FILE=TRIM(dir_obs)//'/GFDL-CM3_PI_SEMMLER_detrend/PI_arctic.txt',FORM='formatted')
open (36,FILE=TRIM(dir_obs)//'/CCSM4_PI_SEMMLER_detrend/PI_arctic.txt',FORM='formatted')
open (37,FILE=TRIM(dir_obs)//'/ECHAM_MPIOM_LR_PI_SEMMLER_detrend/PI_arctic.txt',FORM='formatted')
open (38,FILE=TRIM(dir_obs)//'/HadGEM2-ES_PI_SEMMLER_detrend/PI_arctic.txt',FORM='formatted')
open (39,FILE=TRIM(dir_obs)//'/MIROC-ESM_PI_SEMMLER_detrend/PI_arctic.txt',FORM='formatted')
open (40,FILE=TRIM(dir_in)//'/PI_northmid.txt',&
FORM='formatted')
open (41,FILE=TRIM(dir_obs)//'/GFDL-CM3_PI_SEMMLER_detrend/PI_northmid.txt',FORM='formatted')
open (42,FILE=TRIM(dir_obs)//'/CCSM4_PI_SEMMLER_detrend/PI_northmid.txt',FORM='formatted')
open (43,FILE=TRIM(dir_obs)//'/ECHAM_MPIOM_LR_PI_SEMMLER_detrend/PI_northmid.txt',FORM='formatted')
open (44,FILE=TRIM(dir_obs)//'/HadGEM2-ES_PI_SEMMLER_detrend/PI_northmid.txt',FORM='formatted')
open (45,FILE=TRIM(dir_obs)//'/MIROC-ESM_PI_SEMMLER_detrend/PI_northmid.txt',FORM='formatted')
open (46,FILE=TRIM(dir_in)//'/PI_innertr.txt',&
FORM='formatted')
open (47,FILE=TRIM(dir_obs)//'/GFDL-CM3_PI_SEMMLER_detrend/PI_innertr.txt',FORM='formatted')
open (48,FILE=TRIM(dir_obs)//'/CCSM4_PI_SEMMLER_detrend/PI_innertr.txt',FORM='formatted')
open (49,FILE=TRIM(dir_obs)//'/ECHAM_MPIOM_LR_PI_SEMMLER_detrend/PI_innertr.txt',FORM='formatted')
open (50,FILE=TRIM(dir_obs)//'/HadGEM2-ES_PI_SEMMLER_detrend/PI_innertr.txt',FORM='formatted')
open (51,FILE=TRIM(dir_obs)//'/MIROC-ESM_PI_SEMMLER_detrend/PI_innertr.txt',FORM='formatted')
open (52,FILE=TRIM(dir_in)//'/PI_arctic_sic.txt',&
FORM='formatted')
open (53,FILE=TRIM(dir_obs)//'/GFDL-CM3_PI_SEMMLER_detrend/PI_arctic_sic.txt',FORM='formatted')
open (54,FILE=TRIM(dir_obs)//'/CCSM4_PI_SEMMLER_detrend/PI_arctic_sic.txt',FORM='formatted')
open (55,FILE=TRIM(dir_obs)//'/ECHAM_MPIOM_LR_PI_SEMMLER_detrend/PI_arctic_sic.txt',FORM='formatted')
open (56,FILE=TRIM(dir_obs)//'/HadGEM2-ES_PI_SEMMLER_detrend/PI_arctic_sic.txt',FORM='formatted')
open (57,FILE=TRIM(dir_obs)//'/MIROC-ESM_PI_SEMMLER_detrend/PI_arctic_sic.txt',FORM='formatted')
open (58,FILE=TRIM(dir_in)//'/PI_antarctic_sic.txt',&
FORM='formatted')
open (59,FILE=TRIM(dir_obs)//'/GFDL-CM3_PI_SEMMLER_detrend/PI_antarctic_sic.txt',FORM='formatted')
open (60,FILE=TRIM(dir_obs)//'/CCSM4_PI_SEMMLER_detrend/PI_antarctic_sic.txt',FORM='formatted')
open (61,FILE=TRIM(dir_obs)//'/ECHAM_MPIOM_LR_PI_SEMMLER_detrend/PI_antarctic_sic.txt',FORM='formatted')
open (62,FILE=TRIM(dir_obs)//'/HadGEM2-ES_PI_SEMMLER_detrend/PI_antarctic_sic.txt',FORM='formatted')
open (63,FILE=TRIM(dir_obs)//'/MIROC-ESM_PI_SEMMLER_detrend/PI_antarctic_sic.txt',FORM='formatted')

open (200,FILE=TRIM(dir_in)//'/PI_norm.txt',&
FORM='formatted')
open (201,FILE=TRIM(dir_in)//'/PI_tropics_norm.txt',&
FORM='formatted')
open (202,FILE=&
TRIM(dir_in)//'/PI_antarctic_norm.txt',&
FORM='formatted')
open (203,FILE=TRIM(dir_in)//'/PI_southmid_norm.txt',&
FORM='formatted')
open (204,FILE=TRIM(dir_in)//'/PI_arctic_norm.txt',&
FORM='formatted')
open (205,FILE=TRIM(dir_in)//'/PI_northmid_norm.txt',&
FORM='formatted')
open (206,FILE=TRIM(dir_in)//'/PI_innertr_norm.txt',&
FORM='formatted')

numfiles=nummodel*numregions
do l = 1,numfiles
! i: model, j: region
   i = mod((l-1),nummodel)+1
   j = ((l-1) / nummodel) +1
   do k = 1,numpi
      if ((i.ne.2).and.(i.ne.3)) then
         read (l+9,*) par(k),season(k),abs(k,i,j)
      else if (i.eq.2) then                                      ! GFDL no u300
         if (mod(k,8).eq.0) then
	    read (l+9,*) dummy
	    abs(k,i,j)=0.
	 else
	    read (l+9,*) par(k),season(k),abs(k,i,j)
	 endif
      else if (i.eq.3) then                                      ! CCSM4 no u10m, v10m
         if ((mod(k,8).eq.5).or.(mod(k,8).eq.6)) then
	    read (l+9,*) dummy
	    abs(k,i,j)=0.
	 else
	    read (l+9,*) par(k),season(k),abs(k,i,j)
	 endif
      endif
   enddo
enddo

! now the polar regions

do l = numfiles+1,numfiles+nummodel*numpolregions
! i: model, j: region
   i = mod((l-1),nummodel)+1
   j = ((l-1) / nummodel) +1
   if (j.eq.8) then                    ! Arctic
      j = 5
   else if (j.eq.9) then               ! Antarctic
      j = 3
   endif
   do k = numpi+1,numpi+numpolpi
      read (l+9,*) par(k),season(k),abs(k,i,j)
   enddo
enddo

meanabs(:,:)=0.

do i = 2,nummodel
   do j = 1,numregions
      if ((j.eq.3).or.(j.eq.5)) then ! for Antarctic and Arctic the sea ice parameters are available in addition
         do k = 1,numpi+numpolpi
            meanabs(k,j)=meanabs(k,j)+abs(k,i,j)
	 enddo
      else
         do k = 1,numpi
            meanabs(k,j)=meanabs(k,j)+abs(k,i,j)
	 enddo
      endif
   enddo
enddo

do j = 1,numregions
   do k = 1,numpi
      if ((mod(k,8).eq.0).or.(mod(k,8).eq.5).or.(mod(k,8).eq.6)) then   ! for these parameters one model less is available
         meanabs(k,j)=meanabs(k,j)/(nummodel-2)
      else
         meanabs(k,j)=meanabs(k,j)/(nummodel-1)
      endif
   enddo
   do k = numpi+1,numpi+numpolpi ! sea ice parameters
      meanabs(k,j)=meanabs(k,j)/(nummodel-1)
   enddo
enddo

do j = 1,numregions
   ecfesabsall(j)=0.
   if ((j.eq.3).or.(j.eq.5)) then ! for Antarctic and Arctic the sea ice parameters are available in addition
      do k = 1,numpi+numpolpi
         ecfesabs(k,j)=abs(k,1,j)/meanabs(k,j)
         ecfesabsall(j)=ecfesabsall(j)+ecfesabs(k,j)
         write(199+j,*) par(k),season(k),ecfesabs(k,j)
      enddo
      ecfesabsall(j)=ecfesabsall(j)/float(numpi+numpolpi)
      write(199+j,*) 'average:     ',ecfesabsall(j)
   else
      do k = 1,numpi
         ecfesabs(k,j)=abs(k,1,j)/meanabs(k,j)
         ecfesabsall(j)=ecfesabsall(j)+ecfesabs(k,j)
         write(199+j,*) par(k),season(k),ecfesabs(k,j)
      enddo
      ecfesabsall(j)=ecfesabsall(j)/float(numpi)
      write(199+j,*) 'average:     ',ecfesabsall(j)
   endif
enddo    

end program meanpi
