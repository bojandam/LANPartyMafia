extends Node

signal player_list_set(player_list:Dictionary[int,Dictionary])
signal player_added(player_info:Dictionary)
signal player_removed(player_info:Dictionary)
signal player_list_changed
signal _update_request_finished

var _players:Dictionary[int,Dictionary] #id -> Player
var _players_by_name:Dictionary[String,Dictionary]#name -> Player

func set_player_dict(player_dict:Dictionary[int,Dictionary]):
	_players=player_dict
	for player_info:Dictionary in player_dict.values():
		_players_by_name[player_info["name"]]=player_info
	player_list_set.emit(_players)
	player_list_changed.emit()

func add_player(player_info:Dictionary):
	_players[player_info["id"]]=player_info
	_players_by_name[player_info["name"]]=player_info
	player_added.emit(player_info)
	player_list_changed.emit()

func remove_player(id:int):
	var removed:Dictionary = _players[id]
	_players.erase(id)
	_players_by_name.erase(removed["name"])
	player_removed.emit(removed)
	player_list_changed.emit()

func clear_players():
	_players.clear()
	_players_by_name.clear()
	player_list_set.emit(_players)
	player_list_changed.emit()

func get_player_id(name:String):
	return _players_by_name[name]["id"]

func get_players()->Dictionary[int,Dictionary]:
	return _players

func get_players_by_name()->Dictionary[String,Dictionary]:
	return _players_by_name

func get_player_count():
	return _players.size()

func update_player_list():
	if not multiplayer.is_server():
		request_player_dict.rpc_id(1,multiplayer.get_unique_id())
		await _update_request_finished
		print("update finished")

@rpc("any_peer","call_local")
func request_player_dict(requester_id:int):
	if multiplayer.is_server() and requester_id!=1:
		send_player_name_dict.rpc_id(requester_id,_players_by_name)
		send_player_id_dict.rpc_id(requester_id,_players)


@rpc("authority","call_remote")
func send_player_name_dict(player_name_dict):
	_players_by_name = player_name_dict

@rpc("authority","call_remote")
func send_player_id_dict(player_id_dict):
	_players = player_id_dict
	player_list_set.emit(_players)
	player_list_changed.emit()
	_update_request_finished.emit()
