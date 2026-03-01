extends Node

signal player_list_set
signal player_added(player_info:Dictionary)
signal player_removed(id:int)


var _players:Dictionary[int,Dictionary]

func set_player_list(player_list:Dictionary[int,Dictionary]):
	_players=player_list
	player_list_set.emit()

func add_player(player_info:Dictionary):
	_players[player_info["id"]]=player_info
	player_added.emit(player_info)

func remove_player(id:int):
	_players.erase(id)
	player_removed.emit(id)

func get_player_list()->Dictionary[int,Dictionary]:
	return _players
