extends NameList
class_name ColoredNameList


@export var styleboxes:Dictionary[String,StyleBox]
@export var style_paths:Dictionary[String,String]
var _style_checks_array:Array[Callable] = []

func _add_stylebox(element:Control, key:String):
	element.add_theme_stylebox_override(style_paths[key],styleboxes[key])

func _coloration_check(new_node:Control):
	for check in _style_checks_array:
		var style_key = check.call(new_node)
		if style_key:
			_add_stylebox(new_node,style_key)

func _ready() -> void:
	super._ready()
	name_added.connect(_coloration_check)
	
