@echo off

doskey ls=ls -hFpG --color=auto $*
doskey la=ls -hFpGA --color=auto $*
doskey lal=ls -hFpGAl --color=auto $*
doskey ll=ls -hFpGl --color=auto $*
doskey cd=cd /D $*
doskey cd..=cd ..
doskey ..=cd ..
doskey ...=cd ../../
doskey ....=cd ../../../
doskey .....=cd ../../../../
doskey ......=cd ../../../../../
doskey .......=cd ../../../../../../
doskey .4=cd ../../../../
doskey .5=cd ../../../../../
doskey .6=cd ../../../../../../
doskey .7=cd ../../../../../../../
doskey d=docker $*
doskey dc=docker-compose $*

