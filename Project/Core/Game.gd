extends Node

export(PackedScene) onready var _gameover_scene

export(NodePath) onready var __tm_solids
onready var tm_solids

export(NodePath) onready var __foreground
onready var foreground

export(NodePath) onready var __player
onready var player

export(NodePath) onready var __score_label
onready var _score_label

export(NodePath) onready var __alert_label
onready var _alert_label


export(NodePath) onready var __goals
onready var goals

var time_goal = 0
export(float) onready var time_goal_limit = 5


var _score_format = 'Score: $$'
var _alert_format = 'Alert: $$/@@'

var old_alert = 0 
var alert = 0
var time_no_alert = 0
export(float) onready var alert_decr = .5
export(float) onready var time_no_alert_limit = 4
export(float) onready var time_no_alert_limit_incr = .5

export(float) onready var _alert_limit = 200
export(float) onready var _alert_limit_min = 50
func update_alert(val):
	old_alert = alert
	alert = val
	alert = clamp(alert, _alert_limit_min, INF) 

var score = 0
export(float) onready var _score_alert_raise_perc = .5

# increase the difficulty curve as score increases
func update_score(val):
	self.alert +=  _score_alert_raise_perc*val
	self.time_no_alert_limit += time_no_alert_limit_incr
	score = val

func _ready():
	tm_solids = get_node(__tm_solids)
	player = get_node(__player)
	Globals.game = self
	_alert_label = get_node(__alert_label)
	_score_label = get_node(__score_label)	
	foreground = get_node(__foreground)	
	goals = get_node(__goals)
	
	
	
		
func _process(delta):
	if alert >= _alert_limit :
		end_game()
		
	elif alert > (old_alert + .02) or alert > (old_alert - .02):
		time_no_alert = 0
		
	elif alert <= (old_alert + .02) or alert <= (old_alert - .02):
		time_no_alert += delta
		
		# start decreasing the alert
		if time_no_alert >= time_no_alert_limit:
			alert -= alert_decr
			if(alert < 0):
				alert = 0
								
	_score_label.text = _score_format.replace('$$', self.score)
	_alert_label.text = _alert_format.replace('$$', self.alert).replace('@@', self._alert_limit)			


	time_goal += delta
	if time_goal >= time_goal_limit:
		pass

	
	
	
func end_game():
	get_tree().change_scene("res://Core/Start/GameOverScreen.tscn")
		
	
	
	
	