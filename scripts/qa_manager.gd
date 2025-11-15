extends Node
class_name QAManager

@export var character_name: String

var questions: Array = []
var npc_answers: Array = []
var evidences: Array = []

@onready var question_box = preload("res://scenes/caja_preguntas.tscn")
@onready var npc_answer_bubble = preload("res://scenes/npc_answer.tscn")

var next_scene = "res://scenes/conclusion_phase.tscn"
@onready var next_button_scene = $"../NextButton"

var question_box_instance
var clicked_buttons: Array = []

var current_page: int = 0
var questions_per_page: int = 3

var next_button
var prev_button

func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	question_box_instance = question_box.instantiate()
	add_child(question_box_instance)
	
	next_button = question_box_instance.get_node("TextureRect/next_button")
	prev_button = question_box_instance.get_node("TextureRect/prev_button")
	
	next_button.pressed.connect(on_next_button_pressed)
	prev_button.pressed.connect(on_prev_button_pressed)
	
	questions = Dialogue_Loader.all_player_questions
	evidences = Dialogue_Loader.all_evidences
	
	for answer in Dialogue_Loader.all_npc_answers:
		if answer.has(character_name):
			npc_answers = answer[character_name]
			break
			
	render_player_questions(questions)


func render_player_questions(questions_arr: Array) -> void:
	var texture_rect = question_box_instance.get_node("TextureRect")

	
	var button_list: Array = []
	for child in texture_rect.get_children():
		if child is Button and child.name != "next_button" and child.name != "prev_button":
			button_list.append(child)

	
	var start_index = current_page * questions_per_page
	var end_index = min(start_index + questions_per_page, questions_arr.size())
	var questions_to_display = questions_arr.slice(start_index, end_index)

	
	for i in range(button_list.size()):
		var btn = button_list[i]

		if i < questions_to_display.size():
			var q = questions_to_display[i]
			btn.visible = true
			btn.text = q.display_text
			btn.question_value = q.display_text
			btn.question_id = q.id

			
			if not btn.on_question_emit.is_connected(handle_question_invoked):
				btn.on_question_emit.connect(handle_question_invoked)
		else:
			btn.visible = false

	
	next_button.visible = (end_index < questions_arr.size())
	prev_button.visible = (current_page > 0)



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
		next_button_scene.next_scene = next_scene
		next_button_scene.label_text = "Ir a fase de Conclusión"
		next_button_scene.visible = true
		print("mostrar sig fase")


func on_next_button_pressed() -> void:
	if current_page * questions_per_page + questions_per_page < questions.size():
		current_page += 1
		render_player_questions(questions)
		print("Mostrando página ", current_page + 1)


func on_prev_button_pressed() -> void:
	if current_page > 0:
		current_page -= 1
		render_player_questions(questions)
		print("Volviendo a página ", current_page + 1)
