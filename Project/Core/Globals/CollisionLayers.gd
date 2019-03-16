extends Node

"""
0x80 : 10000000
0x40 : 01000000
0x20 : 00100000
0x10 : 00010000
0x08 : 00001000
0x04 : 00000100
0x02 : 00000010
0x01 : 00000001

"""

const DEFAULT =  0x01
const SOLIDS =  0x02
const TILES =  0x04
const HAZARDS =  0x08
const TRIGGERS =  0x10
const CHARACTERS = 0x20
const PLAYER = 0x40
const UNKNOWN = 0x80


func set_mask_all(collision_object, off) :
	pass

	"""
	var flags
	if off : 
		flags = 0x00000000
	else : 
		flags = 0xFFFFFFFF
		
	collision_object.set_collison_mask_bit(flags)
	"""