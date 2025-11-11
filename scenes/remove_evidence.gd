class_name RemoveEvidenceButton
extends Button

@onready var ev_label : Node = get_parent()


func _on_pressed() -> void:
	print("Tengo un interesantisimo ev label: ", ev_label)
	ev_label.hide()
	pass
