extends Node2D

@onready var mario = $Mario as Mario
@onready var barrels_group = $Barrels as Node2D
@onready var donkey_kong = $"Donkey Kong"

func _ready():
	mario.died.connect(mario_died)

func mario_died():
	donkey_kong.get_node("AnimationPlayer").pause()
	for barrel in barrels_group.get_children() as Array[Barrel]:
		barrel.state_machine.transition_to("Freeze")
