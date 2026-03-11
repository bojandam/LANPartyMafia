extends Node


func _ready():
	if multiplayer.is_server():
		_assign_roles()
		#to:do show role
		#start night

func _assign_roles():
	var roles_selected:Array[RoleController.Roles]
	var selection_range:Array[RoleController.Roles]
	if multiplayer.is_server():
		for role in RoleController.role_info.keys():
			if RoleController.role_info[role].has("required"):
				for i in range(RoleController.role_info[role]["required"]):
					roles_selected.append(role)
		for role in RoleController.role_info.keys():
			if RoleController.role_info[role].has("ammount"):
				for i in range(RoleController.role_info[role]["ammount"]-RoleController.role_info[role]["required"]):
					selection_range.append(role)
	selection_range.shuffle()
	while roles_selected.size() < PlayersManager.get_player_count():
		roles_selected.append(selection_range.pop_front())
	roles_selected.shuffle()
	for player:Dictionary in PlayersManager.get_players().values():
		var role:RoleController.Roles = roles_selected.pop_front()
		player["role"] = role
		if not RoleController.role_tracker.has(role):
			RoleController.role_tracker[role] = []
		RoleController.role_tracker[role].push_back(player["name"])
