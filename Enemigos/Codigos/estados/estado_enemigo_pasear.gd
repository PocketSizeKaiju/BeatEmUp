class_name EstadoEnemigoPasear
extends EstadoEnemigo

@export var nombre_anim: String = "caminar"
@export var velocidad_caminar: float = 20.0

@export_category("AI")
@export var duracion_animacion_estado: float = 0.5
@export var duracion_ciclo_min: int = 1
@export var duracion_ciclo_max: int = 5
@export var despues_estado: EstadoEnemigo

var _temporizador: float = 0.0
var _direccion: Vector2

#Cuando empieza
func init() -> void:
	pass

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	_temporizador = randi_range(duracion_ciclo_max, duracion_ciclo_max)*duracion_animacion_estado
	var rand = randi_range(0, 1)
	_direccion = enemigo.DIR_4[rand]
	enemigo.velocity = _direccion*velocidad_caminar
	enemigo.asignarDireccion(_direccion)
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
