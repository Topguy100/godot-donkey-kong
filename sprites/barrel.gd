class_name Barrel
extends CharacterBody2D

const SPEED = 175.0
enum BarrelType { REGULAR = 0, EXPLOSIVE }

@export var direction := 1
@export var explosive_chance := 0.1
@export var tumble_chance := 0.3

var barrel_type: BarrelType

@onready var sprites = $Sprite2D as Sprite2D
@onready var anim_tree = $AnimationTree as AnimationTree
@onready var state_machine = $StateMachine as StateMachine

func _init():
	barrel_type = BarrelType.REGULAR if randf() > explosive_chance else BarrelType.EXPLOSIVE

func _ready():
	var texture_name = BarrelType.keys()[barrel_type].to_camel_case()
	sprites.texture = load("res://assets/objects/" + texture_name + " Barrel.png")
	
	anim_tree.active = true

func set_pose(new_pose: StringName):
	anim_tree[state_machine.anim_playback_path].travel(new_pose)
