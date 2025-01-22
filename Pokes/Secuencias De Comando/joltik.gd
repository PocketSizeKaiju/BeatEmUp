extends Node2D

@onready var entrenador: Jugador = $"../.." as Jugador
@onready var railgun: Node2D = $Railgun

var pos_gancho = Vector2()
var enganchado = false
var largo_cuerda = 500
var largo_cuerda_actual
var velocidad_balanceo = 0.995

func _ready() -> void:
	largo_cuerda_actual = largo_cuerda

func _physics_process(delta: float) -> void:
	gancho()
	queue_redraw()
	if enganchado:
		balancear(delta)
		entrenador.velocity *=  velocidad_balanceo


func gancho():
	$Raycast.look_at(get_global_mouse_position())	
	if Input.is_action_just_pressed("click_izquierdo"):
		pos_gancho = obtener_pos_gancho()
		if pos_gancho:
			enganchado = true
			largo_cuerda_actual = entrenador.global_position.distance_to(pos_gancho)
	if Input.is_action_just_released("click_izquierdo") and enganchado:
		enganchado = false

func obtener_pos_gancho():
	for raycast in $Raycast.get_children():
		if raycast.is_colliding():
			return raycast.get_collision_point()

func balancear(delta):
	var radio = entrenador.global_position - pos_gancho
	if entrenador.velocity.length() < 0.01 or radio.length() < 10: return
	var angulo = acos(radio.dot(entrenador.velocity) / (radio.length() * entrenador.velocity.length()))
	var vel_rad = cos(angulo) * entrenador.velocity.length()
	entrenador.velocity += radio.normalized() * - vel_rad
	
	if entrenador.global_position.distance_to(pos_gancho) > largo_cuerda_actual:
		entrenador.global_position = pos_gancho + radio.normalized() * largo_cuerda_actual
	
	if Input.is_action_pressed("arriba"):
		entrenador.velocity += (pos_gancho - entrenador.global_position).normalized() * 15000 * delta
	elif Input.is_action_pressed("abajo"):
		entrenador.velocity -= (pos_gancho - entrenador.global_position).normalized() * 15000 * delta
	else:
		entrenador.velocity *= Vector2(2.5, 1)

func _draw() -> void:
	if enganchado:
		draw_line(Vector2(0, -30), to_local(pos_gancho), Color(0.35, 0.7, 0.9), 1, true) #cyan

func startRailgun():
	railgun.comenzar = true
