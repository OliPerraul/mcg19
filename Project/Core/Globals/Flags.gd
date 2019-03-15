extends Node


func set_flags(flags, target, off): 
	if off : 
		target &= ~flags
	else :
		target |= flags
		
	return flags

func test_flags(target, flags):
	target & flags == flags
