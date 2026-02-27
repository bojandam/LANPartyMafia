extends Node


var local_name:String

func _on_enter_name_pressed():
	var inputed_text:String= %NameLineEdit.text
	if not inputed_text:
		print("Enter a name")
		return	
	local_name = inputed_text
	%NameVBoxContainer.hide()
	%JoinVBoxContainer.show()
	UniversalBackButtonManager.set_back_function((func():
		%NameVBoxContainer.show()
		%JoinVBoxContainer.hide()
		))
