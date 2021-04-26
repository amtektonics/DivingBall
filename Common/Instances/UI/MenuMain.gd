extends Control

onready var GameWorld = get_parent().get_parent()


func _on_PlayBtn_pressed():
	self.visible = false
	GameWorld.start()


func _on_ExitBtn_pressed():
	get_tree().quit()


func _on_OptionsBtn_pressed():
	self.visible = false
	GameWorld.show_options()


func _on_HowToPlayBtn_pressed():
	self.visible = false
	GameWorld.show_how_to_play()


func _on_LeaderBoardsBtn_pressed():
	self.visible = false
	GameWorld.show_leaderboard()
