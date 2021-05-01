extends Control

onready var GameWorld = get_parent().get_parent()

func _on_BackBtn_pressed():
	self.visible = false
	GameWorld.show_main_menu()


func awake():
	pass
