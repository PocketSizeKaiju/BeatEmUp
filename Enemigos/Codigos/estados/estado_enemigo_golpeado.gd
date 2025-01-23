class_name EstadoEnemigoGolpeado
extends EstadoEnemigo

@export var nombre_anim: String = "golpeado"
@export var velocidad_noqueado: float = 150.0
@export var desacelerar: float = 10.0

@export_category("AI")
@export var despues_estado: EstadoEnemigo

var _direccion: Vector2
var _animacion_termino: bool = false
var _danio_posicion: Vector2
var _impulso:Vector2

#Cuando empieza
func init() -> void:
	enemigo.enemigo_daniado.connect(_cuando_enemigo_daniado)

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	enemigo.invulnerable = true
	_animacion_termino = false
	_direccion = enemigo.global_position.direction_to(_danio_posicion)
	if _impulso:
		_direccion *= _impulso
	enemigo.asignarDireccion(_direccion)
	enemigo.velocity = _direccion*(-velocidad_noqueado)
	enemigo.actualizarAnimacion(nombre_anim)
	enemigo.animation_player.animation_finished.connect(_cuando_animacion_termino)

#Que pase cuando el jugador sale del estado
func salir() -> void:
	enemigo.invulnerable = false
	enemigo.animation_player.animation_finished.disconnect(_cuando_animacion_termino)

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> EstadoEnemigo:
	if _animacion_termino == true:
		return despues_estado
	enemigo.velocity -= enemigo.velocity*desacelerar*_delta
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> EstadoEnemigo:
	return null

func _cuando_enemigo_daniado(caja_danio: HurtBox, impulso: Vector2 = Vector2.ZERO) -> void:
	if impulso != Vector2.ZERO:
		_impulso = impulso
	_danio_posicion = caja_danio.global_position
	maquina_estado.cambiarEstado(self)

func _cuando_animacion_termino(_nombre: String) -> void:
	_animacion_termino = true
