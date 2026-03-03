extends VBoxContainer

@onready var role_container:RoleSettingContainer = $RoleContainer

func _ready():
	remove_child(role_container)
	for role:RoleController.Roles in RoleController.role_info.keys():
		var new_node:RoleSettingContainer = role_container.duplicate()
		new_node.role=role
		add_child(new_node)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
