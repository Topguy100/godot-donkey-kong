extends Node2D

@export var navigate_speed = 30
@export var target_node: Node2D
@export var target_max_distance = 100.0

@onready var animatable_body = $AnimatableBody2D as AnimatableBody2D
@onready var animated_sprite = $AnimatableBody2D/AnimatedSprite2D as AnimatedSprite2D
@onready var anim_player = $AnimatableBody2D/AnimationPlayer as AnimationPlayer
@onready var navigation_agent = $NavigationAgent2D as NavigationAgent2D
@onready var refresh_target_timer = $RefreshTargetTimer as Timer

var unfrozen_state: FlameBallState

enum FlameBallState {
	FROZEN,
	LEAP,
	FOLLOW_PATH,
}

var _state = FlameBallState.LEAP

func _physics_process(delta):
	match _state:
		FlameBallState.LEAP:
			animatable_body.move_and_collide(Vector2.ZERO)
		FlameBallState.FOLLOW_PATH:
			var next_dir = to_local(
				navigation_agent.get_next_path_position()
			).normalized()
			if next_dir.x > 0:
				anim_player.play("bounce_right")
			else:
				anim_player.play("bounce_left")
			global_position = global_position.move_toward(
				global_position + next_dir,
				navigate_speed * delta
			)
			animatable_body.move_and_collide(Vector2.ZERO)
			if navigation_agent.is_navigation_finished():
				renew_target()

func start_following_paths():
	renew_target()
	_state = FlameBallState.FOLLOW_PATH
	animatable_body.position = Vector2.ZERO

func renew_target():
	navigation_agent.target_position = target_node.global_position + Vector2(
		randi_range(-target_max_distance, target_max_distance),
		randi_range(-target_max_distance, target_max_distance)
	)
	refresh_target_timer.start()

func freeze(should_freeze: bool):
	if should_freeze:
		unfrozen_state = _state
		_state = FlameBallState.FROZEN
		animated_sprite.pause()
		anim_player.pause()
		refresh_target_timer.paused = true
	else:
		_state = unfrozen_state
		animated_sprite.play()
		anim_player.play()
		refresh_target_timer.paused = false

func _on_refresh_target_timer_timeout():
	renew_target()
