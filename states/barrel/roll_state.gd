extends State

@export var platform_detectors: Array[RayCast2D]
@export var ladder_top_checker: RayCast2D

const ACCEL_X = 1000

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var over_ladder = false

func enter(params: Dictionary = {}):
	super.enter(params)
	actor.velocity = Vector2(actor.direction * actor.SPEED, 0)
	anim_playback.travel("Rolling")

func _process(_delta):
	anim_tree.set("parameters/StateMachine/Rolling/blend_position", actor.velocity.x)
	anim_tree.set("parameters/TimeScale/scale", absf(actor.velocity.x / actor.SPEED))

func _physics_process(delta):
	actor.velocity.x = move_toward(actor.velocity.x, actor.SPEED * actor.direction, ACCEL_X * delta)
	actor.velocity.y += gravity * delta

	actor.move_and_slide()

	check_for_freefall()
	check_for_ladder_top()

func check_for_freefall():
	for detector in platform_detectors:
		if detector.is_colliding():
			return

	transition_to.emit("Fall")

func check_for_ladder_top():
	if ladder_top_checker.is_colliding() and not over_ladder and randf() <= actor.tumble_chance:
		move_to_centre_of_ladder()
		transition_to.emit("Tumble")

	over_ladder = ladder_top_checker.is_colliding()

func move_to_centre_of_ladder():
	var tile_map : TileMap = ladder_top_checker.get_collider()
	var rid = ladder_top_checker.get_collider_rid()
	var tile_coord = tile_map.get_coords_for_body_rid(rid)
	actor.position.x = (tile_coord.x + 0.5) * tile_map.tile_set.tile_size.x + tile_map.position.x
