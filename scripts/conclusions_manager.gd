class_name ConclusionsManager
extends Node

@export var character_name: String
var npc_questions: Array = []
var conclusions  : Array = []
var initial_index: int   = 0

var current_question
var current_answer_text
var current_player_conclusion

var player_score: int = 0

@onready var evidence_picker_panel: PackedScene = preload("res://scenes/evidence_picker.tscn")
@onready var npc_answer_bubble    : PackedScene = preload("res://scenes/npc_answer.tscn")
@onready var notes_sidebar = $"/root/NotesPanel"

@export var player_buttons : Array[Button]

var conclusion_feedback_panel = preload("res://scenes/conclusion_feedback.tscn")
var score_panel = preload("res://scenes/score_panel.tscn")

func _ready() -> void:
	npc_questions = Dialogue_Loader.all_npc_questions[character_name]
	conclusions   = Dialogue_Loader.all_player_conclusions
	await get_tree().create_timer(2.0).timeout
	notes_sidebar.enable_buttons()
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
			var handle_player_response_callable = Callable(self, "handle_player_response")
			if not button.is_connected("on_answer_emit", handle_player_response_callable):
				button.connect("on_answer_emit", handle_player_response_callable)
			i+=1
	pass

func handle_player_response(args: Array) -> void:
	current_player_conclusion = args
	var display_answer = args[3]
	if args[1] == current_question.id and args[2] == "true":
		instantiate_evaluator_panel(current_question.text_desc, display_answer)
	elif args[1] == current_question.id and args[2] == "false":
		instantiate_evaluator_panel(current_question.text_desc, display_answer)
		print("NOOO re mal la respuesta")
	pass

func instantiate_evaluator_panel(q_text: String, a_text: String) -> void:
	var npc_bubble   = get_node("/root/Main/ConclusionsManager/CanvasLayer")
	var player_answ  = get_node("/root/Main/PlayerAnswer")
	var player_answ2 = get_node("/root/Main/PlayerAnswer2")
	npc_bubble.queue_free()
	player_answ.hide()
	player_answ2.hide()
	var ev_picker_instance = evidence_picker_panel.instantiate()
	get_tree().root.add_child(ev_picker_instance)
	ev_picker_instance.setup(q_text, a_text, character_name)
	pass

func handle_player_conclusions(args: Array):
	var conclusion_feedback_instance = conclusion_feedback_panel.instantiate()
	var label_text = conclusion_feedback_instance.get_node("Label")
	
	print("ok, llegue con: ", args)
	if current_question.answer == "true" and current_player_conclusion[2] == "true":
		var correct_hints = current_question.hints.duplicate()		
		correct_hints.sort()
		var selected_hints = args.duplicate()
		selected_hints.sort()
		if correct_hints == selected_hints:
			label_text.text = current_player_conclusion[4]
			player_score += 25
		else:
			label_text.text = current_player_conclusion[5]
			player_score += 15
	elif current_question.answer == "true" and current_player_conclusion[2] == "false" or current_question.answer == "false" and current_player_conclusion[2] == "true" :
		label_text.text = current_player_conclusion[5]
	
	self.add_child(conclusion_feedback_instance)

	
	var timer = Timer.new()
	self.add_child(timer)
	timer.wait_time = 7.0
	timer.one_shot = true
	timer.start()

	
	timer.connect("timeout", Callable(self, "_on_feedback_timeout").bind(conclusion_feedback_instance))


func _on_feedback_timeout(conclusion_feedback_instance: Node) -> void:
	var evaluator_panel = get_node("/root/EvidencePicker")
	if evaluator_panel:
		evaluator_panel.queue_free() 

	conclusion_feedback_instance.queue_free()

	initial_index += 1
	if initial_index < npc_questions.size():
		get_npc_question()
	else:
		#TODO: mostrar score y fin
		var score_panel_inst = score_panel.instantiate()
		var score_label = score_panel_inst.get_node("Label")
		score_label.text = "Gracias por jugar! Tu puntaje: " + str(player_score) + " /100"
		get_tree().root.add_child(score_panel_inst)
		print("Fin del diálogo o no más preguntas disponibles.")
