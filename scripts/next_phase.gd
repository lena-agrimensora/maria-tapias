extends Button
class_name NextPhaseButton

var interrogation_scene: String = "res://scenes/interrogation_phase.tscn"
@onready var notes_panel = get_node("/root/Main/NotesPanel")

func _on_pressed() -> void:
	notes_panel.get_parent().remove_child(notes_panel)
	get_tree().root.add_child(notes_panel)
	get_tree().change_scene_to_file(interrogation_scene)
