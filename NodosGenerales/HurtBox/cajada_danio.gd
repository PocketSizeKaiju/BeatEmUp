class_name HurtBox
extends Area2D

@export var danio: int = 1

func _ready() -> void:
	area_entered.connect(entroArea)

func entroArea(area: Area2D) -> void:
	if area is HitBox:
		area.tomarGolpe(self)
