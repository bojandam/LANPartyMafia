extends Node


signal _role_finished

enum State{Day,Night}
enum Effects{Rumored, Disabled, Defended, Healed}

var _first_daynight: bool = true
var _effect_tracker:Dictionary[String,Array] # Name -> Array[Effects]
var alive_list: Array[Dictionary] = []

var _healing_tracker:Dictionary[String,String] = {}

@onready var effect_name_list = %EffectNameList



func _ready() -> void:
	alive_list = PlayersManager.get_players_by_name().values()


func _player_has_effect(player,effect):
	return _effect_tracker.has(player) and _effect_tracker[player].has(effect)


@rpc("any_peer","call_local")
func _add_effect_to_player(effects:Array, player:String, sender:String):
	if multiplayer.is_server():
		if not _effect_tracker.has(player):
			_effect_tracker[player] =[]
		if not _player_has_effect(sender,Effects.Disabled):
			_effect_tracker[player].append_array(effects)
	if OS.is_debug_build():
		%DebugTable.show()
		%DebugTable.genarate(alive_list)


@rpc("authority","call_local")
func select_player_for_effect(player_list:Array,effects:Array,role:RoleController.Roles, show_mafia:bool=false):
	await PlayersManager.update_player_list()
	print("effect continued")
	#await get_tree().create_timer(.1).timeout
	%EffectSelector.load_role(role)
	if show_mafia:
		effect_name_list.push_coloration_front(effect_name_list.isMafiaChecksArray)
	effect_name_list.generate(player_list)
	
	%NightWait.hide()
	%EffectSelector.show()
	
	await %EffectPlayerSelect.pressed
	%EffectSelector.hide()
	if show_mafia:
		effect_name_list.pop_coloration_check_front(len(effect_name_list.isMafiaChecksArray))
	%NightWait.show()
	var selection:String = effect_name_list.selection
	_add_effect_to_player.rpc_id(1,effects,selection,ConnectionManager.player_info["name"])
	_call_role_finished.rpc_id(1)


@rpc("any_peer","call_local")
func _call_role_finished():
	_role_finished.emit()


func has_effect(player:String, effect:Effects):
	return _effect_tracker.has(player) and _effect_tracker[player].has(effect)

#region role actions
func _get_playerless_alive_list(player):
	var list = alive_list.duplicate()
	list.erase(PlayersManager.get_players_by_name()[player])
	return list
	
func _remove_team_from_array(array:Array, team):
	var to_erase = []
	for player in array:
		if RoleController.role_info[player["role"]]["team"] == team:
			to_erase.push_back(player)
	for val in to_erase:
		array.erase(val)
	return array

func _beaty_action(player:String):
	var effects_list = [Effects.Disabled,Effects.Healed]
	if not ConnectionManager.game_settings.get_flag(Settings.Flags.Ubavica_heals):
		effects_list = [Effects.Disabled]
	select_player_for_effect.rpc_id(PlayersManager.get_player_id(player),
		_get_playerless_alive_list(player),
		effects_list,
		RoleController.Roles.Beauty)

func _informant_action(player:String):
	var can_switch_mafia_flag = ConnectionManager.game_settings.Flags.Potkazuvac_Mafia_to_Village
	var list = alive_list.duplicate()
	if not ConnectionManager.game_settings.get_flag(can_switch_mafia_flag):
		_remove_team_from_array(list,RoleController.Teams.Mafia)
	select_player_for_effect.rpc_id(PlayersManager.get_player_id(player),
		list,
		[Effects.Rumored],
		RoleController.Roles.Informant,
		true)

func _bodyguard_action(player:String):
	select_player_for_effect.rpc_id(PlayersManager.get_player_id(player),
		_get_playerless_alive_list(player),
		[Effects.Defended],
		RoleController.Roles.Bodyguard)

func _doctor_action(player:String): 
	select_player_for_effect.rpc_id(PlayersManager.get_player_id(player),
		alive_list,
		[Effects.Healed],
		RoleController.Roles.Doctor)


func _mafia_action(player:String):
	#MultiPlayerSelect(players)
	#SpyVisual(Sleepwalker)
	#Kill(selected)
	pass
func _sherif_action(player:String):
	#SherifScreen
	#SpyVisual(Nacalnik)
	pass
func _detective_action(player:String):
	#select_player_for_action(player_list,discover_team)
	pass
func _boss_action(player:String):
	#select_player_for_action(plaer_list,find_role)
	pass
func _maniac_action(player:String):
	#select_player_for_action(player_lsit,kill)
	pass

#endregion

func run_Night():
	_effect_tracker.clear()
	
	if _first_daynight:
		_first_daynight = false
		pass #to do: first night stuff
	
	for role:RoleController.Roles in RoleController.role_order:
		var players:Array = []
		if RoleController.role_tracker.has(role):
			players = RoleController.role_tracker[role]
		if players.is_empty():
			continue
		match role:
			RoleController.Roles.Beauty:
				for player in players:
					_beaty_action(player)
					await _role_finished
			RoleController.Roles.Informant:
				for player in players:
					_informant_action(player)
					await _role_finished
			RoleController.Roles.Bodyguard:
				_bodyguard_action(players[0])
				await _role_finished
			RoleController.Roles.Doctor:
				_doctor_action(players[0])
				await _role_finished
			RoleController.Roles.Mafia:
				pass
			RoleController.Roles.Sherif:
				pass
			RoleController.Roles.Detective:
				pass
			RoleController.Roles.Boss:
				pass
			RoleController.Roles.Maniac:
				pass
		
		#to do: Rest of Night
		pass
