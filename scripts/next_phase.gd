extends Button
class_name NextPhaseButton

var notes_panel
@export var label_text : String  = "Ir a la fase de Interrogación"
@export var next_scene : String

@onready var label = $Label

func _ready() -> void:
	notes_panel = get_node("/root/Main/NotesPanel") if has_node("/root/Main/NotesPanel") else get_node("/root/NotesPanel")
	label.text = label_text
	
func _on_pressed() -> void:
	notes_panel.get_parent().remove_child(notes_panel)
	get_tree().root.add_child(notes_panel)
	notes_panel.visible = true	
	get_tree().change_scene_to_file(next_scene)
