class_name Estado_Golpeado
extends Estado

@export var velocidad_knockback : float = 200.0
@export var velocidad_desacelerar : float = 10.0
@export var duracion_invulnerable : float = 1.0

var caja_danio: HurtBox
var direccion: Vector2

var proximo_estado: Estado = null

@onready var quieta: Estado_Quieta = $"../Quieta" as Estado

func init() -> void:
	jugador.jugador_daniado.connect(_jugador_daniado)

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	jugador.f_xs_animation_player.animation_finished.connect(_animacion_termino)
	
	direccion = jugador.global_position.direction_to(caja_danio.global_position)
	jugador.velocity = direccion*(-velocidad_knockback)
	jugador.asignarDireccion()
	
	jugador.actualizarAnimacion("Golpeada")
	jugador.hacer_invulnerable(duracion_invulnerable)
	jugador.f_xs_animation_player.play("danio")

#Que pase cuando el jugador sale del estado
func salir() -> void:
	proximo_estado = null
	jugador.f_xs_animation_player.animation_finished.disconnect(_animacion_termino)

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> Estado:
	jugador.velocity -= jugador.velocity*velocidad_desacelerar*_delta
	return proximo_estado

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> Estado:
	return null

#Que pasa con los eventos del estado
func manejarInput (_evento: InputEvent) -> Estado:
	return null

func _jugador_daniado(_caja_danio: HurtBox) -> void:
	caja_danio = _caja_danio
	maquina_estados.cambiarEstado(self)

func _animacion_termino(_nombre: String) -> void:
	proximo_estado = quieta
