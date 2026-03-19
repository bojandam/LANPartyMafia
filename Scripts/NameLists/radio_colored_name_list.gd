extends ColoredNameList
class_name RadioColoredNameList

signal selection_changed(button:BaseButton)


@export var selection_button:BaseButton

var selection:String = ""
var _button_group:ButtonGroup


func _ready():
	super._ready()
	selection_button.disabled=true
	_button_group = _base_children[0].button_group
	_button_group.pressed.connect(_on_button_pressed)

func _on_button_pressed(button:BaseButton):
	selection_button.disabled= (_button_group.get_pressed_button() == null)
	var new_selection: String = button.text
	if new_selection != selection:
		selection = new_selection
		selection_changed.emit(selection)

func generate(names_list:Array):
	refresh(names_list)
