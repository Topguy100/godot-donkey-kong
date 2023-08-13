class_name StateMachine extends Node

signal transitioned(state_name: StringName)

@export var anim_tree: AnimationTree
@export var anim_playback_path: StringName
@export var initial_state := NodePath()

var states: Array[State] = []
@onready var state: State

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		var child_state = child as State
		if not child_state:
			continue
		
		child_state.anim_tree = anim_tree
		child_state.anim_playback = anim_tree[anim_playback_path]
		child_state.transition_to.connect(transition_to)
		child_state.transition_to_with_params.connect(transition_to)
		states.append(child_state)
	
	# Enter the initial state
	state = get_node(initial_state)
	state.enter()

func state_with_path(state_path: NodePath) -> State:
	if not has_node(state_path):
		return null

	return get_node(state_path) as State

func transition_to(state_path: NodePath, params: Dictionary = {}):
	var new_state = state_with_path(state_path)
	if not new_state or state == new_state:
		return
	
	state.exit()
	state = new_state
	state.enter(params)
	transitioned.emit(state.name)
