extends Area2D

onready var ScrollingWalls = get_parent().get_node("ScrollingWalls")
onready var PlatformManager = get_parent().get_node("PlatformManager")



func _on_WallDespawner_area_entered(area):
	if(area.get_parent().is_in_group("Wall")):
		ScrollingWalls.remove_wall(area.get_parent())
	
	if(area.get_parent().is_in_group("Platform")):
		PlatformManager.remove_platform(area.get_parent().get_parent())
