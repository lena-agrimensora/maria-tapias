extends Node
class_name DialogueManager

var dialogues: Array = []
var hint_references: Array = []

func _ready() -> void:
	dialogues = Dialogue_Loader.all_dialogues
	hint_references = Dialogue_Loader.all_hints
	print("Tengo todos los dialogos desde el Manager: ", dialogues)
	pass

#TODO: return type que sea Dialogue
func render_dialogue(id: String, rich_text_label: RichTextLabel) -> void:
	var dialogue_candidate = null
	
	for dialogue in dialogues:
		if dialogue["id"] == id:
			dialogue_candidate = dialogue
			break

	
	if dialogue_candidate == null:
		print("Lamentablemente no existe el id: ", id)
		return 

	
	var text = dialogue_candidate["display_text"]
	var references = dialogue_candidate["hint_ids"]
	
	for ref in references:
		var hint = null
		for hint_ref in hint_references:
			if hint_ref["id"] == ref:
				hint = hint_ref
				var placeholder = "[url=" + ref + "]" + hint["display_value"] + "[/url]"
				text = text.replace("[url=" + ref + "]" + ref + "[/url]", placeholder)
				text = "[font_size=25]" + text + "[/font_size]"
				rich_text_label.bbcode_text = text
	
func get_hints_by_dialogue_id(dialogue_id: String) -> Array:
	var found_dialogue = null

	for dialogue in dialogues:
		if dialogue.has("id") and dialogue["id"] == dialogue_id:
			found_dialogue = dialogue
			break

	if found_dialogue == null:
		print("Diálogo no encontrado con id: ", dialogue_id)
		return []

	var hint_ids = found_dialogue.get("hint_ids", [])
	var hints: Array = []

	for hint_id in hint_ids:
		var found_hint = null
		for hint_ref in hint_references:
			if hint_ref.has("id") and hint_ref["id"] == hint_id:
				found_hint = hint_ref
				break
		if found_hint:
			hints.append(found_hint)
		else:
			print("Hint no encontrado para ID: ", hint_id)

	return hints

func get_all_dialogues_by_character_name(character_name: String)-> Array:
	var dialogues_arr: Array = []
	for dialogue in dialogues:
		if dialogue["character"] == character_name:
			dialogues_arr.append(dialogue)
		print("dialogue: ", dialogue)
	return dialogues_arr
