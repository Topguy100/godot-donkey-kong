class_name ClimbState extends State

signal input_pressed

@export var platform_checker: RayCast2D
@export var ladder_top_checker: RayCast2D
@export var ladder_bottom_checker: RayCast2D

var at_end_of_ladder := false

func on_enter():
	super.on_enter()
	
	# Stop checking for platform collisions while climbing
	actor.set_collision_mask_value(2, false)
	
	# Turn off horizontal movement
	actor.velocity.x = 0
	
func on_exit():
	super.on_exit()
	
	# Resume checking for platform collisions
	actor.set_collision_mask_value(2, true)

func _process(_delta):
	anim_tree["parameters/Climb/TimeScale/scale"] = actor.velocity.y != 0

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
		actor.velocity.y = y_axis * actor.SPEED
	else:
		actor.velocity.y = 0
	
	actor.move_and_slide()

	if at_end_of_ladder and Input.is_anything_pressed():
		input_pressed.emit()
