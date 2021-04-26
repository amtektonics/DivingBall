extends Node2D


onready var _left_wall = $LeftWall
onready var _right_wall = $RightWall

onready var GameWorld = get_parent()

var stopped = false

var _scroll_speed = 0


func _physics_process(delta):
	if(!stopped):
			_left_wall.get_node("Sprite").region_rect.position.y += _scroll_speed * delta
			if(_left_wall.get_node("Sprite").region_rect.position.y > 1792):
				_left_wall.get_node("Sprite").region_rect.position.y -= 1792
			
			_right_wall.get_node("Sprite").region_rect.position.y += _scroll_speed * delta
			if(_right_wall.get_node("Sprite").region_rect.position.y > 1792):
				_right_wall.get_node("Sprite").region_rect.position.y -= 1792

func start():
	stopped = false

func stop():
	stopped = true



#func _spawn_left_wall(pos:Vector2):
#	var left_next = wall_tile.instance()
#	left_next.left_wall = true
#	left_next.moving = true
#	left_next.move_speed = _scroll_speed
#	if(_last_left_tile == null):
#		left_next.set_position(pos)
#	else:
#		var l_pos = _last_left_tile.get_position()
#		left_next.set_position(Vector2(l_pos.x, l_pos.y + 64))
#		left_next.follow_tile = _last_left_tile
#
#	add_child(left_next)
#	_last_left_tile = left_next
#	_walls.append(left_next)
#	tile_count += 1
#
#func _spawn_right_wall(pos:Vector2):
#	var right_next = wall_tile.instance()
#	right_next.moving = true
#	right_next.move_speed = _scroll_speed
#	if(_last_right_tile == null):
#		right_next.set_position(pos)
#	else:
#		var l_pos = _last_right_tile.get_position()
#		right_next.set_position(Vector2(l_pos.x, l_pos.y + 64))
#		right_next.follow_tile =_last_right_tile
#
#	add_child(right_next)
#	_last_right_tile = right_next
#	tile_count += 1
#	_walls.append(right_next)
#

#func remove_wall(node:Node):
#	if(_walls.has(node)):
#		node.queue_free()
#		_walls.erase(node)
#		tile_count -= 1
#

func is_stopped():
	return stopped

func update_scroll_speed(new_speed:float):
	_scroll_speed = new_speed
