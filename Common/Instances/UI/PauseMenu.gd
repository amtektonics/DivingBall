extends Control

onready var GameWorld = get_parent().get_parent()

func _on_ResumeBtn_pressed():
	self.visible = false
	GameWorld.start()


func _on_MainMenuBtn_pressed():
	self.visible = false
	GameWorld.reset()
	GameWorld.show_main_menu()
