extends RadioColoredNameList


func _ready():
	super._ready()
	_style_checks_array.append_array([
		(func(element:Control): return "isPlayerNormal" if _name_is_player(element) else ""),
		(func(element:Control): return "isPlayerPressed" if _name_is_player(element) else ""),
	])  
	generate(PlayersManager.get_players().values())
	
func _name_is_player(element:Control):
	return element.name == ConnectionManager.player_info["name"]
