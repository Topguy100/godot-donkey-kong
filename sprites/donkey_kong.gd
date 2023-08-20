class_name DonkeyKong
extends Sprite2D

var barrel_scene := preload("res://sprites/barrel.tscn")
var tossed_barrel_scene := preload("res://sprites/tossed_barrel.tscn")

var new_barrel: Barrel
var new_tossed_barrel: Path2D

@export var barrels_group : Node
@onready var anim_barrel = $Barrel as Sprite2D
@onready var anim_player = $AnimationPlayer as AnimationPlayer
@onready var throw_timer = $ThrowIntervalTimer as Timer

func _ready():
	toss_barrel()

func throw_barrel():
	new_barrel = barrel_scene.instantiate()
	match new_barrel.type:
		Barrel.Type.REGULAR:
			anim_player.play("throw_regular_barrel")
		Barrel.Type.EXPLOSIVE:
			anim_player.play("throw_explosive_barrel")

func launch_thrown_barrel():
	barrels_group.add_child(new_barrel)
	new_barrel.global_position = anim_barrel.global_position
	new_barrel.state_machine.transition_to("Roll")

func toss_barrel():
	new_tossed_barrel = tossed_barrel_scene.instantiate()
	anim_player.play("toss_explosive_barrel")

func launch_tossed_barrel():
	new_tossed_barrel.global_position = anim_barrel.global_position
	barrels_group.add_child(new_tossed_barrel)

func _on_timer_timeout():
	throw_barrel()

func freeze(should_freeze: bool):
	if should_freeze:
		throw_timer.paused = true
		anim_player.pause()
	else:
		throw_timer.paused = false
		anim_player.play()
