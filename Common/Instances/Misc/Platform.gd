extends Node2D

export var platform_texture:Texture

var platform_width = 0
var platform_height = 0

var moving = false

var move_speed = 0

var tile_scene = load("res://Common/Instances/Misc/PlatformTile.tscn")

var _t_index_to_rect = {
	0: Vector2(0, 0), 
	1: Vector2(0, 192),
	2: Vector2(64, 192),
	3: Vector2(64, 128),
	4: Vector2(0, 64),
	5: Vector2(0, 128),
	6: Vector2(64, 0),
	7: Vector2(64, 64),
	8: Vector2(192, 192),
	9: Vector2(192, 128),
	10: Vector2(128,192),
	11: Vector2(128, 128),
	12: Vector2(192, 0),
	13: Vector2(192, 64),
	14: Vector2(128, 0),
	15: Vector2(128, 64)
	}

func _physics_process(delta):
	if(moving):
		var pos = get_position()
		var new_pos = Vector2(pos.x, pos.y - move_speed * delta)
		set_position(new_pos)

func add_tiles(width:int, height:int):
	platform_width = width
	platform_height = height
	var xOffs = (width / 2) * 64
	var yOffs = (height / 2) * 64
	for y in range(height):
		for x in range(width):
			var t_index = 0
			if(x != 0):
				t_index += 8
			
			if(y != 0):
				t_index += 1
				
			if(x != width - 1):
				t_index += 2
			
			if(y != height - 1):
				t_index += 4
			
			add_tile((x * 64) - (xOffs - 32), (y * 64) - (yOffs - 32), _t_index_to_rect[t_index].x, _t_index_to_rect[t_index].y)

func add_tile(x:int, y:int, xt:int, yt:int):
	var t = tile_scene.instance()
	t.set_position(Vector2(x, y))
	t.get_node("Sprite").region_rect.position.x = xt
	t.get_node("Sprite").region_rect.position.y = yt
	add_child(t)
