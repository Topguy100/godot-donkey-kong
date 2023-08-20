extends Node2D

@onready var mario = $Mario as Mario
@onready var oil_barrel = $"Oil Barrel" as Sprite2D

func _ready():
	mario.died.connect(mario_died)

func mario_died():
	for node in get_tree().get_nodes_in_group("freezable"):
		node.freeze(true)
