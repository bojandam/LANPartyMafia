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
	return _get_info("min",0)<=value and (value<= role_info["max"] if role_info.has("max") else true) 

func _adjust_required():
	while not required_field.max_check.call(required_field.value):
		required_field.decrement()

func _required_max_check(val):
	return val <= min(ammount_field.value, PlayersManager.get_player_count())  
	
func _ready():
	ammount_field.value_changed.connect(func(): role_info["ammount"]=ammount_field.value)
	required_field.value_changed.connect(func(): role_info["required"]=required_field.value)
	
	ammount_field.min_check = _range_check_ammount
	ammount_field.max_check = _range_check_ammount
	required_field.max_check = _required_max_check
	
	PlayersManager.player_list_changed.connect(ammount_field.check_availability)
	PlayersManager.player_list_changed.connect(required_field.check_availability)
	ammount_field.value_changed.connect(required_field.check_availability)
	
	PlayersManager.player_list_changed.connect(_adjust_required)
	ammount_field.decremented.connect(_adjust_required)
	
	ammount_field.value = _get_info("default",0)
	required_field.value = _get_info("default required",0)
	
	ammount_field.check_availability()
	required_field.check_availability()
	
	label.text = str(RoleController.Roles.keys()[role])
	if label_settings:
		label.label_settings = label_settings
		label.label_settings.font_color = ColorDict[role_info["team"]] 
 
