class_name Estado_Caminar
extends Estado

@export var velocidad_mover : float = 151.0

@onready var quieta: Estado_Quieta = $"../Quieta" as Estado
@onready var aire: Estado = $"../Aire" as Estado
@onready var cayendo: Estado_Saltar = $"../Cayendo"

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	jugador.actualizarAnimacion("Caminar")

#Que pase cuando el jugador sale del estado
func salir() -> void:
	pass

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> Estado:
	if jugador.direccion == Vector2.ZERO:
		jugador.velocity.x = move_toward(jugador.velocity.x, 0, jugador.RAPIDEZ)
		return quieta
	jugador.velocity = jugador.direccion*velocidad_mover
	
	if jugador.asignarDireccion():
		jugador.actualizarAnimacion("Caminar")
	
	if (Input.is_action_just_pressed("saltar") ||
		Input.is_action_just_pressed("arriba")):
		return aire
	
	if !jugador.is_on_floor():
		return cayendo
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> Estado:
	return null

#Que pasa con los eventos del estado
func manejarInput (_evento: InputEvent) -> Estado:
	return null
