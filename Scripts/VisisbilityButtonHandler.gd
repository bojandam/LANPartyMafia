extends Node
class_name VisibilityButtonControler

@export var parent:Control
@export var show := false
func _ready():
	self.button_down.connect(func():parent.visible=show)
