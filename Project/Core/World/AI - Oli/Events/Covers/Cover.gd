extends OLI_EVENT

# ABSTR
func _on_body_entered(b):
	if b.is_in_group("detectable"):
		b.init_state('enable_hide', [self])


# ABSTR
func _on_body_exited(b):
	if b.is_in_group("detectable"):
		b.init_state('normal', [self])
