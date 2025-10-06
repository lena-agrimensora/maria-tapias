extends Node
class_name DialogueLoader

var all_dialogues: Array = []
var all_hints: Array = []
var all_evidences: Array = []
var all_player_questions: Array = []
var all_npc_answers: Array

@export var dialogues_file_path : String = "res://dialogues/all_dialogues.json"
@export var hints_file_path: String = "res://dialogues/all_hints.json"
@export var evidences_file_path: String = "res://dialogues/all_evidences.json"
@export var player_questions_file_path: String = "res://dialogues/all_player_questions.json"
@export var npc_answers_file_path: String = "res://dialogues/all_npc_answers.json"

func _ready() -> void:
	load_dialogues()
	load_hints()
	load_evidences()
	load_player_questions()
	

func load_dialogues():
	var file = FileAccess.open(dialogues_file_path, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		var json = JSON.new()
		var data = json.parse(json_data)
		if data == OK:
			#TODO: no solo pushear los dialogos, crear un Dialogue con cada uno y LUEGO pushear
			all_dialogues = json.get_data()["dialogues"]
			print("-----Listo. Sustanciosos dialogos: ", all_dialogues)
			pass
		else:
			print("MMM:", json.get_error_message())
			pass
	else:
		print("Error al abrir el archivo de diálogos")
		pass

func load_hints():
	var file = FileAccess.open(hints_file_path, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		var json = JSON.new()
		var data = json.parse(json_data)
		if data == OK:
			#TODO: no solo pushear las hints, crear un Dialogue con cada uno y LUEGO pushear
			all_hints = json.get_data()["hints"]
			print("-----Listo. Sustanciosas pistas: ", all_hints)
			pass
		else:
			print("MMM:", json.get_error_message())
			pass
	else:
		print("Error al abrir el archivo de pistas")
		pass
	pass

func load_evidences():
	var file = FileAccess.open(evidences_file_path, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		var json = JSON.new()
		var data = json.parse(json_data)
		if data == OK:
			#TODO: no solo pushear las hints, crear un Dialogue con cada uno y LUEGO pushear
			all_evidences = json.get_data()["evidences"]
			print("-----Listo. Evidencias: ", all_evidences)
			pass
		else:
			print("MMM:", json.get_error_message())
			pass
	else:
		print("Error al abrir el archivo de pistas")
		pass
	pass

func load_player_questions():
	var file = FileAccess.open(player_questions_file_path, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		var json = JSON.new()
		var data = json.parse(json_data)
		if data == OK:
			#TODO: no solo pushear las hints, crear un Dialogue con cada uno y LUEGO pushear
			all_evidences = json.get_data()["player_questions"]
			print("-----Listo. Preguntas jugador: ", all_player_questions)
			pass
		else:
			print("MMM:", json.get_error_message())
			pass
	else:
		print("Error al abrir el archivo de pistas")
		pass
	pass

func load_npc_answers():
	var file = FileAccess.open(npc_answers_file_path, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		var json = JSON.new()
		var data = json.parse(json_data)
		if data == OK:
			#TODO: no solo pushear las hints, crear un Dialogue con cada uno y LUEGO pushear
			all_evidences = json.get_data()["NPC_Answers"]
			print("-----Listo. Respuestas NPCs: ", all_npc_answers)
			pass
		else:
			print("MMM:", json.get_error_message())
			pass
	else:
		print("Error al abrir el archivo de pistas")
		pass
	pass
