extends State

func enter(params: Dictionary = {}):
	super.enter(params)
	anim_tree.set("parameters/TimeScale/scale", 0)
	
func exit():
	super.exit()
	anim_tree.set("parameters/TimeScale/scale", 1)

func set_pose(pose_name: StringName):
	anim_playback.travel(pose_name)
