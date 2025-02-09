class_name Estado_Atacar_3
extends Estado

var atacando: bool = false

@export var sonido_ataque: AudioStream
@export_range(1, 20, 0.5) var desacelerar_velocidad = 0.5

@onready var moviendose: Estado_Caminar = $"../Moviendose" as Estado
@onready var quieta: Estado_Quieta = $"../Quieta" as Estado

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer" as AnimationPlayer
#@onready var animation_player_ataque: AnimationPlayer = $"../../Sprite2D/EfectoAtaque/AnimationPlayer" as AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D" as AudioStreamPlayer2D
@onready var caja_danio: HurtBox = %HurtBox as HurtBox

@onready var pokes: Node2D = $"../../Pokes"
var railgun = null
var railgueando = false

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	jugador.actualizarAnimacion("Atacando_3")
	#animation_player_ataque.play("atacar_" + jugador.direccionAnimacion())
	animation_player.animation_finished.connect(terminarAtaque)
	jugador.velocity.y = jugador.VELOCIDAD_SALTO*0.6
	
	audio.stream = sonido_ataque
	audio.pitch_scale = randf_range(0.6, 1.1)
	audio.play()
	
	atacando = true
	
	await get_tree().create_timer(0.075).timeout
	caja_danio.monitoring = true

#Que pase cuando el jugador sale del estado
func salir() -> void:
	animation_player.animation_finished.disconnect(terminarAtaque)
	atacando = false
	caja_danio.set_deferred("monitoring", false)

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> Estado:
	if !railgueando:
		jugador.velocity -= jugador.velocity * desacelerar_velocidad * _delta
	else:
		jugador.velocity = Vector2.ZERO
	
	if pokes:
		var joltik = pokes.get_node_or_null("Joltik")
		if Input.is_action_just_pressed("especial") && joltik && !jugador.is_on_floor():
			railgueando = true
			joltik.startRailgun()
			railgun = joltik.get_node_or_null("Railgun")
			railgun.termino_el_railgun.connect(terminar_railgun)
	
	if atacando == false:
		if jugador.direccion == Vector2.ZERO: 
			return quieta
		else:
			return moviendose
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> Estado:
	return null

#Que pasa con los eventos del estado
func manejarInput (_evento: InputEvent) -> Estado:
	return null

func terminarAtaque(_nuevoNombreAnimacion: String) -> void:
	if _nuevoNombreAnimacion.contains("Atacando_3_Cayendo") && jugador.is_on_floor():
		atacando = false
	elif _nuevoNombreAnimacion.contains("Atacando_3"):
		jugador.actualizarAnimacion("Atacando_3_Cayendo")
	else:
		atacando = false

func terminar_railgun() -> void:
	railgueando = false
	railgun.termino_el_railgun.disconnect(terminar_railgun)
