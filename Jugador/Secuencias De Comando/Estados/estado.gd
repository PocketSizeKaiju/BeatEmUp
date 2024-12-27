class_name Estado
extends Node

static var jugador: Jugador
static var maquina_estados: MaquinaDeEstadoJugador

#Que pasa cuando el estado se crea
func init() -> void:
	pass

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	pass

#Que pase cuando el jugador sale del estado
func salir() -> void:
	pass

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> Estado:
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> Estado:
	return null

#Que pasa con los eventos del estado
func manejarInput (_evento: InputEvent) -> Estado:
	return null
