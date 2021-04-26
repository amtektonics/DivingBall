extends Node2D

export var platform_texture:Texture

var platform_width = 0
var platform_height = 0

var moving = false

var move_speed = 0

var tile_scene = load("res://Common/Instances/Misc/PlatformTile.tscn")

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
			add_tile((x * 64) - (xOffs - 32), (y * 64) - (yOffs - 32), 0, 0)
#			if(height == 1):
#				add_tile((x * 64) - (xOffs - 32), (y * 64) - (yOffs - 32), 0, 0)
#			elif(height > 2):
#				if(y == 0):
#					add_tile((x * 64) - (xOffs - 32), (y * 64) - (yOffs - 32), 0, 64)
#				elif(y != height - 1):
#					add_tile((x * 64) - (xOffs - 32), (y * 64) - (yOffs - 32), 0, 128)
#				elif(y == height - 1):
#					add_tile((x * 64) - (xOffs - 32), (y * 64) - (yOffs - 32), 0, 192)

func add_tile(x:int, y:int, xt:int, yt:int):
	var t = tile_scene.instance()
	t.set_position(Vector2(x, y))
	t.get_node("Sprite").region_rect.position.x = xt
	t.get_node("Sprite").region_rect.position.y = yt
	add_child(t)
