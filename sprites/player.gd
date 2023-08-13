class_name Player
extends CharacterBody2D

signal died

@onready var ladder_bottom_checker = $LadderBottomChecker as RayCast2D
@onready var ladder_top_checker = $LadderTopChecker as RayCast2D

@onready var state_machine = $StateMachine as StateMachine
@onready var anim_tree = $AnimationTree as AnimationTree
@onready var anim_playback = anim_tree["parameters/playback"] as AnimationNodeStateMachinePlayback

func _ready():
	for state in state_machine.states as Array[PlayerState]:
		state.ready_for_state_change.connect(transition_via_inputs)

func transition_via_inputs():
	# If nothing is pressed, we should idle
	if not Input.is_anything_pressed():
		state_machine.transition_to("Idle")
		return
	
	# Check for attempts to jump
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
		return
	
	# Check for attempts to run
	var x_axis = Input.get_axis("ui_left", "ui_right")
	if x_axis:
		state_machine.transition_to("Run")
		return
	
	# Check for attempts to climb
	var y_axis = Input.get_axis("ui_up", "ui_down")
	if y_axis == -1 and ladder_bottom_checker.is_colliding():
		move_to_centre_of_ladder(ladder_bottom_checker)
		state_machine.transition_to("Climb")
		return
	elif y_axis == 1 and ladder_top_checker.is_colliding():
		move_to_centre_of_ladder(ladder_top_checker)
		state_machine.transition_to("Climb")
		return
	elif y_axis:
		state_machine.transition_to("Idle")

# Moves Mario to line up with the ladder perfectly
func move_to_centre_of_ladder(checker: RayCast2D):
	var tile_map : TileMap = checker.get_collider()
	var rid = checker.get_collider_rid()
	var tile_coord = tile_map.get_coords_for_body_rid(rid)
	position.x = (tile_coord.x + 0.5) * tile_map.tile_set.tile_size.x + tile_map.position.x


func _on_enemy_collision(_body):
	state_machine.transition_to("Death")
	anim_playback.travel("Death")
	died.emit()
