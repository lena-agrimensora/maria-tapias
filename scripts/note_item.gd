extends VBoxContainer
class_name NoteItem

@export var title_label: Label
@export var tooltip_txt: String

var tooltip_label: Label
var tooltip_bg: ColorRect
var tooltip_active: bool = false

var dragging = false
var drag_offset = Vector2()

func _ready() -> void:
	title_label = %Label
	title_label.mouse_entered.connect(_on_button_hovered)
	title_label.mouse_exited.connect(_on_button_exited)

func _process(delta: float) -> void:
	if tooltip_active:
		var mouse_pos = get_viewport().get_mouse_position()
		tooltip_label.position = mouse_pos + Vector2(10, 10)
		tooltip_bg.position = mouse_pos + Vector2(10, 10)
		
func _on_button_hovered() -> void:
	print("Tooltip text: ", tooltip_txt)
	title_label.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	_make_custom_tooltip(tooltip_txt)
	tooltip_active = true

func _on_button_exited() -> void:
	title_label.mouse_default_cursor_shape = Control.CURSOR_ARROW
	_remove_tooltip()
	tooltip_active = false

func _make_custom_tooltip(for_text: String) -> Object:
	tooltip_label = Label.new()
	tooltip_bg = ColorRect.new()

	tooltip_label.text = for_text
	tooltip_label.modulate = Color(0, 0, 0)
	#TODO: hacer flex
	tooltip_bg.size = tooltip_label.size + Vector2(800,30)
	tooltip_bg.set_color(Color(1.0, 1.0, 1.0, 1.0))
	var canvas_layer = CanvasLayer.new()
	get_tree().root.add_child(canvas_layer)
	canvas_layer.add_child(tooltip_bg)
	canvas_layer.add_child(tooltip_label)

	return tooltip_label

func _remove_tooltip() -> void:
	if tooltip_label:
		tooltip_label.queue_free()
	if tooltip_bg:
		tooltip_bg.queue_free()
	tooltip_label = null
	tooltip_bg = null
