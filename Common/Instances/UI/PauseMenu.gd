extends Control

onready var GameWorld = get_parent().get_parent()

func awake():
	if(AudioServer.is_bus_mute(AudioServer.get_bus_index("Master"))):
		$SoundCheckBox.pressed = false
	else:
		$SoundCheckBox.pressed = true

func _on_ResumeBtn_pressed():
	self.visible = false
	GameWorld.start()


func _on_MainMenuBtn_pressed():
	self.visible = false
	GameWorld.reset()
	GameWorld.show_main_menu()


func _on_SoundCheckBox_toggled(button_pressed):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !button_pressed)

