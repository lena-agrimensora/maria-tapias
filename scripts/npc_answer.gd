extends CanvasLayer
class_name NPCAnswer

var hint_references: Array = []
var npc_answers: Array = []

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

func _ready() -> void:
	npc_answers = Dialogue_Loader.all_npc_answers
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
			rich_text_label.text = answer["display_text"]
			found = true
			break

	if not found:
		rich_text_label.text = "..."
	
	await get_tree().create_timer(5.0).timeout
	print("Hora de eliminar")
	self.queue_free()
