extends Control


@export var role:RoleController.Roles :
	set(x): role=x;

@onready var background = $Background
@onready var role_name = %Name
@onready var icon = %Icon
@onready var team = %Team
@onready var short_disc = %ShortDisc
@onready var long_disc = %LongDisc


func _ready():
	load_role()

func load_role():
	var role_info:RoleInfo = RoleController.role_info[role]["role info"]
	role_name.text = await role_info.get_text(role_info.role_name)
	icon.texture = role_info.icon
	short_disc.text = await role_info.get_text(role_info.short_info)
	long_disc.text = await role_info.get_text(role_info.long_info)
