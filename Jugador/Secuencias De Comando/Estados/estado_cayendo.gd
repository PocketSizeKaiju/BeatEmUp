class_name Estado_Saltar
extends Estado

@onready var quieta: Estado_Quieta = $"../Quieta"
@onready var moviendose: Estado_Caminar = $"../Moviendose"

#Que pasa cuando el estado se crea
func init() -> void:
	pass

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	jugador.actualizarAnimacion("Cayendo")

#Que pase cuando el jugador sale del estado
func salir() -> void:
	pass

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> Estado:
	jugador.velocity.x = move_toward(jugador.velocity.x, 0, jugador.RAPIDEZ)
	jugador.velocity.x = jugador.direccion.x*moviendose.velocidad_mover
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> Estado:
	if not jugador.is_on_floor():
		jugador.velocity += jugador.get_gravity() * _delta
		jugador.velocity.x = jugador.direccion.x * moviendose.velocidad_mover * 10
	
	if jugador.is_on_floor():
		return quieta
	return null

#Que pasa con los eventos del estado
func manejarInput (_evento: InputEvent) -> Estado:
	return null
