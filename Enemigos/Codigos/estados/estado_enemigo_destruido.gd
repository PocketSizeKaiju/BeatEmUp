class_name EstadoEnemigoDestruido
extends EstadoEnemigo

@export var nombre_anim: String = "destruir"
@export var velocidad_noqueado: float = 200.0
@export var desacelerar: float = 20.0

@export_category("AI")

var _direccion: Vector2
var _danio_posicion: Vector2

#Cuando empieza
func init() -> void:
	enemigo.enemigo_destruido.connect(_cuando_enemigo_destruido)

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	enemigo.invulnerable = true
	_direccion = enemigo.global_position.direction_to(_danio_posicion)
	enemigo.asignarDireccion(_direccion)
	enemigo.velocity = _direccion*(-velocidad_noqueado)
	enemigo.actualizarAnimacion(nombre_anim)
	enemigo.animation_player.animation_finished.connect(_cuando_animacion_termino)

#Que pase cuando el jugador sale del estado
func salir() -> void:
	pass

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> EstadoEnemigo:
	enemigo.velocity -= enemigo.velocity*desacelerar*_delta
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> EstadoEnemigo:
	return null

func _cuando_enemigo_destruido(caja_danio: HurtBox) -> void:
	_danio_posicion = caja_danio.global_position
	maquina_estado.cambiarEstado(self)

func _cuando_animacion_termino(_nombre: String) -> void:
	enemigo.queue_free()
