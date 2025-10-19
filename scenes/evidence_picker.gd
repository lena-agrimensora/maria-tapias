class_name EvidencePicker
extends Control

@onready var q_label = $CanvasLayer/TextureRect/Q_Label
@onready var a_label = $CanvasLayer/TextureRect/A_Label
@onready var ev_label1 = $CanvasLayer/TextureRect/Evidence_Label
@onready var ev_label2 = $CanvasLayer/TextureRect/Evidence_Label2
@onready var ev_label3 = $CanvasLayer/TextureRect/Evidence_Label3


func setup (q_text: String, a_text: String) -> void:
	q_label.text = q_text
	a_label.text = a_text + " porque... "
	pass
