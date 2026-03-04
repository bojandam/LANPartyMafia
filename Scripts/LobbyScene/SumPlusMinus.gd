extends HBoxContainer

@export var List:Node

@onready var amount = $Amount
@onready var required = $Required
@onready var role_count_warning:Label = %RoleCountWarning
@onready var start_game_button = %StartGameButton
@onready var start_warning = %StartWarning

func refresh():
	List.refresh_sums()
	amount.text = "     " + str(List.ammount_sum) + " /" + str(PlayersManager.get_player_count())
	required.text = "     " + str(List.required_sum) + " /" + str(PlayersManager.get_player_count())
	if List.ammount_sum < PlayersManager.get_player_count():
		role_count_warning.text = "You need to add more roles"
		role_count_warning.label_settings.font_color = Color(0.541, 0.067, 0.047)
		start_game_button.disabled = true
		start_warning.show()
	elif List.required_sum > PlayersManager.get_player_count():
		role_count_warning.text = "You can't have more required roles than players"
		role_count_warning.label_settings.font_color = Color(0.541, 0.067, 0.047)
		start_game_button.disabled = true
		start_warning.show()
	else:
		role_count_warning.text = "You can start the game now : )"
		role_count_warning.label_settings.font_color = Color(0.247, 0.306, 0.31)
		start_game_button.disabled = false
		start_warning.hide()
		
	
func _ready():
	for child:RoleSettingContainer in List.get_children():
		child.ammount_field.value_changed.connect(refresh)
		child.required_field.value_changed.connect(refresh)
	PlayersManager.player_list_changed.connect(refresh)
	refresh()
