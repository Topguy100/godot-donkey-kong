class_name StateMachine extends Node

@export var actor: Node
@export var anim_tree: AnimationTree
@export var initial_state: State

var states: Array[State] = []
var state: State

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if not child is State:
			continue
		
		child.actor = self.actor
		child.anim_tree = self.anim_tree
		self.states.append(child)
	
	if self.initial_state:
		self.change_state(self.initial_state)

func change_state(new_state: State):
	if new_state not in self.states:
		return

	if self.state:
		self.state.on_exit()

	self.state = new_state
	self.state.on_enter()
