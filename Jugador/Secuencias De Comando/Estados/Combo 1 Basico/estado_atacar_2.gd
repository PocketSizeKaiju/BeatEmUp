class_name Estado_Atacar_2
extends Estado

var atacando: bool = false
var continuar_combo: bool = false

@export var sonido_ataque: AudioStream
@export_range(1, 20, 0.5) var desacelerar_velocidad = 0.5

@onready var moviendose: Estado_Caminar = $"../Moviendose" as Estado
@onready var quieta: Estado_Quieta = $"../Quieta" as Estado
@onready var atacando_3: Estado_Atacar_3 = $"../Atacando_3"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer" as AnimationPlayer
#@onready var animation_player_ataque: AnimationPlayer = $"../../Sprite2D/EfectoAtaque/AnimationPlayer" as AnimationPlayer
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D" as AudioStreamPlayer2D
@onready var caja_danio: HurtBox = %HurtBox as HurtBox


#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	jugador.actualizarAnimacion("Atacando_2_Empieza")
	#animation_player_ataque.play("atacar_" + jugador.direccionAnimacion())
	animation_player.animation_finished.connect(terminarAtaque)
	
	audio.stream = sonido_ataque
	audio.pitch_scale = randf_range(0.9, 1.5)
	audio.play()
	
	atacando = true
	
	await get_tree().create_timer(0.075).timeout
	caja_danio.monitoring = true
	caja_danio.impulso = Vector2(0, 0.5)

#Que pase cuando el jugador sale del estado
func salir() -> void:
	animation_player.animation_finished.disconnect(terminarAtaque)
	atacando = false
	caja_danio.monitoring = false

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> Estado:
	jugador.velocity -= jugador.velocity * desacelerar_velocidad * _delta
	
	if atacando == false:
		if continuar_combo:
			continuar_combo = false
			return atacando_3
		if jugador.direccion == Vector2.ZERO: 
			continuar_combo = false
			return quieta
		else:
			return moviendose
	return null

#Que pasa durante el  _physics_process update del estado
func fisica (_delta: float) -> Estado:
	return null

#Que pasa con los eventos del estado
func manejarInput (_evento: InputEvent) -> Estado:
	if Input.is_action_just_pressed("accion"):
		continuar_combo = true
	return null

func terminarAtaque(_nuevoNombreAnimacion: String) -> void:
	if _nuevoNombreAnimacion.contains("Atacando_2_Empieza"):
		jugador.actualizarAnimacion("Atacando_2_Patada")
		jugador.velocity.y = jugador.VELOCIDAD_SALTO*0.6
	else:
		atacando = false
