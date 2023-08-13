extends PlayerState

func enter(params: Dictionary = {}):
	super.enter(params)
	player.velocity = Vector2.ZERO
