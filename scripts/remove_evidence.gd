class_name RemoveEvidenceButton
extends Button

@onready var ev_label : Node = get_parent()

@onready var notes_panel = get_node("/root/NotesPanel")

var evidence_id      : String
var evidence_desc    : String
var evidence_tooltip : String
var placeholder_ref  : String

func setup(ref: Dictionary):
	evidence_id = ref.id
	evidence_desc = ref.display_text
	evidence_tooltip = ref.tooltip
	pass
	
func _on_pressed() -> void:
	var ref_note = {
		"id": evidence_id,
		"display_value": evidence_desc,
		"tooltip": evidence_tooltip
	}   
	
	var evidence_picker = get_node("/root/EvidencePicker")
	
	var placeholder = evidence_picker.evidence_dict[placeholder_ref]
	placeholder.show()
	placeholder.text = evidence_picker.default_placeholder_text
	
	if evidence_id in evidence_picker.selected_evidence_ids:
		evidence_picker.selected_evidence_ids.erase(evidence_id)
		
	call_deferred("set_disabled", true)
		
	if ev_label.get_parent():
		ev_label.get_parent().call_deferred("remove_child", ev_label)
		ev_label.call_deferred("queue_free")
	
	notes_panel.add_note(ref_note, true)
