extends Node
class_name DialogueManager

var dialogues = {}
var hint_references = {}

func _ready() -> void:
	dialogues = Dialogue_Container.all_dialogues
	print("Tengo todos los dialogos desde el Manager: ", dialogues)
	pass

func add_dialogue(id: String, dialogue_text: String, hint_references: Dictionary) -> void:
	dialogues[id] = {
		"text": dialogue_text,
		"hint_references": hint_references
	}

func render_dialogue(id: String, rich_text_label: RichTextLabel) -> void:
	if not dialogues.has(id):
		return

	var dialogue = dialogues[id]
	var text = dialogue["text"]
	var references = dialogue["hint_references"]


	for key in references.keys():
		var hint = references[key]
		var placeholder = "[url=" + key + "]" + hint.display_value + "[/url]"
		text = text.replace("[url=" + key + "]" + key + "[/url]", placeholder)

	rich_text_label.bbcode_text = text

	for key in references.keys():
		var hint = references[key]
		var url_element = rich_text_label.get_link_at_pos(text.find("[url=" + key + "]"))
		if url_element != null:
			url_element.tooltip = hint.tooltip
