extends Control

var buttons: Array[Button] = []

func _ready() -> void:
	for button in $Buttons.get_children():
		self.buttons.push_back(button as Button)

	self.buttons[0].grab_focus()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		for button in self.buttons:
			if button.has_focus():
				button.pressed.emit()

	if event.is_action_pressed("ui_cancel"):
		self._on_exit_button_pressed()

func _on_play_button_pressed() -> void:
	self.get_tree().change_scene_to_file("res://extra_scenes/select_save/select_save.tscn")

func _on_exit_button_pressed() -> void:
	self.get_tree().quit()
