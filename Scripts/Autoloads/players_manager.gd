extends Node

signal player_list_set(player_list:Dictionary[int,Dictionary])
signal player_added(player_info:Dictionary)
signal player_removed(player_info:Dictionary)
signal player_list_changed


var _players:Dictionary[int,Dictionary] #id -> Player


func set_player_dict(player_dict:Dictionary[int,Dictionary]):
	_players=player_dict
	player_list_set.emit(_players)
	player_list_changed.emit()

func add_player(player_info:Dictionary):
	_players[player_info["id"]]=player_info
	player_added.emit(player_info)
	player_list_changed.emit()

func remove_player(id:int):
	var removed:Dictionary = _players[id]
	_players.erase(id)
	player_removed.emit(removed)
	player_list_changed.emit()

func clear_players():
	_players.clear()
	player_list_set.emit(_players)
	player_list_changed.emit()

func get_players()->Dictionary[int,Dictionary]:
	return _players
func get_player_count():
	return _players.size()
