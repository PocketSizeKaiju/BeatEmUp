class_name CorazonGUI
extends Control

@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D

var valor: int = 0:
	set(_valor):
		valor = _valor
		actualizar_sprite()

func actualizar_sprite() -> void:
	sprite_2d.frame = valor
