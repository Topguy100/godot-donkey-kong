extends MarioState

const SPEED = 130.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter(params: Dictionary = {}):
	super.enter(params)

func _process(_delta):
	var x_axis = Input.get_axis("ui_left", "ui_right")
	anim_tree["parameters/Death/blend_position"] = x_axis
	anim_tree["parameters/Idle/blend_position"] = x_axis
	anim_tree["parameters/Jump/blend_position"] = x_axis
	anim_tree["parameters/Run/blend_position"] = x_axis
	anim_tree["parameters/Skid/blend_position"] = x_axis

func _physics_process(delta):
	var x_axis = Input.get_axis("left", "right")
	mario.velocity.x = x_axis * SPEED
	mario.velocity.y += gravity * delta

	mario.move_and_slide()

	ready_for_state_change.emit()
