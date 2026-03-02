extends Resource
class_name Settings 

enum Flags{
	Server_is_a_player,
	Potkazuvac_Mafia_to_Village,
	Ubavica_heals,
	Doctor_can_heal_twice,
	Tranee_observes_Sherif,
	Judge_in_play,
}

var discussion_timer_length_in_s:float = 50

var game_message:Dictionary[Flags,String] ={
	Flags.Doctor_can_heal_twice: "The Doctor can heal other players twice in a row.",
	Flags.Potkazuvac_Mafia_to_Village: "The Informant can also make non-villagers look like villagers.",
	Flags.Ubavica_heals: "The person who the Beauty is with cannot die.",
	Flags.Tranee_observes_Sherif:"The Sergant can see what the sherif does.",
	Flags.Judge_in_play:"The Judge is in play.",
	Flags.Server_is_a_player : "The host also plays the game.",
}


@export_flags(
	"Server is a player",
	"Potkazuvac Mafia to Village",
	"Ubavica heals",
	"Doctor can heal twice",
	"Tranee observes Sherif",
	"Judge in play",
)
var BitFlag:int = 0

func set_flag(flag:Flags):
	BitFlag |= 1<<flag
func clear_flag(flag:Flags):
	BitFlag ^= 1<<flag
func get_flag(flag:Flags)->bool:
	return BitFlag & (1<<flag)
func swap_flag(flag:Flags):
	clear_flag(flag) if get_flag(flag) else set_flag(flag)
	print(BitFlag)
