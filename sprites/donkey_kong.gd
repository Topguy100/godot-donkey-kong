extends Sprite2D

var barrel_scene := preload("res://sprites/Barrel.tscn")
var new_barrel: Barrel

@onready var barrels_group = owner.get_node("Barrels")
@onready var barrel_spawn_point = $BarrelSpawnPoint as Marker2D
@onready var barrel_move_point = $BarrelMovePoint as Marker2D

func spawn_barrel():
	new_barrel = barrel_scene.instantiate()
	barrels_group.add_child(new_barrel)
	new_barrel.position = barrels_group.to_local(barrel_spawn_point.global_position)
	new_barrel.set_pose("Tumbling")

func move_barrel():
	new_barrel.position = barrels_group.to_local(barrel_move_point.global_position)
	new_barrel.set_pose("Rolling")
	
func launch_barrel():
	new_barrel.state_machine.transition_to("Roll")
