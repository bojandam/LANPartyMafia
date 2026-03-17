extends Node

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
	Roles.Beauty,
	Roles.Informant,
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
	Roles.Villager:{"team":Teams.Village,"role info":VILLAGER},
	Roles.Doctor:{"team":Teams.Village,"default":1,"role info":DOCTOR},
	Roles.Beauty:{"team":Teams.Village,"default":1,"role info":BEAUTY},
	Roles.Sherif:{"team":Teams.Village,"role info":SHERIF},
	Roles.Sergant:{"team":Teams.Village,"max":1,"role info":SERGANT},
	Roles.Detective:{"team":Teams.Village,"default":1,"role info":DETECTIVE},
	Roles.Bodyguard:{"team":Teams.Village,"max":1,"role info":BODYGUARD},
	Roles.Undying:{"team":Teams.Village,"role info":UNDYING},
	Roles.Sleepwalker:{"team":Teams.Village,"role info":SLEEPWALKER},
	Roles.Werewolf:{"team":Teams.Village,"role info":WEREWOLF},
	Roles.Mafia:{"team":Teams.Mafia,"default":1,"default required":1,"role info":MAFIA},
	Roles.Boss:{"team":Teams.Mafia,"role info":BOSS},
	Roles.Informant:{"team":Teams.Mafia,"role info":INFORMANT},
	Roles.Maniac:{"team":Teams.Maniac,"max":1,"role info":MANIAC},
}
const BEAUTY = preload("uid://cb5kbpiasbrap")
const BODYGUARD = preload("uid://de2www2tg1bhk")
const BOSS = preload("uid://btfi3jgn2pr3v")
const DETECTIVE = preload("uid://cea5l1x7ig6su")
const DOCTOR = preload("uid://cj58n61dam6ln")
const INFORMANT = preload("uid://dwdub7tdrpwa6")
const MAFIA = preload("uid://dhpugcuqum8fy")
const MANIAC = preload("uid://cnu2k8a6kx75b")
const SERGANT = preload("uid://yt3le2y0hdb6")
const SHERIF = preload("uid://ciy71m7ek7qmc")
const SLEEPWALKER = preload("uid://lwg3dam5sva7")
const UNDYING = preload("uid://cquf1xpppd3gs")
const VILLAGER = preload("uid://c0kprp7o2b4ls") 
const WEREWOLF = preload("uid://bpx37no4p3lh5")
