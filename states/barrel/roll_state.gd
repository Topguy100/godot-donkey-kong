class_name RollState extends State

@export var platform_checkers_group_name: String
@export var ladder_top_checker: RayCast2D

var ACCEL_X = 1000

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var over_ladder = false

signal rolled_off_platform
signal rolled_over_ladder_top

func on_enter():
	super.on_enter()
	actor.velocity = Vector2(actor.direction * actor.SPEED, 0)

func _physics_process(delta):
	actor.velocity.x = move_toward(actor.velocity.x, actor.SPEED * actor.direction, ACCEL_X * delta)
	actor.velocity.y += gravity * delta
	
	actor.move_and_slide()

	check_for_freefall()
	check_for_ladder_top()

func check_for_freefall():
	for detector in get_tree().get_nodes_in_group(platform_checkers_group_name) as Array[RayCast2D]:
		if detector.is_colliding():
			return
	
	rolled_off_platform.emit()

func check_for_ladder_top():
	if ladder_top_checker.is_colliding() and not over_ladder:
		rolled_over_ladder_top.emit(ladder_top_checker)
		
	over_ladder = ladder_top_checker.is_colliding()
