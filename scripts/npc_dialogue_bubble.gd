extends CanvasLayer
class_name NPC_Dialogue_Bubble

var bubble_text: String = "Ese día tomé el transporte a las [b][url=horario_trasporte]8 AM[/url][/b]. Estaba llegando tarde a la [b][url=lugar_trabajo]fabrica de embutidos[/url][/b]"

var hint_references : Dictionary = {
	"horario_trasporte": {
		"id": "horario_trasporte",
		"display_value": "8 AM",
		"tooltip": "El horario en que se tomo el trasporte, justo una hora antes de su hora de ingreso."
	},
	"lugar_trabajo": {
		"id": "lugar_trabajo",
		"display_value": "Fabrica de embutidos",
		"tooltip": "Chacinados ricos S.A. una fabrica que queda a 25km de la casa del trabajador"
	}
}

@onready var notes_sidebar = %NotesPanel

func _ready():
	var rtl = $MarginContainer/RichTextLabel
	rtl.bbcode_enabled = true
	rtl.bbcode_text = bubble_text
	rtl.meta_clicked.connect(_on_meta_clicked)

func _on_meta_clicked(meta: String) -> void:
	if not hint_references.has(meta):
		print("Key no existe en las pistas :c :", meta)
		return
	
	var ref = hint_references[meta]
	var rtl = $MarginContainer/RichTextLabel
	rtl.bbcode_text = bubble_text.replace(
		"[url=%s]%s[/url]" % [meta, ref.display_value],
		"[color=blue][url=%s]%s[/url][/color]" % [meta, ref.display_value]
	)
	
	await get_tree().create_timer(0.3).timeout
	rtl.bbcode_text = bubble_text
	notes_sidebar.add_note(ref)
