extends Node


signal _role_finished

enum State{Day,Night}
enum Effects{Rumored, Disabled, Defended, Healed}

var _first_daynight: bool = true
var _effect_tracker:Dictionary[String,Array] # Name -> Array[Effects]
var alive_list: Array[Dictionary] = []

func _ready() -> void:
	alive_list = PlayersManager.get_players_by_name().values()


@rpc("any_peer")
func _add_effect_to_player(effects:Array, player:String):
	if multiplayer.is_server():
		if not _effect_tracker.has(player):
			_effect_tracker[player] =[]
		_effect_tracker[player].append_array(effects)

@rpc("authority","call_local")
func select_player_for_effect(player_list:Array,effects:Array):
	%EffectNameList.generate(player_list)
	%NightWait.hide()
	%EffectSelector.show()
	#to do: Effect Hint
	await %EffectPlayerSelect.pressed
	%EffectSelector.hide()
	%NightWait.show()
	var selection:String = %EffectNameList.selection
	_add_effect_to_player.rpc_id(1,effects,selection)
	_call_role_finished.rpc_id(1)

@rpc("any_peer","call_local")
func _call_role_finished():
	_role_finished.emit()


func has_effect(player:String, effect:Effects):
	return _effect_tracker.has(player) and _effect_tracker[player].has(effect)

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
					select_player_for_effect.rpc_id(PlayersManager.get_player_id(player),
						alive_list,
						[Effects.Disabled,Effects.Healed] if ConnectionManager.game_settings.get_flag(Settings.Flags.Ubavica_heals) else [Effects.Disabled]
						)
					await _role_finished
			RoleController.Roles.Informant:
				for player in players:
					select_player_for_effect.rpc_id(PlayersManager.get_player_id(player),
						alive_list,
						[Effects.Rumored])
			RoleController.Roles.Bodyguard:
				select_player_for_effect.rpc_id(PlayersManager.get_player_id(players[0]),
						alive_list,
						[Effects.Defended])
			RoleController.Roles.Mafia:
				#MultiPlayerSelect(players)
				#SpyVisual(Sleepwalker)
				#Kill(selected)
				pass
			RoleController.Roles.Sherif:
				#SherifScreen
				#SpyVisual(Nacalnik)
				pass
			RoleController.Roles.Detective:
				#select_player_for_action(player_list,discover_team)
				pass
			RoleController.Roles.Boss:
				#select_player_for_action(plaer_list,find_role)
				pass
			RoleController.Roles.Maniac:
				#select_player_for_action(player_lsit,kill)
				pass
		await _role_finished
		#to do: Rest of Night
		pass
