class_name HitBox
extends Area2D

signal Daniado(caja_danio: HurtBox, impulso: Vector2)

func tomarGolpe(caja_danio: HurtBox, impulso: Vector2 = Vector2.ZERO) -> void:
	if impulso == Vector2.ZERO:
		Daniado.emit(caja_danio)
	else:
		Daniado.emit(caja_danio, impulso)
