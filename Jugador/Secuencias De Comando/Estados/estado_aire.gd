class_name Estado_Cayendo
extends Estado

@onready var quieta: Estado_Quieta = $"../Quieta"
@onready var moviendose: Estado_Caminar = $"../Moviendose"
@onready var cayendo: Estado_Saltar = $"../Cayendo"
@onready var atacando: Estado_Atacar_2 = $"../Atacando_2"

#Que pasa cuando el estado se crea
func init() -> void:
	pass

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	jugador.velocity.y = jugador.VELOCIDAD_SALTO
	jugador.actualizarAnimacion("Saltar")

#Que pase cuando el jugador sale del estado
func salir() -> void:
	pass

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> Estado:
	jugador.velocity.x = move_toward(jugador.velocity.x, 0, jugador.RAPIDEZ)
	jugador.velocity.x = jugador.direccion.x*moviendose.velocidad_mover
	jugador.move_and_slide()
	
	if Input.is_action_just_pressed("accion"):
		return atacando
	
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> Estado:
	if not jugador.is_on_floor():
		jugador.velocity += jugador.get_gravity() * _delta
	
	if !jugador.is_on_floor():
		jugador.velocity.x = jugador.direccion.x * moviendose.velocidad_mover
	
	if jugador.velocity.y > 0:
		return cayendo
	
	if jugador.is_on_floor():
		return quieta
	return null

#Que pasa con los eventos del estado
func manejarInput (_evento: InputEvent) -> Estado:
	return null
