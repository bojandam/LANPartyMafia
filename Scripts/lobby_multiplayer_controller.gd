extends Node

const PORT = 9999


func _ready():
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)


func disconnect_player():
	multiplayer.set_multiplayer_peer(OfflineMultiplayerPeer.new())

@rpc("authority")
func _kick():
	UniversalUndoManager.undo()

func host_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT)
	if error == OK:
		peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
		multiplayer.set_multiplayer_peer(peer)
		ConnectionManager.player_info["id"]=multiplayer.get_unique_id()
		if ConnectionManager.game_settings.get_flag(Settings.Flags.Server_is_a_player):
			_send_player_information(ConnectionManager.player_info)
	return error

func join_game(ip:String):
	if ip.is_empty():
		return FAILED
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(ip,PORT)
	if error == OK:
		peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
		multiplayer.set_multiplayer_peer(peer)
	return error

func _on_connected_to_server():
	ConnectionManager.player_info["id"]=multiplayer.get_unique_id()
	await get_tree().create_timer(.2).timeout
	_send_player_information.rpc(ConnectionManager.player_info)

@rpc("any_peer")
func _send_player_information(player_info:Dictionary):
	if player_info["id"] not in PlayersManager.get_players().keys():
		PlayersManager.add_player(player_info)
	if multiplayer.is_server() and player_info["id"]!=1:
		_send_server_player_dict.rpc_id(player_info["id"],PlayersManager.get_players())

@rpc("authority")
func _send_server_player_dict(player_dict):
	PlayersManager.set_player_dict(player_dict)

func _on_peer_disconnected(id:int):
	PlayersManager.remove_player(id)
