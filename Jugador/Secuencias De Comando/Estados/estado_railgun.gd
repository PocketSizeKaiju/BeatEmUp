class_name Railgun
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
var joltik = null
var railgun = null

#Que pasa cuando el jugador entra este estado
func entrar() -> void:
	jugador.actualizarAnimacion("Railgun_Empieza")
	#animation_player_ataque.play("atacar_" + jugador.direccionAnimacion())
	animation_player.animation_finished.connect(terminarAtaque)
	
	audio.stream = sonido_ataque
	audio.pitch_scale = randf_range(0.6, 1.1)
	audio.play()
	
	atacando = true
	
	if pokes:
		joltik = pokes.get_node_or_null("Joltik")
		if joltik:
			railgun = joltik.get_node_or_null("Railgun")
			railgun.termino_el_railgun.connect(terminar_railgun)

#Que pase cuando el jugador sale del estado
func salir() -> void:
	animation_player.animation_finished.disconnect(terminarAtaque)
	railgun.termino_el_railgun.disconnect(terminar_railgun)
	atacando = false
	caja_danio.monitoring = false

#Que pasa durante el _process update del estado
func proceso( _delta: float) -> Estado:
	if pokes:
		joltik = pokes.get_node_or_null("Joltik")

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
	if _nuevoNombreAnimacion.contains("Railgun_Empieza"):
		joltik.startRailgun()
		jugador.actualizarAnimacion("Railgun_Tirando")
	else:
		atacando = false

func terminar_railgun() -> void:
		jugador.actualizarAnimacion("Railgun_Termina")
