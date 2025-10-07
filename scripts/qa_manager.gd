extends Node
class_name QAManager

@export var character_name: String


var questions: Array = []
var npc_answers: Array = []
var evidences: Array = []

@onready var question_box = preload("res://scenes/caja_preguntas.tscn")
@onready var npc_answer_bubble = preload("res://scenes/npc_answer.tscn")

var next_scene = "res://scenes/conclusion_phase.tscn"
var question_box_instance
var clicked_buttons: Array = []
@onready var next_button = $"../NextButton"

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	question_box_instance = question_box.instantiate()
	add_child(question_box_instance)
	
	questions = Dialogue_Loader.all_player_questions	
	evidences = Dialogue_Loader.all_evidences
	
	for answer in Dialogue_Loader.all_npc_answers:
		if answer.has(character_name):
			npc_answers = answer[character_name]
			break
	pass
	
	render_player_questions(questions)

func render_player_questions(questions_arr: Array)->void:
	var i = 0
	for question in questions_arr:
		if question_box_instance and question_box_instance.get_child(i) is Button:
			var child = question_box_instance.get_child(i)
			child.text = question.display_text
			child.question_value = question.display_text
			child.question_id = question.id
			child.connect("on_question_emit", handle_question_invoked)
			i += 1
	pass

func handle_question_invoked(question_id: String) -> void:
	for child in get_children():
		if child is NPCAnswer:
			print("adios")
			child.queue_free()
			break

	var ans_bubble_instance = npc_answer_bubble.instantiate()
	add_child(ans_bubble_instance)
	ans_bubble_instance.render_npc_answer(question_id, character_name)
	if not clicked_buttons.has(question_id):
		clicked_buttons.append(question_id)
	
	if clicked_buttons.size() == questions.size():
		next_button.next_scene = next_scene
		next_button.label_text = "Ir a fase de Conclusión"
		next_button.visible = true		
		print("mostrar sig fase")
		pass
	
