extends RadioColoredNameList


func _ready():
	super._ready()
	_style_checks_array.append_array([
		(func(element:Control): return "isPlayerNormal" if _name_is_player(element) else ""),
		(func(element:Control): return "isPlayerPressed" if _name_is_player(element) else ""),
		(func(element:Control): return "isPlayerHover" if _name_is_player(element) else ""),
	])
	selection_button.pressed.connect(_storing_prev_selection)
	name_added.connect(_doctor_twice_in_a_row_check)

func _player_is_doctor():
	return PlayersManager.get_players()[multiplayer.get_unique_id()]["role"]==RoleController.Roles.Doctor

#region twice in a row checks
var prev_chosen:String = ""
func _storing_prev_selection():
	var chosen:BaseButton = _button_group.get_pressed_button()
	prev_chosen = chosen.name
	
func _doctor_twice_in_a_row_check(element:Control):
	var are_same = element.name == prev_chosen
	if not are_same:
		return
	if prev_chosen != ConnectionManager.player_info["name"] and ConnectionManager.game_settings.get_flag(Settings.Flags.Doctor_can_heal_twice):
		return
	element.disabled=true
#endregion
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
