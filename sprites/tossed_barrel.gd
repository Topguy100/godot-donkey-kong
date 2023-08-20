extends PathFollow2D

@export var speed = 150

@onready var barrel_animation = $ExplosiveBarrel/AnimatedSprite2D

var frozen = false

func _physics_process(delta):
	if frozen:
		return

	progress += speed * delta

	if position.x < 0:
		barrel_animation.play("roll_left")

func freeze(should_freeze: bool):
	frozen = should_freeze

	if frozen:
		barrel_animation.pause()
	else:
		barrel_animation.play()

func _on_explosive_barrel_tree_exiting():
	owner.queue_free()
