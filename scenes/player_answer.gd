extends Button
class_name PlayerAnswer

@onready var id
@onready var is_correct
@onready var right_hints
@onready var wrong_hints
@onready var hints_ref
@onready var q_ref

signal on_answer_emit

func _on_pressed() -> void:
	on_answer_emit.emit([id, q_ref, is_correct, right_hints, wrong_hints, hints_ref])
	pass
