extends CanvasLayer
class_name NPC_Dialogue_Bubble

@export var dialogue : Dialogue
@export var character_name: String
var character_dialogues: Array = []
var current_dialogue_id: String = ""
var current_dialogue_index: int = 0

var hint_references : Array = []

@onready var notes_sidebar = %NotesPanel
@onready var dialogue_manager : DialogueManager = %DialogueManager
@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel
@onready var next_button: Button = $NextButton
@onready var prev_button: Button = $PreviousButton

func _ready():
	next_button.pressed.connect(_on_button_pressed.bind("Next"))
	prev_button.pressed.connect(_on_button_pressed.bind("Previous"))
	character_name = "Pepe"
	#TODO: Obtener todos los dialogos 
	character_dialogues = dialogue_manager.get_all_dialogues_by_character_name(character_name)
	rich_text_label.bbcode_enabled = true
	rich_text_label.meta_clicked.connect(_on_meta_clicked)
	#TODO: Obtener id de dialogo dinamicamente, mantener la ref al rtl
	#TODO que render_dialogue ADEMAS de renderizar, me devuelva un Dialogue para guardar la referencia
	current_dialogue_id = character_dialogues[current_dialogue_index].id
	dialogue_manager.render_dialogue(current_dialogue_id,rich_text_label)
	hint_references = dialogue_manager.get_hints_by_dialogue_id(current_dialogue_id)	

func _on_meta_clicked(meta: String) -> void:
	var ref = null
	
	for hint_ref in hint_references:
		if hint_ref.has("id") and hint_ref["id"] == meta:
			ref = hint_ref
			break

	if ref == null:
		print("No hay hint con id:", meta)
		return
	
	
	notes_sidebar.add_note(ref)
	await get_tree().create_timer(0.3).timeout

#TODO: una sola funcion para ambos botones
func _on_previous_button_pressed() -> void:
	current_dialogue_index = current_dialogue_index-1
	current_dialogue_id = character_dialogues[current_dialogue_index].id
	dialogue_manager.render_dialogue(current_dialogue_id,rich_text_label)
	hint_references = dialogue_manager.get_hints_by_dialogue_id(current_dialogue_id)	
	pass

func _on_button_pressed(type: String) -> void:
	print(type)
	if type == "Next":
		#TODO: Validar fuera de rango :3
		current_dialogue_index = current_dialogue_index+1
	elif type == "Previous":
		#TODO: Validar fuera de rango tambien
		current_dialogue_index = current_dialogue_index-1
		
	current_dialogue_id = character_dialogues[current_dialogue_index].id
	dialogue_manager.render_dialogue(current_dialogue_id,rich_text_label)
	hint_references = dialogue_manager.get_hints_by_dialogue_id(current_dialogue_id)	
	pass
