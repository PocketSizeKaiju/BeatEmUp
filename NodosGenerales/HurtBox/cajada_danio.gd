class_name HurtBox
extends Area2D

@export var danio: int = 1
var impulso: Vector2

func _ready() -> void:
	area_entered.connect(entroArea)

func entroArea(area: Area2D) -> void:
	if area is HitBox:
		if impulso != Vector2.ZERO:
			area.tomarGolpe(self,impulso)
		else:
			area.tomarGolpe(self)
