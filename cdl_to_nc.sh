#!/bin/bash

file=SS_model;
ncgen -o $file.nc $file.cdl
#ncdump $file.nc > ${file}2.cdl

file=T_model;
ncgen -o $file.nc $file.cdl

file=S_model;
ncgen -o $file.nc $file.cdl

