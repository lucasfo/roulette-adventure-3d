extends Control

@export var save_file_paths: Array[String] = []

@onready var save_file_buttons: Array[Button] = [$Buttons/Save0, $Buttons/Save1, $Buttons/Save2]

var save_files: Array[SaveFile] = []
var buttons: Array[Button] = []

func _ready() -> void:
	for button in $Buttons.get_children():
		self.buttons.push_back(button as Button)

	self.buttons[0].grab_focus()
	for i in range(0, self.save_file_paths.size()):
		var path: String = self.save_file_paths[i]
		var save_file: SaveFile = SaveFile.read(path)
		self.fix_button_text(save_file, i)
		save_files.push_back(save_file)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		for button in self.buttons:
			if button.has_focus():
				button.pressed.emit()

	if event.is_action_pressed("ui_cancel"):
		self._on_exit_button_pressed()

func fix_button_text(save_file: SaveFile, i: int):
	#TODO: Localization
	if save_file.is_empty:
		self.save_file_buttons[i].text = "New Game"
	else:
		self.save_file_buttons[i].text = "Save %d" % (i + 1)

func _on_save_pressed(i: int) -> void:
	self.save_files[i].restore_save()
	self.get_tree().change_scene_to_file("res://main/main.tscn")

func _on_erase_pressed(i: int) -> void:
	var path: String = self.save_file_paths[i]
	SaveFile.erase(path)
	self.save_files[i] = SaveFile.read(path)
	self.fix_button_text(self.save_files[i], i)

func _on_save_0_pressed() -> void:
	_on_save_pressed(0)

func _on_save_1_pressed() -> void:
	_on_save_pressed(1)

func _on_save_2_pressed() -> void:
	_on_save_pressed(2)

func _on_erase_0_pressed() -> void:
	_on_erase_pressed(0)

func _on_erase_1_pressed() -> void:
	_on_erase_pressed(1)

func _on_erase_2_pressed() -> void:
	_on_erase_pressed(2)

func _on_exit_button_pressed() -> void:
	self.get_tree().change_scene_to_file("res://extra_scenes/menu/menu.tscn")
