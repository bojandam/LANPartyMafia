extends Node

@onready var MultiplayerController:= %MultiplayerController

func _ready():
	%NameVBoxContainer.show()
	%JoinVBoxContainer.hide()
	%LobbyVBoxContainer2.hide()

func _on_enter_name_pressed():
	var inputed_text:String = %NameLineEdit.text
	if not inputed_text:
		print("Enter a name")
		return
	MultiplayerController.set_local_name(inputed_text)
	
	%NameVBoxContainer.hide()
	%JoinVBoxContainer.show()
	
	UniversalUndoManager.add_action(
		func():
			%NameVBoxContainer.show()
			%JoinVBoxContainer.hide()
			)


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
	%JoinVBoxContainer.hide()
	%LobbyVBoxContainer2.show()
	print("You need to add what comes next")
	UniversalUndoManager.add_action(
		func():
			MultiplayerController.disconnect_player()
			%LobbyVBoxContainer2.hide()
			%JoinVBoxContainer.show()
			)
