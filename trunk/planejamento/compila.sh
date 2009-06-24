#!/bin/sh
latex projeto-de-formatura.tex && dvips projeto-de-formatura.dvi  && GS_OPTIONS=-dAutoRotatePages=/None ps2pdf projeto-de-formatura.ps 
