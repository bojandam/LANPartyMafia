extends HBoxContainer
class_name PlusMinusField
signal incremented
signal decremented
signal value_changed(value:int)

@onready var minus:TextureButton = $Minus
@onready var label:Label = $Label
@onready var plus:TextureButton = $Plus

@export var minimum:int = 0
@export var maximum:int = 32

var value:int = 0:
	set(v):
		label.text=str(v)
		value=v
		value_changed.emit(v)

func increment():
	if value+1 <= maximum:
		value+=1
		incremented.emit() 
		
func decrement():
	if value-1 >= minimum:
		value-=1
		decremented.emit()
		
func _ready():
	plus.button_down.connect(increment)
	minus.button_down.connect(decrement)

 
