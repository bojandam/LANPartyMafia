extends Node

enum Effects{Rumored, Disabled, Defended, Healed}
enum Teams{Village,Mafia,Maniac}

	

enum Roles{
	Villager,
	Doctor,
	Beauty,
	Sherif,
	Sergant,
	Detective,
	Bodyguard,
	Undying,
	Sleepwalker,
	Werewolf,
	Mafia,
	Boss,
	Informant,
	Maniac,
}
const role_order:Array[Roles] = [
	Roles.Informant,
	Roles.Beauty,
	Roles.Bodyguard,
	Roles.Doctor,
	Roles.Mafia,
	Roles.Sherif,
	Roles.Detective,
	Roles.Boss,
	Roles.Maniac,
	]
var role_tracker:Dictionary[Roles,Array] = {}
var role_info:Dictionary[Roles,Dictionary] =  {
	Roles.Villager:{"team":Teams.Village,},
	Roles.Doctor:{"team":Teams.Village,"default":1,},
	Roles.Beauty:{"team":Teams.Village,"default":1},
	Roles.Sherif:{"team":Teams.Village,},
	Roles.Sergant:{"team":Teams.Village,"max":1,},
	Roles.Detective:{"team":Teams.Village,"default":1},
	Roles.Bodyguard:{"team":Teams.Village,"max":1,},
	Roles.Undying:{"team":Teams.Village,},
	Roles.Sleepwalker:{"team":Teams.Village,},
	Roles.Werewolf:{"team":Teams.Village,},
	Roles.Mafia:{"team":Teams.Mafia,"default":1,"default required":1},
	Roles.Boss:{"team":Teams.Mafia,},
	Roles.Informant:{"team":Teams.Mafia,},
	Roles.Maniac:{"team":Teams.Maniac,"max":1,},
}
