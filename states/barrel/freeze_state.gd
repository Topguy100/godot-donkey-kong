extends State

func enter(params: Dictionary = {}):
	super.enter(params)
	anim_tree.active = false
	
func exit():
	super.exit()
	anim_tree.active = true
