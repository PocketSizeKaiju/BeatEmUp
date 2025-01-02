class_name Jugador
extends CharacterBody2D

@onready var label: Label = $Label

# cosas gancho
var pos_gancho = Vector2()
var enganchado = false
var largo_cuerda = 500
var largo_cuerda_actual
# end cosas gancho

signal cambioDireccion(nueva_direccion: Vector2)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var maquina_de_estados: MaquinaDeEstadoJugador = $MaquinaDeEstados as MaquinaDeEstadoJugador
@onready var sprite_2d: Sprite2D = $Sprite2D as Sprite2D

const VELOCIDAD_SALTO = -400.0
const RAPIDEZ = 150.0
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var puntosAtaque = 3;
var direccion_cardinal : Vector2 = Vector2.DOWN
var direccion : Vector2 = Vector2.ZERO


func _ready() -> void:
	# cosas gancho
	largo_cuerda_actual = largo_cuerda
	# end cosas gancho
	
	maquina_de_estados.inicializar(self)

func _process(_delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * _delta
	
	direccion = Vector2(
		Input.get_axis("izquierda", "derecha"),
		Input.get_axis("abajo", "arriba")
	).normalized()

func _physics_process(_delta: float) -> void:
	# cosas gancho
	gancho()
	queue_redraw()
	if enganchado:
		balancear(_delta)
		velocity *= 0.995 #velocidad del balanceo
	# end cosas gancho
	
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
	sprite_2d.scale.x = -1 if direccion_cardinal == Vector2.LEFT else 1
	return true

func actualizarAnimacion(estado: String) -> void:
	print(estado + "_" + direccionAnimacion())
	animation_player.play(estado + "_" + direccionAnimacion())

func direccionAnimacion() -> String:
	if direccion_cardinal == Vector2.RIGHT:
		return "Derecha"
	else:
		return "Izquierda"
	#elif direccion_cardinal == Vector2.DOWN:
	#	return "Abajo"
	#elif direccion_cardinal == Vector2.UP:
	#	return "Arriba"

# cosas gancho
func gancho():
	$Raycast.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("click_izquierdo"):
		pos_gancho = obtener_pos_gancho()
		if pos_gancho:
			enganchado = true
			largo_cuerda_actual = global_position.distance_to(pos_gancho)
	if Input.is_action_just_released("click_izquierdo") and enganchado:
		enganchado = false

func obtener_pos_gancho():
	for raycast in $Raycast.get_children():
		if raycast.is_colliding():
			return raycast.get_collision_point()

func balancear(delta):
	var radio = global_position - pos_gancho
	if velocity.length() < 0.01 or radio.length() < 10: return
	var angulo = acos(radio.dot(velocity) / (radio.length() * velocity.length()))
	var vel_rad = cos(angulo) * velocity.length()
	velocity += radio.normalized() * - vel_rad
	
	if global_position.distance_to(pos_gancho) > largo_cuerda_actual:
		global_position = pos_gancho + radio.normalized() * largo_cuerda_actual
	
	if Input.is_action_pressed("arriba"):
		velocity += (pos_gancho - global_position).normalized() * 15000 * delta
	elif Input.is_action_pressed("abajo"):
		velocity -= (pos_gancho - global_position).normalized() * 15000 * delta
	else:
		var vel_mod = Vector2(2.5, 1)
		velocity *= vel_mod

func _draw() -> void:
	if enganchado:
		draw_line(Vector2(0, -30), to_local(pos_gancho), Color(0.35, 0.7, 0.9), 1, true) #cyan

# end cosas gancho
