class_name State extends Node

var actor: Node
var anim_tree: AnimationTree

func _ready():
	self.set_physics_process(false)

func on_enter():
	self.set_physics_process(true)

func on_exit():
	self.set_physics_process(false)
