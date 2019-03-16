extends OLI_EVENT

# OVERRIDE
func handle(player):
	if player.is_in_group("detectable"):
		player.player_hide(self)
	