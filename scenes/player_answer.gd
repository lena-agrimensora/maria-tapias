extends Button
class_name PlayerAnswer

@onready var id
@onready var is_correct
@onready var right_hints
@onready var wrong_hints
@onready var hints_ref

func _on_pressed() -> void:
	print("Id: ", id)
	print("Is correct: ", is_correct)
	print("Right Hints: ", right_hints)
	print("Wrong Hints: ", wrong_hints)
	print("all hints: ", hints_ref)
	pass
