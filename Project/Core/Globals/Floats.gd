
extends Node


const SIGNIFICANT_FIGURES = 5

static func approximate(val, significant_figures = SIGNIFICANT_FIGURES):
	var coeff = pow(10, significant_figures-1)
	val *= coeff
	val = int(val)
	val /= coeff
	return val


static func zero_sign(val):
	return int(sign(val)*int(bool(val)))
	


static func smaller(a, b, significant_figures = SIGNIFICANT_FIGURES):
    return approximate(a, significant_figures) < approximate(b, significant_figures)	
	
