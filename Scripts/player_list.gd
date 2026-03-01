extends GridContainer
class_name NameList

var base_child:Control

func _ready():
	base_child = get_child(0)
	base_child.hide()
	GameManager.player_list_set.connect(refresh)
	GameManager.player_added.connect(add_name)
	GameManager.player_removed.connect(remove_name)

func add_name(player_info:Dictionary):
	var new_item:= base_child.duplicate()
	new_item.text = player_info["name"]
	new_item.name = str(player_info["id"])
	print(new_item.name)
	new_item.show()
	add_child(new_item)
	return new_item
	
func remove_name(id:int):
	var children:Array = get_children()
	for child in children:
		if child.name == str(id):
			child.queue_free()
			return

func refresh():
	var children_list:Array = get_children()
	children_list.pop_front()
	for child:Node in children_list:
		child.queue_free()
	for player_info:Dictionary in GameManager.get_player_list().values():
		add_name(player_info)
