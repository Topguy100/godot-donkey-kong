extends MarioState

func enter(params: Dictionary = {}):
	super.enter(params)
	mario.velocity = Vector2.ZERO
