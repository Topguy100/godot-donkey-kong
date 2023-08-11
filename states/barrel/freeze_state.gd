class_name FreezeState extends State

func on_enter():
	super.on_enter()
	anim_tree.active = false
	
func on_exit():
	super.on_exit()
	anim_tree.active = true
