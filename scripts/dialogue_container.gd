extends Node
class_name DialogueContainer

var all_dialogues: Array = []
@export var dialogues_file_path : String = "res://dialogues/all_dialogues.json"
@export var hints_file_path: String = "res://dialogues/all_hints.json"

func _ready() -> void:
	load_dialogues()

func load_dialogues():
	var file = FileAccess.open(dialogues_file_path, FileAccess.READ)
	if file:
		var json_data = file.get_as_text()
		var json = JSON.new()
		var data = json.parse(json_data)
		if data == OK:
			all_dialogues = json.get_data()["dialogues"]
			print("Listo. Sustanciosos dialogos: ", all_dialogues)
			pass
		else:
			print("MMM:", json.get_error_message())
			pass
	else:
		print("Error al abrir el archivo de diálogos")
		pass
