extends Node

var _game_world_scene = load("res://Common/Scenes/GameWorld.tscn")


var _active_scene = null

func _ready():
	load_game_world()

func load_game_world():
	_clean_active_scene()
		
	_active_scene = _game_world_scene.instance()
	add_child(_active_scene)

func _clean_active_scene():
	if(_active_scene != null):
		_active_scene.clean_scene()
		_active_scene.queue_free()
		_active_scene = null
