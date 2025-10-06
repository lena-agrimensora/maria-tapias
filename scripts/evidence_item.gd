extends Button
class_name EvidenceItem

#@onready var evidence_icon: TextureRect = $HBoxContainer/TextureRect
@onready var title_label: Label = $HBoxContainer/VBoxContainer/Title
@onready var desc_label: Label = $HBoxContainer/VBoxContainer/Description
var notes_panel

func _ready() -> void:
	pressed.connect(_on_evidence_button_pressed)
	self.mouse_entered.connect(_on_button_hovered)
	self.mouse_exited.connect(_on_button_exited)
	notes_panel = get_node("/root/NotesPanel")
	pass
	
func setup(title: String, description: String):
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
	_on_button_exited()
	queue_free()
	pass

func _on_button_hovered():
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	pass

func _on_button_exited() -> void:
	self.mouse_default_cursor_shape = Control.CURSOR_ARROW
	pass
