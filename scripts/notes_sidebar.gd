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

func add_note(ref: Dictionary) -> void:
	
	for child in notes_list.get_children():
		if child.name == ref.id:
			return	
	
	var note_instance = NoteItemRef.instantiate()
	note_instance.name = ref.id

	var label = note_instance.get_child(1)
		
	label.text = ref.display_value	
	
	notes_list.add_child(note_instance)
	note_instance.visible = notes_list.visible
	
	note_instance.tooltip_txt = ref.tooltip
	notes_button.modulate = Color(0.388, 0.523, 0.857, 1.0)
	await get_tree().create_timer(0.3).timeout
	notes_button.modulate = Color(1.0, 1.0, 1.0, 1.0)
