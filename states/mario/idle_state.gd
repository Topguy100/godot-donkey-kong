extends MarioState

func enter(params: Dictionary = {}):
	super.enter(params)
	mario.velocity = Vector2.ZERO

func _physics_process(_delta):
	ready_for_state_change.emit()
