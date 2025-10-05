extends Button
class_name DialogueButton

@export var button_type: String = ""

func _on_pressed() -> void:
	var npc_dialogue_bubble = get_node("/root/Main/NPC_Dialogue_Bubble")
	
	if npc_dialogue_bubble != null:
		npc_dialogue_bubble._on_button_pressed(button_type)
	else:
		print("No hay globo de dialogo instanciado")
	pass
