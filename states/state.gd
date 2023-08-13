class_name State extends Node

signal transition_to(new_state: NodePath)
signal transition_to_with_params(new_state: NodePath, params: Dictionary)

var actor: Node
var anim_tree: AnimationTree

func _ready():
	self.actor = owner
	self.set_process(false)
	self.set_physics_process(false)

func enter(_params: Dictionary = {}):
	self.set_process(true)
	self.set_physics_process(true)

func exit():
	self.set_process(false)
	self.set_physics_process(false)
