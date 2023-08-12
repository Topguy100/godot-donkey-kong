class_name RunState extends State

signal finished_running
signal input_pressed

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func on_enter():
	super.on_enter()

func _process(_delta):
	var x_axis = Input.get_axis("ui_left", "ui_right")
	anim_tree["parameters/Death/blend_position"] = x_axis
	anim_tree["parameters/Idle/blend_position"] = x_axis
	anim_tree["parameters/Jump/blend_position"] = x_axis
	anim_tree["parameters/Run/blend_position"] = x_axis
	anim_tree["parameters/Skid/blend_position"] = x_axis

func _physics_process(delta):
	var x_axis = Input.get_axis("ui_left", "ui_right")
	actor.velocity.x = x_axis * actor.SPEED
	actor.velocity.y += gravity * delta
	
	actor.move_and_slide()
	
	if Input.is_anything_pressed():
		input_pressed.emit()
	
	if x_axis == 0:
		finished_running.emit()
