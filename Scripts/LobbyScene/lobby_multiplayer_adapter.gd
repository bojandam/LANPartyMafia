extends Node

@onready var MultiplayerController:= %MultiplayerController
@onready var name_screen:Control = %NameVBoxContainer
@onready var server_screen:Control = %JoinVBoxContainer
@onready var lobby_screen:Control = %LobbyVBoxContainer

func _ready():
	name_screen.show()
	server_screen.hide()
	lobby_screen.hide()

func _on_enter_name_pressed():
	var inputed_text:String = %NameLineEdit.text
	if not inputed_text:
		print("Enter a name")
		return
	ConnectionManager.player_info["name"] = inputed_text
	
	name_screen.hide()
	server_screen.show()
	
	UniversalUndoManager.add_action(func(): name_screen.show();server_screen.hide())


func _on_host_button_button_down():
	var error = MultiplayerController.host_game()
	if error == OK:
		_after_connection_work()
	else:
		print("Failed to host: ",error_string(error))

func _on_join_button_button_down():
	var error = MultiplayerController.join_game("127.0.0.1")
	if error == OK:
		_after_connection_work()
	else:
		print("Failed to join: ",error_string(error))

func _after_connection_work():
	server_screen.hide()
	lobby_screen.show()
	if multiplayer.is_server():
		%StartGameButton.show()
	print("You need to add what comes next")
	UniversalUndoManager.add_action(
		func():
			MultiplayerController.disconnect_player()
			lobby_screen.hide()
			%JoinVBoxContainer.show()
			%StartGameButton.hide()
			)


@rpc("authority","call_local")
func StartGame():
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")



func _on_start_game_button_button_up() -> void:
	StartGame.rpc()
