extends OLI_EVENT

# OVERRIDE
func handle(player):
	if player.is_in_group("detectable"):
		player.objective(self)
	