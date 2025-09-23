extends Button
class_name EvidenceItem

@onready var evidence_icon: TextureRect = $HBoxContainer/TextureRect
@onready var title_label: Label = $HBoxContainer/VBoxContainer/Title
@onready var desc_label: Label = $HBoxContainer/VBoxContainer/Description
@onready var notes_panel = %NotesPanel

func _ready() -> void:
	pressed.connect(_on_evidence_button_pressed)
	self.mouse_entered.connect(_on_button_hovered)
	self.mouse_exited.connect(_on_button_exited)
	pass
	
func setup(icon_tex: Texture2D, title: String, description: String):
	evidence_icon.texture = icon_tex
	title_label.text = title
	desc_label.text = description
	pass

func _on_evidence_button_pressed() -> void:
	var notes_sidebar = notes_panel
	if notes_sidebar:
		var ref := {
			"id": title_label.text,
			"display_value": title_label.text,
			"tooltip": desc_label.text
		}
		notes_panel.add_note(ref)
	queue_free()
	pass
	
func _on_button_hovered():
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	pass

func _on_button_exited() -> void:
	self.mouse_default_cursor_shape = Control.CURSOR_ARROW
	pass
