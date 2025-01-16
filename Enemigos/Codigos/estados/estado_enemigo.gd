class_name EstadoEnemigo
extends Node

var enemigo: Enemigo
var maquina_estado: MaquinaDeEstadoEnemigo

#Cuando empieza
func init() -> void:
	pass

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	pass

#Que pase cuando el jugador sale del estado
func salir() -> void:
	pass

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> EstadoEnemigo:
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> EstadoEnemigo:
	return null
