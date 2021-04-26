extends Node

export var starting_speed = 200.00

var scroll_speed = starting_speed

var speed_change = 0.05

var total_distance = 0.0

onready var WallManager = $ScrollingWalls

onready var PlatformManager = $PlatformManager

onready var Player = $Player

onready var RunEndMenu = $CanvasLayer/RunEndMenu

onready var MainMenu = $CanvasLayer/MainMenu

onready var OptionsMenu = $CanvasLayer/OptionsMenu

onready var HowToPlayMenu = $CanvasLayer/HowToPlayMenu

onready var LeaderBoardMenu = $CanvasLayer/LeaderBoardMenu

onready var PauseMenu = $CanvasLayer/PauseMenu

var _stopped = false


func _ready():
	WallManager.update_scroll_speed(scroll_speed)
	PlatformManager.update_scroll_speed(scroll_speed)
	WallManager.populate_walls()
	stop()
	WallManager.start()
	LeaderBoardManager.load_leaderboard()

func _physics_process(delta):
	if(!WallManager.is_stopped()):
		$Background.region_rect.position.y += (scroll_speed * delta) / 2
		if($Background.region_rect.position.y > 1792):
			$Background.region_rect.position.y -= 1792
	
	if(!_stopped):
		scroll_speed += speed_change
		WallManager.update_scroll_speed(scroll_speed)
		PlatformManager.update_scroll_speed(scroll_speed)
		
		total_distance += ((scroll_speed * delta) / 64.0)
		$CanvasLayer/Depth.text = "Depth: " + str(int(total_distance)) + " meters"
		
		if(Input.is_action_just_pressed("PauseGame")):
			stop()
			PauseMenu.visible = true
			
	


func reset():
#	WallManager.reset()
	PlatformManager.reset()
	Player.reset()
	total_distance = 0
	scroll_speed = starting_speed
	$CanvasLayer/Depth.text = "Depth: 0 meters"


func start():
	WallManager.start()
	PlatformManager.start()
	_stopped = false
	Player.start()

func stop():
	WallManager.stop()
	PlatformManager.stop()
	Player.stop()
	_stopped = true

func update_scroll_speed(new_speed:float):
	scroll_speed = new_speed
	WallManager.update_scroll_speed(new_speed)
	PlatformManager.update_scroll_speed(new_speed)

func show_run_end_menu():
	RunEndMenu.set_depth(total_distance)
	RunEndMenu.visible = true

func show_main_menu():
	WallManager.start()
	MainMenu.visible = true

func show_options():
	OptionsMenu.visible = true


func show_how_to_play():
	HowToPlayMenu.visible = true

func show_leaderboard():
	LeaderBoardMenu.visible = true
	LeaderBoardMenu.update_leaderboard()

func clean_scene():
	pass
