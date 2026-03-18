extends RadioColoredNameList


func _ready():
	super._ready()
	_style_checks_array.append_array([
		(func(element:Control): return "isPlayerNormal" if _name_is_player(element) else ""),
		(func(element:Control): return "isPlayerPressed" if _name_is_player(element) else ""),
		(func(element:Control): return "isPlayerHover" if _name_is_player(element) else ""),
	])

func _name_is_player(element:Control):
	return element.name == ConnectionManager.player_info["name"]

func _name_is_mafia(element:Control):
	var player_role = PlayersManager.get_players_by_name()[element.name]["role"]
	return RoleController.role_info[player_role]["team"] == RoleController.Teams.Mafia

var isMafiaChecksArray = [
		(func(element:Control): return "isMafiaNormal" if _name_is_mafia(element) else ""),
		(func(element:Control): return "isMafiaPressed" if _name_is_mafia(element) else ""),
		(func(element:Control): return "isMafiaHover" if _name_is_mafia(element) else ""),
	]
