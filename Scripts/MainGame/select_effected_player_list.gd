extends NameList

signal selection_changed(button:BaseButton)

@export var styles:Dictionary[String,StyleBox]

var selection:String = ""
var _button_group:ButtonGroup

func _ready() -> void:
	super._ready()
	_button_group = _base_children[0].button_group
	_button_group.pressed.connect(_on_button_pressed)
	generate(PlayersManager.get_players().values())

func _on_button_pressed(button:BaseButton):
	var new_selection: String = button.text
	if new_selection != selection:
		selection = new_selection
		selection_changed.emit(selection)

func generate(names_list:Array[Dictionary]):
	refresh(names_list)
