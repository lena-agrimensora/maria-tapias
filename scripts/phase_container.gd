extends Node2D
class_name PhaseContainer

signal on_container_freed()
@export var phase_name: String = ""
@onready var label = $CanvasLayer/Label

func _ready() -> void:
	label.text = phase_name
	await get_tree().create_timer(2.0).timeout
	queue_free()
	on_container_freed.emit()
	pass
