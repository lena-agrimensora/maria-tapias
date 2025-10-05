extends Node
class_name GameManager

@onready var npc_dialogue: NPC_Dialogue_Bubble = %NPC_Dialogue_Bubble
@onready var next_button = preload("res://scenes/next_button.tscn")
@onready var previous_button = preload("res://scenes/previous_button.tscn")

func _on_phase_container_on_container_freed() -> void:
	print("Momento de hacer aparecer el globo de dialogo 1")
	if npc_dialogue:
		npc_dialogue.show()
		var next_button_instance = next_button.instantiate()
		var previous_button_instance = previous_button.instantiate()
		previous_button_instance.disabled = true
		previous_button_instance.modulate = Color(1, 1, 1, 0.5)
		self.add_child(next_button_instance)
		self.add_child(previous_button_instance)
	pass
