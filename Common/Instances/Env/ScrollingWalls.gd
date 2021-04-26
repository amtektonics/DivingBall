extends Node2D

export var max_tiles = 200

onready var _left_spawner = $LeftWall
onready var _right_spawner = $RightWall

var _last_left_tile = null
var _last_right_tile = null

onready var GameWorld = get_parent()

var wall_tile = load("res://Common/Instances/Misc/Wall.tscn")

var _walls = []

var tile_count = 0

var stopped = false

var _scroll_speed = 0


func _physics_process(delta):
	if(!stopped):
		if(tile_count < max_tiles):
			_spawn_left_wall(_left_spawner.get_position())
			_spawn_right_wall(_right_spawner.get_position())

func start():
	stopped = false
	for w in _walls:
		w.moving = true

func stop():
	stopped = true
	for w in _walls:
		w.moving = false

func reset():
	var tempwalls = _walls.duplicate(true)
	for w in tempwalls:
		remove_wall(w)
	populate_walls()

func populate_walls():
	for i in range(max_tiles / 2):
		if(_last_left_tile == null):
			_spawn_left_wall(Vector2(_left_spawner.get_position().x, -960))
		else:
			_spawn_left_wall(Vector2())
		
		if(_last_right_tile == null):
			_spawn_right_wall(Vector2(_right_spawner.get_position().x, -960))
		else:
			_spawn_right_wall(Vector2())


func _spawn_left_wall(pos:Vector2):
	var left_next = wall_tile.instance()
	left_next.left_wall = true
	left_next.moving = true
	left_next.move_speed = _scroll_speed
	if(_last_left_tile == null):
		left_next.set_position(pos)
	else:
		var l_pos = _last_left_tile.get_position()
		left_next.set_position(Vector2(l_pos.x, l_pos.y + 64))
		left_next.follow_tile = _last_left_tile

	add_child(left_next)
	_last_left_tile = left_next
	_walls.append(left_next)
	tile_count += 1

func _spawn_right_wall(pos:Vector2):
	var right_next = wall_tile.instance()
	right_next.moving = true
	right_next.move_speed = _scroll_speed
	if(_last_right_tile == null):
		right_next.set_position(pos)
	else:
		var l_pos = _last_right_tile.get_position()
		right_next.set_position(Vector2(l_pos.x, l_pos.y + 64))
		right_next.follow_tile =_last_right_tile
	
	add_child(right_next)
	_last_right_tile = right_next
	tile_count += 1
	_walls.append(right_next)


func remove_wall(node:Node):
	if(_walls.has(node)):
		node.queue_free()
		_walls.erase(node)
		tile_count -= 1


func is_stopped():
	return stopped

func update_scroll_speed(new_speed:float):
	_scroll_speed = new_speed
	for w in _walls:
		w.move_speed = new_speed
