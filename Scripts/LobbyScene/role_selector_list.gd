extends VBoxContainer

@onready var role_container:RoleSettingContainer = $RoleContainer

var ammount_sum:int = 0
var required_sum:int = 0

func refresh_sums():
	ammount_sum = 0
	required_sum = 0
	for child:RoleSettingContainer in get_children():
		ammount_sum += child.ammount_field.value
		required_sum += child.required_field.value

func _ready():
	remove_child(role_container)
	var label_settings = role_container.label.label_settings
	for role:RoleController.Roles in RoleController.role_info.keys():
		var new_node:RoleSettingContainer = role_container.duplicate()
		new_node.label_settings = label_settings.duplicate()
		new_node.role=role
		new_node.name = str(RoleController.Roles.keys()[role])
		
		add_child(new_node)
		
