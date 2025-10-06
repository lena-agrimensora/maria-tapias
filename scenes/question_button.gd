extends Button
class_name QuestionButton

var question_value: String

func _on_pressed() -> void:
	print("Test, tengo: ", question_value)
	pass 
