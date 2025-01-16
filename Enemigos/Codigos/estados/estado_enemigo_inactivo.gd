class_name EstadoEnemigoInactivo 
extends EstadoEnemigo

@export var nombre_anim: String = "inactivo"
@export_category("AI")
@export var duracion_estado_min: float = 0.5
@export var duracion_estado_max: float = 1.5
@export var despues_estado: EstadoEnemigo

var _temporizador: float = 0.0

#Cuando empieza
func init() -> void:
	pass

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	enemigo.velocity = Vector2.ZERO
	_temporizador = randf_range(duracion_estado_min, duracion_estado_max)
	enemigo.actualizarAnimacion(nombre_anim)

#Que pase cuando el jugador sale del estado
func salir() -> void:
	pass

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> EstadoEnemigo:
	_temporizador -= _delta
	if _temporizador <= 0:
		return despues_estado
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> EstadoEnemigo:
	return null
