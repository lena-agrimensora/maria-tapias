extends Node
class_name QAManager

@export var character_name: String


var questions: Array = []
var npc_answers: Array = []
var evidences: Array = []

@onready var question_box = preload("res://scenes/caja_preguntas.tscn")
var question_box_instance

func _ready() -> void:
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

func render_player_questions(questions: Array)->void:
	var i = 0
	for child in question_box_instance.get_children():
		if child is Button and i < questions.size():
			var label = Label.new()
			var question = questions[i]
			label.text = question.display_text
			child.add_child(label)
			child.question_value = question.display_text
			i += 1
	pass
