class_name ConclusionsManager
extends Node

@export var character_name: String
var npc_questions: Array = []
var conclusions  : Array = []
var initial_index: int   = 0

var current_question
var current_answer_text

@onready var evidence_picker_panel: PackedScene = preload("res://scenes/evidence_picker.tscn")
@onready var npc_answer_bubble    : PackedScene = preload("res://scenes/npc_answer.tscn")

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
			button.display_value = conc.display_text
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
	var display_answer = args[3]
	#TODO: convertir en Dict?
	if args[1] == current_question.id and args[2] == "true":
		instantiate_evaluator_panel(current_question.text_desc, display_answer)
	elif args[1] == current_question.id and args[2] == "false":
		instantiate_evaluator_panel(current_question.text_desc, display_answer)
		print("NOOO re mal la respuesta")
	pass

func instantiate_evaluator_panel(q_text: String, a_text: String) -> void:
	#TODO: obviamente hacer dinamico y en otra funcion
	var npc_bubble   = get_node("/root/Main/ConclusionsManager/CanvasLayer")
	var player_answ  = get_node("/root/Main/PlayerAnswer")
	var player_answ2 = get_node("/root/Main/PlayerAnswer2")
	npc_bubble.hide()
	player_answ.hide()
	player_answ2.hide()
	var ev_picker_instance = evidence_picker_panel.instantiate()
	get_tree().root.add_child(ev_picker_instance)
	ev_picker_instance.setup(q_text, a_text)
	pass
