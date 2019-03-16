extends Node2D

export(String) var state
# STATES
#	idle
#	walking
#	afraid
#	danger
#	involuntary

onready var footprint

#TODO : CatchEventManager Signals



func _ready():
	call_deferred("_post_ready")

func _post_ready():
	footprint = preload("Footprint.tscn") # Will load when parsing the script.


