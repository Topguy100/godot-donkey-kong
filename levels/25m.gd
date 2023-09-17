extends Node2D

@onready var background_music = $"Audio/Background Music" as AudioStreamPlayer
@onready var mario = $Mario as Mario
@onready var oil_barrel = $"Oil Barrel" as Sprite2D

func _ready():
	mario.died.connect(mario_died)

func mario_died():
	background_music.stop()
	for node in get_tree().get_nodes_in_group("freezable"):
		node.freeze(true)

func _on_win_location_body_entered(body):
	print("You won!")
