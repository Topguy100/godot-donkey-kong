class_name IdleState extends State

signal input_pressed

func on_enter():
	super.on_enter()
	actor.velocity = Vector2.ZERO

func _physics_process(_delta):
	if Input.is_anything_pressed():
		self.input_pressed.emit()
