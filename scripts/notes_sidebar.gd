extends CanvasLayer
class_name NotesSidebar

@onready var notes_button: TextureButton = $Notes_Button_Control/NotesButton
@onready var notes_panel: PanelContainer = $PanelContainer
@onready var notes_list: VBoxContainer = $VBoxContainer

var NoteItemRef = preload("res://scenes/note_item.tscn")

func _ready() -> void:
	notes_panel.visible = false
	notes_list.visible = false
	notes_button.pressed.connect(_on_button_pressed)
	notes_button.mouse_entered.connect(_on_button_hovered)
	notes_button.mouse_exited.connect(_on_button_exited)

func _on_button_pressed() -> void:
	notes_panel.visible = !notes_panel.visible
	notes_list.visible = !notes_list.visible
	for child in notes_list.get_children():
		child.visible = notes_list.visible

func _on_button_hovered():
	notes_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

func _on_button_exited() -> void:
	notes_button.mouse_default_cursor_shape = Control.CURSOR_ARROW

func add_note(ref: Dictionary, conclusion = false) -> void:
	
	for child in notes_list.get_children():
		if child.name == ref.id:
			return
	
	var note_instance = NoteItemRef.instantiate()
	note_instance.name = ref.id
	notes_list.add_child(note_instance)
	
	note_instance.text = ref.display_value
	note_instance.tooltip_txt = ref.tooltip
	note_instance.id = ref.id
	
	note_instance.display_text = ref.display_value
	note_instance.visible = notes_list.visible	
	
	notes_button.modulate = Color(0.388, 0.523, 0.857, 1.0)
	await get_tree().create_timer(0.3).timeout
	notes_button.modulate = Color(1.0, 1.0, 1.0, 1.0)

	note_instance.connect("note_item_pressed", clear_note_item)
	if (conclusion):
		note_instance.disabled = false
	
func enable_buttons() -> void:
	var notes_container = get_node("VBoxContainer")
	for note in notes_container.get_children():
		note.disabled = false
	pass

func clear_note_item(params):
	for child in notes_list.get_children():
		if child.display_text == params:
			child.queue_free()
	pass
