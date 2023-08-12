class_name JumpState extends State

signal landed

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var should_skid := false

func on_enter():
	super.on_enter()
	should_skid = actor.velocity.x != 0
	actor.velocity.y = actor.JUMP_VELOCITY

func _physics_process(delta):
	actor.velocity.y += gravity * delta
	
	actor.move_and_slide()
	
	if actor.is_on_floor():
		landed.emit()
