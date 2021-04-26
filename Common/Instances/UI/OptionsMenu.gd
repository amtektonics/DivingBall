extends Control

onready var GameWorld = get_parent().get_parent()

func _on_CheckBox_toggled(button_pressed):
	if(!button_pressed):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		$Center/Panel/HSlider.editable = false
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		$Center/Panel/HSlider.editable = true


func _on_HSlider_value_changed(value):
	print(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_BackBtn_pressed():
	GameWorld.show_main_menu()
	self.visible = false
