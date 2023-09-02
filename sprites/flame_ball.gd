extends Node2D

@export var speed = 100

@onready var path_follow = $"Initial Path/Path Follow"

enum State {
	LEAP,
	FOLLOW_PATH,
}

var _state = State.LEAP

func _physics_process(delta):
	match _state:
		State.LEAP:
			path_follow.progress += speed * delta
			if path_follow.progress_ratio == 1:
				z_index = 20
				_state = State.FOLLOW_PATH
		State.FOLLOW_PATH:
			pass
