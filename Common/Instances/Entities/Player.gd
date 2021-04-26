extends KinematicBody2D


export var drag = 3.0

export var move_to_home_speed =  2.0

export var wall_bounch_strength = 250

export var max_strength = 300

export var max_speed = 1000.0

var velocity = Vector2()

var _stopped = false

var _fling_started = false
var _fling_released = false

onready var GameWorld = get_parent()

onready var GroundRay = $GroundRay

onready var DirectionIndicator = $DirectionIndicatorPivot
onready var DirectionIndicatorSprite = $DirectionIndicatorPivot/DirectionIndicator

onready var BubbleJetPivot = $BubbleJetPivot
onready var BubbleJet = $BubbleJetPivot/BubbleJet
onready var BubbleJet2 = $BubbleJetPivot/BubbleJet2
onready var BubbleJetSound = $BubbleJetSound

onready var BubblesSound = $BubblesSound
onready var BounceSound = $BounceSound
onready var CrashSound = $CrashSound

var _fling_start_pos = Vector2()
var _fling_end_pos = Vector2()

func _ready():
	#This is here to initalize the 
	#collision of the kinimatic body
	#if you don't do this it will clip through
	#the static bodies
	velocity.y = -0.01
	randomize()
	
var is_bubble_one = true

var _can_play_bounce = true

func _physics_process(delta):
	if(!_stopped):
		if(velocity != Vector2()):
			velocity.x -= sign(velocity.x) * drag
			velocity.y -= sign(velocity.y) * (drag * 2)
		
		if(get_position().y != 0):
			velocity.y -= get_position().y * 0.1
		
		if(_fling_started):
			DirectionIndicator.visible = true
#			GameWorld.update_scroll_speed(GameWorld.scroll_speed / 2)
		
		var mouse = get_viewport().get_mouse_position()
		var di_vec = Vector2(_fling_start_pos.x - mouse.x, _fling_start_pos.y - mouse.y)
		var di_strength = _fling_start_pos.distance_to(mouse)
		DirectionIndicator.set_rotation(atan2(di_vec.y, di_vec.x) - (PI / 2))
		DirectionIndicatorSprite.scale.y  = di_strength / (get_viewport().size.x / 8)
		
		if(_fling_released):
			DirectionIndicator.visible = false
			_fling_released = false
			_fling_started = false
			var strength = _fling_start_pos.distance_to(_fling_end_pos)
			var dir_vec = Vector2(_fling_start_pos.x - _fling_end_pos.x, _fling_start_pos.y - _fling_end_pos.y)
			if(strength > max_strength):
				strength = max_strength
			velocity += dir_vec * (strength / 200)
			BubbleJetPivot.set_rotation(DirectionIndicator.get_rotation())
			if(is_bubble_one):
				BubbleJet.emitting = true
				is_bubble_one = false
			else:
				BubbleJet2.emitting = true
				is_bubble_one = true
			BubbleJetSound.pitch_scale = rand_range(0.8, 1.0)
			BubbleJetSound.play()
#			GameWorld.update_scroll_speed(GameWorld.scroll_speed * 2)
			
		
		
		
		velocity = velocity.clamped(max_speed)
		
		if(velocity != Vector2()):
			var k_collision = move_and_collide(velocity * delta)
			if(k_collision != null):
				if(k_collision.collider.is_in_group("Wall")):
					var strength = _fling_start_pos.distance_to(_fling_end_pos)
					var bounce = Vector2(-velocity.x, -velocity.y).normalized()
					velocity = Vector2()
					velocity += bounce * strength / 10
					if(_can_play_bounce):
						BounceSound.play()
						_can_play_bounce = false
					
				if(k_collision.collider.is_in_group("Platform")):
					GroundRay.force_raycast_update()
					if(GroundRay.is_colliding()):
						if(GroundRay.get_collider().is_in_group("Platform")):
							GameWorld.stop()
							GameWorld.show_run_end_menu()
							CrashSound.play()
					else:
						var strength = _fling_start_pos.distance_to(_fling_end_pos)
						var bounce = Vector2(-velocity.x, -velocity.y).normalized()
						velocity = Vector2()
						velocity += bounce * strength / 10
						if(_can_play_bounce):
							BounceSound.play()
							_can_play_bounce = false
			else:
				_can_play_bounce = true
				

func start():
	_stopped = false
	$BubbleUpwards.emitting = true
	BubblesSound.play()
	velocity.y = -0.01
	$Collider.disabled = false
	
func stop():
	_stopped = true
	DirectionIndicator.visible = false
	$BubbleUpwards.emitting = false
	BubblesSound.stop()
	$Collider.disabled = true

func reset():
	set_position(Vector2())
	velocity = Vector2()
	DirectionIndicator.visible = false

func _input(event):
	if(!_stopped):
		if(event is InputEventMouseButton):
			if(event.button_index == BUTTON_LEFT):
				if(!event.pressed && _fling_started):
					_fling_released = true
					_fling_end_pos = get_viewport().get_mouse_position()
				elif(event.pressed && !_fling_started):
					_fling_started = true
					_fling_start_pos = get_viewport().get_mouse_position()
