extends Button
class_name NoteItem

@export var display_text: String
@export var tooltip_txt: String

var tooltip_label: Label
var tooltip_bg: ColorRect
var tooltip_active: bool = false
var tooltip_canvas_layer: CanvasLayer

var dragging = false
var drag_offset = Vector2()

func _ready() -> void:
	self.mouse_entered.connect(_on_button_hovered)
	self.mouse_exited.connect(_on_button_exited)

	tooltip_canvas_layer = CanvasLayer.new()
	tooltip_canvas_layer.layer = 100
	get_tree().root.add_child(tooltip_canvas_layer)
	
	tooltip_bg = ColorRect.new()
	tooltip_bg.set_color(Color(1.0, 1.0, 1.0, 1.0))
	tooltip_canvas_layer.add_child(tooltip_bg)

	tooltip_label = Label.new()
	tooltip_label.modulate = Color(0, 0, 0)
	tooltip_canvas_layer.add_child(tooltip_label)

	tooltip_label.visible = false
	tooltip_bg.visible = false

func _process(delta: float) -> void:
	if tooltip_active:
		var mouse_pos = get_viewport().get_mouse_position()
		var offset = Vector2(10, 10)
		tooltip_label.position = mouse_pos + offset
		tooltip_bg.position = mouse_pos + offset

func _on_button_hovered() -> void:
	print("Tooltip text: ", tooltip_txt)
	self.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

	if !tooltip_active:
		_show_tooltip(tooltip_txt)
		tooltip_active = true

func _on_button_exited() -> void:
	self.mouse_default_cursor_shape = Control.CURSOR_ARROW
	_hide_tooltip()
	tooltip_active = false

func _show_tooltip(text: String) -> void:
	tooltip_label.text = text
	tooltip_label.visible = true
	tooltip_bg.size = tooltip_label.get_minimum_size() + Vector2(20, 10)
	tooltip_bg.visible = true

func _hide_tooltip() -> void:
	tooltip_label.visible = false
	tooltip_bg.visible = false

func _on_pressed() -> void:
	print("test: ", display_text)
