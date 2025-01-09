class_name Estado_Quieta
extends Estado

@onready var caminar: Node = $"../Moviendose" as Estado
@onready var aire: Node = $"../Aire"
@onready var cayendo: Estado_Saltar = $"../Cayendo"
@onready var atacando: Estado_Atacar = $"../Atacando"

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	jugador.actualizarAnimacion("Quieta")

#Que pase cuando el jugador sale del estado
func salir() -> void:
	pass

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> Estado:
	if (Input.is_action_just_pressed("saltar") ||
	Input.is_action_just_pressed("arriba")):
		return aire
	
	if jugador.direccion != Vector2.ZERO:
		return caminar
	
	if !jugador.is_on_floor():
		return cayendo
	
	if Input.is_action_just_pressed("accion"):
		return atacando
	
	jugador.velocity = Vector2.ZERO
	
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> Estado:
	return null

#Que pasa con los eventos del estado
func manejarInput (_evento: InputEvent) -> Estado:
	return null
