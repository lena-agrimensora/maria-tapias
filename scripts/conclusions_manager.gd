extends Node
class_name ConclusionsManager

@export var character_name: String
var npc_questions: Array = []
var conclusions  : Array = []
var initial_index: int = 0
var current_question

@onready var npc_answer_bubble = preload("res://scenes/npc_answer.tscn")

@export var player_buttons : Array[Button]

func _ready() -> void:
	npc_questions = Dialogue_Loader.all_npc_questions[character_name]
	conclusions   = Dialogue_Loader.all_player_conclusions
	await get_tree().create_timer(2.0).timeout
	get_npc_question()
	pass

func get_npc_question() -> void:
	current_question = npc_questions[initial_index]
	var ans_bubble_instance = npc_answer_bubble.instantiate()
	var rich_text_label: RichTextLabel = ans_bubble_instance.get_node("MarginContainer/RichTextLabel")
	rich_text_label.bbcode_text = current_question.text_desc
	add_child(ans_bubble_instance)
	render_player_options(current_question.id)

func render_player_options(question_id: String) -> void:
	var i = 0
	for conc in conclusions:
		if conc.q_ref == question_id:
			var button = player_buttons[i]
			var label: Label = button.get_node("Label")
			label.text = conc.display_text
			button.id = conc.id
			button.is_correct = conc.is_correct
			button.right_hints = conc.right_hints if conc.right_hints != null else ""
			button.wrong_hints = conc.wrong_hints if conc.wrong_hints != null else ""
			button.hints_ref = conc.hints if conc.hints != null else []
			button.q_ref = conc.q_ref
			button.visible = true
			button.connect("on_answer_emit", Callable(self, "handle_player_response"))
			i+=1
	pass

func handle_player_response(args: Array) -> void:
	print("recibi increibles args: ", args)
	print("Y tenia la sig pregunta: ", current_question)
	pass
