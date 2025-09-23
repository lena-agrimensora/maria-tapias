extends Control
class_name NotesButton

@onready var notes_button: TextureButton = $NotesButton
@onready var notes_panel: PanelContainer = $PanelContainer

func _ready() -> void:
	#notes_panel.visible = false
	notes_button.mouse_entered.connect(_on_button_hovered)
	notes_button.mouse_exited.connect(_on_button_exited)
	notes_button.button_down.connect(_on_button_pressed)
	notes_button.button_up.connect(_on_button_released)

func _on_button_hovered():
	notes_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	pass

func _on_button_exited() -> void:
	notes_button.mouse_default_cursor_shape = Control.CURSOR_ARROW
	pass

func _on_button_pressed() -> void:
	modulate = Color(1, 1, 1, 0.4)
	pass
	
func _on_button_released() -> void:
	modulate = Color(1, 1, 1, 1)
	pass
