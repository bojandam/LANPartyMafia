extends Resource
class_name Settings 

enum Flags{
	Server_is_a_player,
	Potkazuvac_Mafia_to_Village,
	Ubavica_heals,
	Doctor_can_heal_twice,
	Tranee_observes_Sherif,
	Judge_in_play,
	Discussion_timer,
	
}

@export_flags(
	"Server is a player",
	"Potkazuvac Mafia to Village",
	"Ubavica heals",
	"Doctor can heal twice",
	"Tranee observes Sherif",
	"Judge in play",
	"Discussion timer",	
)
var BitFlag:int = 0

func set_flag(flag:Flags):
	BitFlag |= 1<<flag
func clear_flag(flag:Flags):
	BitFlag ^= 1<<flag
func get_flag(flag:Flags)->bool:
	return BitFlag & (1<<flag)
