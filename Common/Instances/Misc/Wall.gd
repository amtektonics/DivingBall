extends StaticBody2D

export var moving = false
export var left_wall = false

var move_speed = 0

var follow_tile = null


func _ready():
	if(left_wall):
		$Sprite.region_rect.position.x = 0
	else:
		$Sprite.region_rect.position.x = 64


func _physics_process(delta):
	if(moving):
		if(weakref(follow_tile).get_ref()):
			var pos = follow_tile.get_position()
			var new_pos = Vector2(pos.x, pos.y + 64)
			set_position(new_pos)
		else:
			var pos = get_position()
			var new_pos = Vector2(pos.x, pos.y - move_speed * delta)
			set_position(new_pos)
