extends Button
class_name QuestionButton

var question_value: String
var question_id: String

signal on_question_emit

func _on_pressed() -> void:
	print("Test, tengo: ", question_value)
	on_question_emit.emit(question_id)
	pass 
