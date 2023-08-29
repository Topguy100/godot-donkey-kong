extends Sprite2D

@onready var anim_player = $AnimationPlayer as AnimationPlayer
@onready var call_for_help_timer = $"Call For Help Timer" as Timer

func _on_call_for_help_timer_timeout():
	anim_player.play("call_for_help")
	await anim_player.animation_finished
	anim_player.play("RESET")

func freeze(should_freeze):
	if should_freeze:
		call_for_help_timer.paused = true
		anim_player.pause()
	else:
		call_for_help_timer.paused = false
		anim_player.play()
