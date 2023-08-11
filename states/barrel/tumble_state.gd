class_name TumbleState extends State

@export var ladder_bottom_checker: RayCast2D
@export var platform_below_checker: RayCast2D

signal tumbled_to_bottom_of_ladder

func on_enter():
	super.on_enter()
	actor.set_collision_mask_value(2, false)
	actor.velocity = Vector2.ZERO

func on_exit():
	super.on_exit()
	actor.set_collision_mask_value(2, true)
	actor.direction *= -1

func _process(delta):
	anim_tree.set("parameters/TimeScale/scale", 1)

func _physics_process(_delta):
	actor.velocity = Vector2(0, actor.SPEED)
	
	actor.move_and_slide()
	
	if self.platform_below_checker.is_colliding() and self.ladder_bottom_checker.is_colliding():
		tumbled_to_bottom_of_ladder.emit()
	
