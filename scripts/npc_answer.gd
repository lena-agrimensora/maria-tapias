extends CanvasLayer
class_name NPCAnswer

var evidences: Array = []
var npc_answers: Array = []

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

@onready var evidence_item = preload("res://scenes/evidence_item_new.tscn")

func _ready() -> void:
	npc_answers = Dialogue_Loader.all_npc_answers
	evidences = Dialogue_Loader.all_evidences
	pass

func render_npc_answer(q_id: String, character_name: String) -> void:
	var answers_for_character: Array = []
	for entry in npc_answers:
		if entry.has(character_name):
			answers_for_character = entry[character_name]
			break
			
	var found = false
	for answer in answers_for_character:
		if answer["question_id"] == q_id:
			var text_to_display = answer["display_text"]
			text_to_display = "[font_size=25]" + text_to_display + "[/font_size]"
			rich_text_label.bbcode_enabled = true
			rich_text_label.bbcode_text = text_to_display
			found = true
			if answer.has("evidence"):
				await get_tree().create_timer(1.0).timeout
				instantiate_evidence_item(answer.evidence)
				pass
			break

	if not found:
		rich_text_label.text = "..."
	
	await get_tree().create_timer(5.0).timeout
	print("Hora de eliminar")
	self.queue_free()

func instantiate_evidence_item(evidence_id: String) -> void:
	print("Deberia instanciar una evidencia con: ", evidence_id)
	for evidence in evidences:
		if evidence.id == evidence_id:
			var evidence_instance = evidence_item.instantiate()
			var evidence_title = evidence.title
			var evidence_description = evidence.description
			add_child(evidence_instance)
			evidence_instance.setup(evidence_title,evidence_description)
			break
	pass
