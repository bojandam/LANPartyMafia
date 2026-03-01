extends Node



signal peer_connected(peer_id, player_info)
signal peer_disconnected(peer_id)
signal server_disconnected

const PORT = 9999

var player_info:Dictionary = {}
var prev_ip:String = ""
var is_server = false

func _ready():
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


func host_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT)
	if error == OK:
		peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
		multiplayer.multiplayer_peer = peer
		player_info["id"]=multiplayer.get_unique_id()
		_send_player_information(player_info)
		is_server = true
	return error

func join_game(adress:String):
	if adress.is_empty():
		return FAILED
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(adress,PORT)
	if error == OK:
		peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
		multiplayer.multiplayer_peer = peer
		prev_ip = adress
		is_server = false
	return error

func disconnect_player():
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	PlayersManager.get_player_list().clear()

func _on_peer_connected(id:int):
	print("Peer connected: ",id)

func _on_peer_disconnected(id:int):
	remove_peer(id)
	peer_disconnected.emit(id)
	print("peer disconnected: ",id)

func _on_connected_to_server():
	player_info["id"]= multiplayer.get_unique_id()
	await get_tree().create_timer(.2).timeout
	_send_player_information.rpc(player_info)
	print(player_info["name"]," connected to server :)")

func _on_connection_failed():
	print("Connection failed :(")

func _on_server_disconnected():
	print("Server Disconnected :(((")

 
@rpc("any_peer","call_local")
func _send_player_information(sender_info:Dictionary):
	var sender_id = sender_info["id"]
	if not PlayersManager.get_player_list().has(sender_id):
		PlayersManager.add_player(sender_info)
	if multiplayer.is_server() and sender_info["id"] != multiplayer.get_unique_id():
		_send_servers_player_list.rpc_id(sender_id,PlayersManager.get_player_list())

@rpc("authority")
func _send_servers_player_list(servers_player_list:Dictionary[int,Dictionary]):
	PlayersManager.set_player_list(servers_player_list)

func remove_peer(id:int):
	PlayersManager.remove_player(id)

func set_local_name(player_name:String):
	player_info["name"] = player_name
