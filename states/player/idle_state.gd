extends PlayerState

func enter(params: Dictionary = {}):
	super.enter(params)
	player.velocity = Vector2.ZERO

func _physics_process(_delta):
	ready_for_state_change.emit()
