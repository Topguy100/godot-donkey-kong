extends PlayerState

const SPEED = 130.0

@export var platform_checker: RayCast2D
@export var ladder_top_checker: RayCast2D
@export var ladder_bottom_checker: RayCast2D

var at_end_of_ladder := false

func enter(params: Dictionary = {}):
	super.enter(params)
	
	# Stop checking for platform collisions while climbing
	player.set_collision_mask_value(2, false)
	
	# Turn off horizontal movement
	player.velocity.x = 0
	
func exit():
	super.exit()
	
	# Resume checking for platform collisions
	player.set_collision_mask_value(2, true)

func _process(_delta):
	anim_tree["parameters/Climb/TimeScale/scale"] = player.velocity.y != 0

func _physics_process(_delta):
	at_end_of_ladder = (
		platform_checker.is_colliding() and
		(ladder_bottom_checker.is_colliding() or ladder_top_checker.is_colliding())
	)
	
	# Get the state of the up and down keys
	var y_axis = Input.get_axis("ui_up", "ui_down")
	if ((y_axis == -1 and not ladder_top_checker.is_colliding()) or
		(y_axis == 1 and not ladder_bottom_checker.is_colliding())
	):
		player.velocity.y = y_axis * SPEED
	else:
		player.velocity.y = 0
	
	player.move_and_slide()

	if at_end_of_ladder:
		ready_for_state_change.emit()
