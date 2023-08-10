class_name FallState extends State

var ACCEL_X = 1000

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

signal fell_to_floor

func _physics_process(delta):
	actor.velocity.x = move_toward(actor.velocity.x, actor.SPEED * actor.direction * 0.3, ACCEL_X * delta)
	actor.velocity.y += gravity * delta
		
	actor.move_and_slide()
	
	if actor.is_on_floor():
		fell_to_floor.emit()
