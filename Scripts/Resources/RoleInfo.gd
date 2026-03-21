extends Resource
class_name RoleInfo


@export_multiline  var short_info:String
@export_multiline var long_info:String

@export var effect_label:String
@export_multiline var action_hint:String

#region card
@export var role_name:String
@export var icon:Texture
@export var color:Color
#endregion



#region exceptions
@export var rules:Dictionary[Settings.Flags, String]
func get_text(text:String):
	var result := text
	for rule in rules:
		var rule_value = await ConnectionManager.get_rule(rule)
		result = _alter_text(result,'~'+ rules[rule], rule_value)
		result = _alter_text(result,rules[rule], not rule_value)
	return result
	
func _alter_text(text:String,delimiter:String ,drop:bool = true):
	var arr = text.split(delimiter)
	var result:String = ""
	for i in range(0,len(arr),1+ int(drop)):
		result+=arr[i]
	return result
#endregion
