class_name MarioState extends State

signal ready_for_state_change

var mario: Mario

func _ready():
	super._ready()
	mario = owner as Mario
	assert(mario)
