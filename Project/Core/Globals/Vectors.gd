extends Node

const UP = Vector2(0,-1)

const ZERO = Vector2(0,0)
const ONE = Vector2(1,1)
const ONE_X = Vector2(1,0)
const ONE_Y = Vector2(0,1)



func midpoint(v1, v2):
	return v1.linear_interpolate(v1, .5)
	