extends HBoxContainer
class_name PlusMinusField

signal incremented
signal decremented
signal value_changed

@export var minimum:int = 0
@export var maximum:int = 32

var max_check:Callable = func(v): return v <= maximum
var min_check:Callable = func(v): return v>= minimum
var value:int = 0:
	set(v):
		label.text=str(v)
		value=v
		value_changed.emit()

@onready var minus:TextureButton = $Minus
@onready var label:Label = $Label
@onready var plus:TextureButton = $Plus



func increment():
	if max_check.call(value+1):
		value+=1
		incremented.emit()

func decrement():
	if min_check.call(value-1):
		value-=1
		decremented.emit()

func check_availability():
	minus.disabled = false if min_check.call(value-1) else true
	plus.disabled = false if max_check.call(value+1) else true

func _ready():
	plus.button_down.connect(increment)
	minus.button_down.connect(decrement)
	value_changed.connect(check_availability)
	check_availability()


 
