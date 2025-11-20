class_name ConfirmButton
extends Button

@onready var evidence_picker = $"../../.."
@onready var conclusions_manager = $"/root/Main/ConclusionsManager" 
var all_evidences : Array

func _on_pressed() -> void:
	conclusions_manager.handle_player_conclusions(evidence_picker.selected_evidence_ids)
	pass
