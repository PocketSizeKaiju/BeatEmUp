class_name HitBox
extends Area2D

signal Daniado(caja_danio: HurtBox)

func tomarGolpe(caja_danio: HurtBox) -> void:
	Daniado.emit(caja_danio)
