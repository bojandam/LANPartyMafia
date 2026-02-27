extends Node

signal history_changed()
var history:Array[Callable]

func _ready():
	get_tree().quit_on_go_back = false
	get_tree().root.connect("go_back_requested",undo)

func is_histoy_empty()->bool:
	return history.is_empty()

func _quit_on_go_back_check():
	get_tree().quit_on_go_back = not history.is_empty()

func clear_history():
	history.clear()
	history_changed.emit()

func undo():
	if not history.is_empty():
		history[-1].call()
		history.pop_back()
		history_changed.emit()
	else:
		print("Quit on back requestet/ ")

func add_action(function:Callable):
	history.push_back(function)
	history_changed.emit()
	
