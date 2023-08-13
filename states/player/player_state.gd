class_name PlayerState extends State

signal ready_for_state_change

var player: Player

func _ready():
	super._ready()
	player = owner as Player
	assert(player)
