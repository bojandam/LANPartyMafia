extends Node


var player_info:Dictionary = {}
var game_settings:Settings = preload("uid://c38ae5w4kl8td")

var previous_ip := ""
var was_server:bool = false

#region get rule from server
#signal _rule_resived(rule_value:bool)
#var _checked_rules:Dictionary[Settings.Flags,bool]
func get_rule(rule:Settings.Flags):
	return game_settings.get_flag(rule)
	#if not _checked_rules.has(rule):
		#if not multiplayer or multiplayer.is_server():
			#_checked_rules[rule] = game_settings.get_flag(rule)
		#else:
			#_request_rule.rpc_id(1,rule,multiplayer.get_unique_id())
			#_checked_rules[rule] = await _rule_resived
	#return _checked_rules[rule]
	 #
#@rpc("any_peer","call_local")
#func _request_rule(rule:Settings.Flags,requester:int):
	#_send_rule.rpc_id(requester,game_settings.get_flag(rule))
#@rpc("authority","call_local")
#func _send_rule(rule_value:bool):
	#_rule_resived.emit(rule_value)
#endregion

@rpc("authority","call_local")
func StartGame(rules):
	game_settings.BitFlag = rules
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")
