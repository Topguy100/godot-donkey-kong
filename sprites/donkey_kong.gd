extends Sprite2D

var barrel_scene := preload("res://sprites/barrel.tscn")
var new_barrel: Barrel

@export var barrels_group : Node
@onready var anim_barrel = $Barrel as Sprite2D
@onready var anim_player = $AnimationPlayer as AnimationPlayer

func throw_barrel():
	new_barrel = barrel_scene.instantiate()
	match new_barrel.type:
		Barrel.Type.REGULAR:
			anim_player.play("throw_regular_barrel")
		Barrel.Type.EXPLOSIVE:
			anim_player.play("throw_explosive_barrel")

func launch_barrel():
	barrels_group.add_child(new_barrel)
	new_barrel.global_position = anim_barrel.global_position
	new_barrel.state_machine.transition_to("Roll")

func _on_timer_timeout():
	throw_barrel()
