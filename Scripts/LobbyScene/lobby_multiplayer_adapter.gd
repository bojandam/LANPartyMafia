extends Node

@onready var MultiplayerController:= %MultiplayerController
@onready var name_screen:Control = %NameVBoxContainer
@onready var server_screen:Control = %JoinVBoxContainer
@onready var lobby_screen:Control = %LobbyVBoxContainer

func _ready():
	get_tree().call_group("hidden","hide")
	get_tree().call_group("shown","show")
	
func _on_enter_name_pressed():
	var inputed_text:String = %NameLineEdit.text
	if not inputed_text:
		print("Enter a name")
		return
	ConnectionManager.player_info["name"] = inputed_text
	
	name_screen.hide()
	server_screen.show()
	
	UniversalUndoManager.add_action(func(): name_screen.show();server_screen.hide())

@rpc("authority")
func correct_name(new_name:String):
	ConnectionManager.player_info["name"] = new_name
	
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
		%StartSection.show()
	print("You need to add role selection")
	UniversalUndoManager.add_action(
		func():
			MultiplayerController.disconnect_player()
			lobby_screen.hide()
			%JoinVBoxContainer.show()
			%StartSection.hide()
			%SettingsButton.hide()
			)

func _on_start_game_button_button_up() -> void:
	ConnectionManager.StartGame.rpc()
