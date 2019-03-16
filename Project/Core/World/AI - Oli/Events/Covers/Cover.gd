extends OLI_EVENT

# OVERRIDE
func handle(player):
	if player.is_in_group("detectable"):
		player.cover = self
		player.character_state = "enable_hide"
		player.remove_from_group("detectable")
	