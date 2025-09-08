extends Control

class_name Roullete

signal spin_finished

@onready var win_bar: ColorRect = $WinBar
@onready var loss_bar: ColorRect = $LossBar
@onready var marker: ColorRect = $Marker

const BASE_UNIT: int = 20

var roullete_data: RoulleteData = null

func set_data(data: RoulleteData) -> void:
	var x_limit: int = BASE_UNIT*(data.base - data.win_n)
	loss_bar.position.x = 0
	loss_bar.size.x = x_limit
	win_bar.position.x = x_limit
	win_bar.size.x = BASE_UNIT*data.win_n
	self.roullete_data = data

func spin() -> void:
	var base: int = self.roullete_data.base
	var marker_start: float = BASE_UNIT/4.0
	var marker_end: float = (base-1) * BASE_UNIT - marker_start
	var marker_final: float = self.roullete_data.roll * BASE_UNIT - marker_start
	var time: float = float(self.roullete_data.roll)/float(base-1)

	marker.position.x = marker_start
	var tween: Tween = self.get_tree().create_tween()
	tween.tween_property(marker, "position:x", marker_end, 0.5)
	tween.tween_property(marker, "position:x", marker_start, 0)
	tween.tween_property(marker, "position:x", marker_end, 0.75)
	tween.tween_property(marker, "position:x", marker_start, 0)
	tween.tween_property(marker, "position:x", marker_end, 1)
	tween.tween_property(marker, "position:x", marker_start, 0)
	tween.tween_property(marker, "position:x", marker_final, time)
	tween.tween_callback(self._on_spin_tween_end).set_delay(1)

func _on_spin_tween_end() -> void:
	self.spin_finished.emit()
	self.queue_free()
