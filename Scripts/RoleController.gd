extends Node
class_name RoleController

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

var role_info:Dictionary[Roles,Dictionary] =  {
	Roles.Villager:{"team":Teams.Village,},
	Roles.Doctor:{"team":Teams.Village,},
	Roles.Beauty:{"team":Teams.Village,},
	Roles.Sherif:{"team":Teams.Village,},
	Roles.Sergant:{"team":Teams.Village,},
	Roles.Detective:{"team":Teams.Village,},
	Roles.Bodyguard:{"team":Teams.Village,},
	Roles.Undying:{"team":Teams.Village,},
	Roles.Sleepwalker:{"team":Teams.Village,},
	Roles.Werewolf:{"team":Teams.Village,},
	Roles.Mafia:{"team":Teams.Mafia,},
	Roles.Boss:{"team":Teams.Mafia,},
	Roles.Informant:{"team":Teams.Mafia,},
	Roles.Maniac:{"team":Teams.Maniac,},
}
