class_name HitBox
extends Area2D

signal Daniado(caja_danio: HurtBox, impulso: Vector2)

func tomarGolpe(caja_danio: HurtBox, impulso: Vector2 = Vector2.ZERO) -> void:
	#frameFreeze(0.1, 2)
	if impulso == Vector2.ZERO:
		Daniado.emit(caja_danio)
	else:
		Daniado.emit(caja_danio, impulso)

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await(get_tree().create_timer(duration * timeScale).timeout)
	Engine.time_scale = 1.0
