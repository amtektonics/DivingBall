extends Node2D

export var max_platforms = 60

onready var GameWorld = get_parent()

var platforms = []

var _scroll_speed = 0.0

var _playform_scene = load("res://Common/Instances/Misc/Platform.tscn")

var platform_count = 0

var _stopped = false

var _left_spawn = true

var t = 0

var spawn_delay_primary = 3
var spawn_delay_secondary = 2

var current_spawn_delay_primary = spawn_delay_primary
var current_spawn_delay_secondary = spawn_delay_secondary

func _ready():
	randomize()

var _distance_trip_value = 250
func _physics_process(delta):
	if(!_stopped):
		if(platform_count < max_platforms):
			var primary_spawn = 0
			if(t % (60 * spawn_delay_primary) == 0):
				var width = (randi() % 4) + 1
				var height = (randi() % 3) + 1
								
				var pos = get_position()
				var xt = GameWorld.Player.get_position().x
				xt = int(xt / 64) * 64
				
				if(abs(xt) > 768):
					xt = xt + ((sign(-xt) * ((width / 2) * 64)) - 64)
				set_position(Vector2(xt, pos.y))
				
				spawn_platform(width, height, "n")
				
				primary_spawn = xt
			else:
				primary_spawn = GameWorld.Player.get_position().x
				primary_spawn = int(primary_spawn / 64) * 64
			
			if(t % (60 * spawn_delay_secondary) == 0):
				var width = (randi() % 4) + 1
				var height = (randi() % 3) + 1
				var pos = get_position()
				var xt = ((primary_spawn + 768) + (64 * (randi() % 20))) % 1536  - 768
				xt = int(xt / 64) * 64
				if(xt <= (-768 + (width * 64))):
					xt += ((width * 64) / 2)
					
				if(xt >= (768 - (width * 64))):
					xt -= ((width * 64) / 2)
				set_position(Vector2(xt, pos.y))
				spawn_platform(width, height, "r")
				_left_spawn = false
		t += 1

func start():
	_stopped = false
	for p in platforms:
		p.moving = true

func stop():
	_stopped = true
	for p in platforms:
		p.moving = false

func reset():
	var temp_plat = platforms.duplicate(true)
	for p in temp_plat:
		remove_platform(p)
	t = 0
	current_spawn_delay_primary = spawn_delay_primary
	current_spawn_delay_secondary = spawn_delay_secondary

func spawn_platform(width:int, height:int, type:String):
	var platform = _playform_scene.instance()
	platform.add_tiles(width, height)
	platform.move_speed = _scroll_speed
	platform.moving = true
	platform.set_position(get_position())
	platform.set_name("platform_"+ type)
	get_parent().add_child(platform)
	platforms.append(platform)
	platform_count += 1

func remove_platform(node:Node):
	if(platforms.has(node)):
		node.queue_free()
		platforms.erase(node)
		platform_count -= 1

func update_scroll_speed(new_speed:float):
	_scroll_speed = new_speed
	for p in platforms:
		p.move_speed = new_speed
