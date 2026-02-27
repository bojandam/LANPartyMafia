extends Node

@onready var MultiplayerController:= %MultiplayerController

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
		%JoinVBoxContainer.hide()
		print("You need to add what comes next")
		UniversalUndoManager.add_action(
			func():
				MultiplayerController.disconnect_player()
				#whatever came next .hide()
				%JoinVBoxContainer.show()
				)
	else:
		print("Failed to host: ",error_string(error))


func _on_join_button_button_down():
	var error = MultiplayerController.join_game("127.0.0.1")
	if error == OK:
		%JoinVBoxContainer.hide()
		print("You need to add what comes next")
		UniversalUndoManager.add_action(
			func():
				MultiplayerController.disconnect_player()
				#whatever came next .hide()
				%JoinVBoxContainer.show()
				)
	else:
		print("Failed to join: ",error_string(error))
	
