class_name Jugador
extends CharacterBody2D

@onready var label: Label = $Label

signal cambioDireccion(nueva_direccion: Vector2)
signal jugador_daniado(caja_danio: HurtBox)

@export var inventorio: Inventario

@export_category("Stats")
@export var invulnerable: bool = false
@export var hp: int = 6
@export var max_hp: int = 6

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var f_xs_animation_player: AnimationPlayer = $FXs/FXsAnimationPlayer
@onready var maquina_de_estados: MaquinaDeEstadoJugador = $MaquinaDeEstados as MaquinaDeEstadoJugador
@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D
@onready var hit_box: HitBox = $HitBox as HitBox

const VELOCIDAD_SALTO = -500.0
const RAPIDEZ = 150.0
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var puntosAtaque = 3;
var direccion_cardinal : Vector2 = Vector2.RIGHT
var direccion : Vector2 = Vector2.ZERO


func _ready() -> void:
	AdministradorGlobalJugador.jugador = self
	maquina_de_estados.inicializar(self)
	hit_box.Daniado.connect(_tomar_danio)
	actualizar_hp(99)

func _process(_delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * _delta
	
	direccion = Vector2(
		Input.get_axis("izquierda", "derecha"),
		Input.get_axis("abajo", "arriba")
	).normalized()

func _physics_process(_delta: float) -> void:
	move_and_slide()
	label.text = maquina_de_estados.estado_actual.name

func asignarDireccion() -> bool:
	if direccion == Vector2.ZERO:
		return false
	
	var id_direccion: int = int(round((direccion + (direccion_cardinal*0.1)).angle()/TAU*DIR_4.size()))
	var nueva_direccion = DIR_4[id_direccion]
	
	if nueva_direccion == Vector2.DOWN:
		return false
	
	direccion_cardinal = nueva_direccion
	cambioDireccion.emit(direccion_cardinal)
	return true

func actualizarAnimacion(estado: String) -> void:
	print(estado + "_" + direccionAnimacion())
	animation_player.play(estado + "_" + direccionAnimacion())

func direccionAnimacion() -> String:
	if direccion_cardinal == Vector2.RIGHT:
		return "Derecha"
	else:
		return "Izquierda"

func _tomar_danio(caja_danio: HurtBox) -> void:
	if invulnerable == true:
		return
	actualizar_hp(-caja_danio.danio)
	if hp > 0:
		jugador_daniado.emit(caja_danio)
	else:
		jugador_daniado.emit(caja_danio)
		actualizar_hp(99)

func actualizar_hp(delta: int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	HudJugador.actualizar_hp(hp, max_hp)

func hacer_invulnerable(_duracion: float = 1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	await get_tree().create_timer(_duracion).timeout
	invulnerable = false
	hit_box.monitoring = true
