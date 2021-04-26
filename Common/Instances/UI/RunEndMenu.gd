extends Control

onready var GameWorld = get_parent().get_parent()

onready var NameEdit = $Center/Panel/NameEdit

var _depth = 0

func set_depth(depth:int):
	_depth = depth
	$Center/Panel/DepthText.text = str(depth) + " meters"


func _on_PlayAgainBtn_pressed():
	visible = false
	if(NameEdit.text != ""):
		LeaderBoardManager.add_new_record(NameEdit.text, _depth)
		LeaderBoardManager.save_leaderboard()
	GameWorld.reset()
	yield(get_tree().create_timer(0.1),"timeout")
	GameWorld.start()



func _on_MainMenuBtn_pressed():
	visible = false
	GameWorld.reset()
	GameWorld.show_main_menu()
	if(NameEdit.text != ""):
		LeaderBoardManager.add_new_record(NameEdit.text, _depth)
		LeaderBoardManager.save_leaderboard()
