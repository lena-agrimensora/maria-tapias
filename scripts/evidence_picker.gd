class_name EvidencePicker
extends Control

@onready var text_rect             = $CanvasLayer/TextureRect
@onready var q_label               = $CanvasLayer/TextureRect/Q_Label
@onready var a_label               = $CanvasLayer/TextureRect/A_Label
@onready var char_label            = $CanvasLayer/TextureRect/Client_Label
@onready var ev_placeholder_1      = $CanvasLayer/TextureRect/Evidence1_Placeholder
@onready var ev_placeholder_2      = $CanvasLayer/TextureRect/Evidence2_Placeholder
@onready var ev_placeholder_3      = $CanvasLayer/TextureRect/Evidence3_Placeholder
@onready var confirm_button = $CanvasLayer/TextureRect/Confirm_Button
var evidence_dict : Dictionary = {}
@onready var ev_label_scene : PackedScene = preload("res://scenes/evidence_label.tscn")
var evidence_selected
var default_placeholder_text : String = "(Elegir evidencia del Cuaderno de Notas)"
var selected_evidence_ids: Array = []



func setup (q_text: String, a_text: String, char_name: String) -> void:
	q_label.text = q_text
	a_label.text = a_text + " porque... "
	char_label.text = char_name
	evidence_dict = {
		"Evidence1_Placeholder" : ev_placeholder_1,
		"Evidence2_Placeholder" : ev_placeholder_2,
		"Evidence3_Placeholder" : ev_placeholder_3,
		}
	pass

func instantiate_evidence(label_name_ref: String, label_text: String):
	print("Recibí increíble: ", label_name_ref)
	
	var ev_label_instance = ev_label_scene.instantiate()
	
	var remove_button = ev_label_instance.get_node("Remove_Ev")
	remove_button.placeholder_ref = label_name_ref
	remove_button.setup(evidence_selected)
	
	ev_label_instance.text = label_text
	
	if evidence_selected.has("id"):
		selected_evidence_ids.append(evidence_selected["id"])
	
	var target_ev_placeholder = evidence_dict[label_name_ref]
	var new_pos = target_ev_placeholder.position
	target_ev_placeholder.hide()
	ev_label_instance.position = new_pos
	
	ev_label_instance.mouse_filter = Control.MOUSE_FILTER_IGNORE
	remove_button.disabled = true
	
	text_rect.call_deferred("add_child", ev_label_instance)
	remove_button.call_deferred("set_disabled", false)
