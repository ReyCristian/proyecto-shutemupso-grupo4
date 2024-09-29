extends Node

enum texturas_personaje {
	CHARACTER_BASE,
	ARCHER_GREEN,
	ARCHER_PURPLE,
	HUMAN_SOLDIER_CYAN,
	HUMAN_SOLDIER_RED,
	HUMAN_WORKER_CYAN,
	HUMAN_WORKER_RED,
	MAGE_CYAN,
	MAGE_RED,
	ORC_GRUNT,
	ORC_PEON_CYAN,
	ORC_PEON_RED,
	ORC_SOLDIER_CYAN,
	ORC_SOLDIER_RED,
	SOLDIER_BLUE,
	SOLDIER_RED,
	SOLDIER_YELLOW,
	WARRIOR_BLUE,
	WARRIOR_RED,
	SLIME
}

#lista de texturas para los sprites del personaje
var skin_texturas = {
	ListasTexturas.texturas_personaje.CHARACTER_BASE: "res://Recursos/personajes/Character-Base.png",
	ListasTexturas.texturas_personaje.ARCHER_GREEN: "res://Recursos/personajes/Archer-Green.png",
	ListasTexturas.texturas_personaje.ARCHER_PURPLE: "res://Recursos/personajes/Archer-Purple.png",
	ListasTexturas.texturas_personaje.HUMAN_SOLDIER_CYAN: "res://Recursos/personajes/Human-Soldier-Cyan.png",
	ListasTexturas.texturas_personaje.HUMAN_SOLDIER_RED: "res://Recursos/personajes/Human-Soldier-Red.png",
	ListasTexturas.texturas_personaje.HUMAN_WORKER_CYAN: "res://Recursos/personajes/Human-Worker-Cyan.png",
	ListasTexturas.texturas_personaje.HUMAN_WORKER_RED: "res://Recursos/personajes/Human-Worker-Red.png",
	ListasTexturas.texturas_personaje.MAGE_CYAN: "res://Recursos/personajes/Mage-Cyan.png",
	ListasTexturas.texturas_personaje.MAGE_RED: "res://Recursos/personajes/Mage-Red.png",
	ListasTexturas.texturas_personaje.ORC_GRUNT: "res://Recursos/personajes/Orc-Grunt.png",
	ListasTexturas.texturas_personaje.ORC_PEON_CYAN: "res://Recursos/personajes/Orc-Peon-Cyan.png",
	ListasTexturas.texturas_personaje.ORC_PEON_RED: "res://Recursos/personajes/Orc-Peon-Red.png",
	ListasTexturas.texturas_personaje.ORC_SOLDIER_CYAN: "res://Recursos/personajes/Orc-Soldier-Cyan.png",
	ListasTexturas.texturas_personaje.ORC_SOLDIER_RED: "res://Recursos/personajes/Orc-Soldier-Red.png",
	ListasTexturas.texturas_personaje.SOLDIER_BLUE: "res://Recursos/personajes/Soldier-Blue.png",
	ListasTexturas.texturas_personaje.SOLDIER_RED: "res://Recursos/personajes/Soldier-Red.png",
	ListasTexturas.texturas_personaje.SOLDIER_YELLOW: "res://Recursos/personajes/Soldier-Yellow.png",
	ListasTexturas.texturas_personaje.WARRIOR_BLUE: "res://Recursos/personajes/Warrior-Blue.png",
	ListasTexturas.texturas_personaje.WARRIOR_RED: "res://Recursos/personajes/Warrior-Red.png",
	ListasTexturas.texturas_personaje.SLIME: "res://Recursos/personajes/Slime.png"
}


# Lista de texturas que usan el set de animaciones 2
const lista_texturas_animacion2 = [
	ListasTexturas.texturas_personaje.CHARACTER_BASE,
	ListasTexturas.texturas_personaje.ARCHER_GREEN,
	ListasTexturas.texturas_personaje.ARCHER_PURPLE,
	ListasTexturas.texturas_personaje.SOLDIER_YELLOW,
	ListasTexturas.texturas_personaje.SOLDIER_BLUE,
	ListasTexturas.texturas_personaje.SOLDIER_RED,
	ListasTexturas.texturas_personaje.WARRIOR_BLUE,
	ListasTexturas.texturas_personaje.WARRIOR_RED,
	ListasTexturas.texturas_personaje.MAGE_CYAN,
	ListasTexturas.texturas_personaje.MAGE_RED
	];

# Lista de texturas que usan el set de animaciones 3
const lista_texturas_animacion3 = [ListasTexturas.texturas_personaje.SLIME]
