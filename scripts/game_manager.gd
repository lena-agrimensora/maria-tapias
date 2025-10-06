extends Node
class_name GameManager

@onready var npc_dialogue = preload("res://scenes/globo-dialogo.tscn")
@onready var next_button = preload("res://scenes/next_button.tscn")
@onready var previous_button = preload("res://scenes/previous_button.tscn")

@export var phase_name: String

func _on_phase_container_on_container_freed() -> void:
	if npc_dialogue and phase_name == "Exposition":
		var npc_dialogue_instance = npc_dialogue.instantiate()
		npc_dialogue_instance.name = "NPC_Dialogue_Bubble"
		var next_button_instance = next_button.instantiate()
		var previous_button_instance = previous_button.instantiate()
		previous_button_instance.disabled = true
		previous_button_instance.modulate = Color(1, 1, 1, 0.5)
		self.add_child(next_button_instance)
		self.add_child(previous_button_instance)
		self.add_child(npc_dialogue_instance)
	pass
