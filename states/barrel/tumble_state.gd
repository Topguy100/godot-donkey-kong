extends State

@export var ladder_bottom_checker: RayCast2D
@export var platform_below_checker: RayCast2D

func enter(params: Dictionary = {}):
	super.enter(params)
	actor.set_collision_mask_value(2, false)
	actor.velocity = Vector2.ZERO
	anim_playback.travel("Tumbling")

func exit():
	super.exit()
	actor.set_collision_mask_value(2, true)
	actor.direction *= -1

func _process(_delta):
	anim_tree.set("parameters/TimeScale/scale", 1)

func _physics_process(_delta):
	actor.velocity = Vector2(0, actor.SPEED)
	
	actor.move_and_slide()
	
	if self.platform_below_checker.is_colliding() and self.ladder_bottom_checker.is_colliding():
		transition_to.emit("Roll")
	
