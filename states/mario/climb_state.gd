extends MarioState

const SPEED = 130.0

@export var platform_checker: RayCast2D
@export var ladder_top_checker: RayCast2D
@export var ladder_bottom_checker: RayCast2D

var at_end_of_ladder := false

func enter(params: Dictionary = {}):
	super.enter(params)

	# Stop checking for platform collisions while climbing
	mario.set_collision_mask_value(2, false)

	# Turn off horizontal movement
	mario.velocity.x = 0

func exit():
	super.exit()

	# Resume checking for platform collisions
	mario.set_collision_mask_value(2, true)

func _process(_delta):
	anim_tree["parameters/Climb/TimeScale/scale"] = mario.velocity.y != 0

func _physics_process(_delta):
	at_end_of_ladder = (
		platform_checker.is_colliding() and
		(ladder_bottom_checker.is_colliding() or ladder_top_checker.is_colliding())
	)

	# Get the state of the up and down keys
	var y_axis = Input.get_axis("up", "down")
	if ((y_axis == -1 and not ladder_top_checker.is_colliding()) or
		(y_axis == 1 and not ladder_bottom_checker.is_colliding())
	):
		mario.velocity.y = y_axis * SPEED
	else:
		mario.velocity.y = 0

	mario.move_and_slide()

	if at_end_of_ladder:
		ready_for_state_change.emit()
