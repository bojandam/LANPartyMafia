extends Node
class_name UndoButtonHandler

# Called when the node enters the scene tree for the first time.
@onready var parent_button:BaseButton = get_parent()
func _ready():
	parent_button.pressed.connect(UniversalUndoManager.undo)
	UniversalUndoManager.history_changed.connect(visibility_check)
	visibility_check()
	
func visibility_check():
	parent_button.visible = not UniversalUndoManager.is_histoy_empty()
