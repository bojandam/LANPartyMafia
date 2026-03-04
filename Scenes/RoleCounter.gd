extends HBoxContainer
class_name RoleSettingContainer

@export var role:RoleController.Roles
@export var ColorDict:Dictionary[RoleController.Teams,Color]

var label_settings:LabelSettings

@onready var ammount_field:PlusMinusField = $Ammount
@onready var required_field:PlusMinusField = $Required
@onready var role_info:Dictionary = RoleController.role_info[role]
@onready var label:Label = $RoleText

func _get_info(key,def):
	return role_info[key] if role_info.has(key) else def

func _range_check_ammount(value:int):
	return _get_info("min",0)<=value and value<= _get_info("max",PlayersManager.get_player_count()) 

func _increment_ammount():
	if _range_check_ammount(ammount_field.value+1):
		ammount_field.value+=1
		ammount_field.incremented.emit()

func _decrement_ammount():
	if _range_check_ammount(ammount_field.value-1):
		ammount_field.value-=1
		ammount_field.decremented.emit()

func _increment_required():
	if required_field.value+1 <= ammount_field.value:
		required_field.value+=1
		required_field.incremented.emit()
		
func _ready():
	ammount_field.plus.button_down.disconnect(ammount_field.increment)
	ammount_field.minus.button_down.disconnect(ammount_field.decrement)
	
	ammount_field.plus.button_down.connect(_increment_ammount)
	ammount_field.minus.button_down.connect(_decrement_ammount)	
	
	ammount_field.value= _get_info("default",0)
	
	required_field.plus.button_down.disconnect(required_field.increment)
	required_field.plus.button_down.connect(_increment_required)
	
	
	label.text = str(RoleController.Roles.keys()[role])
	if label_settings:
		label.label_settings = label_settings
		label.label_settings.font_color = ColorDict[role_info["team"]] 
 
