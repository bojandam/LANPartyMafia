extends TextureButton
class_name VisibilityButton

@export var parent:Control
@export var show := false
func _ready():
	button_down.connect(func():parent.visible=show)
