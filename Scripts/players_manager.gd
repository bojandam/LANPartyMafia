extends Node

signal player_list_set(player_list:Dictionary[int,Dictionary])
signal player_added(player_info:Dictionary)
signal player_removed(player_info:Dictionary)
signal player_reconnected(player_info:Dictionary)



var _players:Dictionary[int,Dictionary] #id -> Player
var _disconnected_players:Dictionary[String,Dictionary] #name -> Player


func set_player_list(player_list:Dictionary[int,Dictionary]):
	_players=player_list
	player_list_set.emit(_players)

func add_player(player_info:Dictionary):
	_players[player_info["id"]]=player_info
	if player_info["name"] in _disconnected_players.keys():
		_disconnected_players.erase(player_info["name"])
		player_reconnected.emit(player_info)
	player_added.emit(player_info)

func remove_player(id:int):
	var removed:Dictionary = _players[id]
	_players.erase(id)
	_disconnected_players[removed["name"]]=removed
	player_removed.emit(removed)

func get_player_list()->Dictionary[int,Dictionary]:
	return _players
func get_disconnected_list()->Dictionary[String,Dictionary]:
	return _disconnected_players
