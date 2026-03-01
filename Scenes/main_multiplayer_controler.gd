extends Node

const PORT = 9999


func _ready():
	if multiplayer.is_server():
		multiplayer.peer_connected.connect(_on_peer_connected)
		multiplayer.peer_disconnected.connect(_on_peer_disconnected)

func disconnect_player():
	multiplayer.set_multiplayer_peer(OfflineMultiplayerPeer.new())

func _on_peer_connected(id:int):
	ConnectionManager.StartGame.rpc_id(id)

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
