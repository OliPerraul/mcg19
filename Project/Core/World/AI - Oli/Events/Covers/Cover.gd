extends OLI_EVENT

# OVERRIDE
func handle(player):
	if player.is_in_group("detectable"):
		player.init_state('enable_hide', [self])
		#player.remove_from_group("detectable")
				
		t_scale = Vector2.ONE*max_scale

# ABSTR
func _on_body_entered(b):
	if b.is_in_group("detectable"):
		b.init_state('enable_hide', [self])


# ABSTR
func _on_body_exited(b):
	if b.is_in_group("detectable"):
		b.init_state('normal', [self])
