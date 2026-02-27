extends Node



signal peer_connected(peer_id, player_info)
signal peer_disconnected(peer_id)
signal server_disconnected

const PORT = 9999

var player_info:Dictionary = {}


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
	return error

func join_game(adress:String):
	if adress.is_empty():
		return FAILED
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(adress,PORT)
	if error == OK:
		peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
		multiplayer.multiplayer_peer = peer
	return error

func disconnect_player():
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	GameManager.players.clear()

func _on_peer_connected(id:int):
	print("Peer connected: ",id)

func _on_peer_disconnected(id:int):
	remove_peer(id)
	peer_disconnected.emit(id)
	print("peer disconnected: ",id)

func _on_connected_to_server():
	player_info["id"]= multiplayer.get_unique_id()
 
	_send_player_information.rpc_id(1,player_info)
	print(player_info["name"]," connected to server :)")

func _on_connection_failed():
	print("Connection failed :(")

func _on_server_disconnected():
	print("Server Disconnected :(((")

 
@rpc("any_peer","call_remote")
func _send_player_information(sender_info:Dictionary):
	var sender_id = sender_info["id"]
	if not GameManager.players.has(sender_id):
		GameManager.players[sender_id] = sender_info
	if multiplayer.is_server():
		for peer_info in GameManager.players.values():
			_send_player_information.rpc(peer_info)
		 


func remove_peer(id:int):
	GameManager.players.erase(id)

func set_local_name(player_name:String):
	player_info["name"] = player_name
