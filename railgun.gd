extends Node2D

signal termino_el_railgun

const RANGO_MAXIMO = 5000

var grosor_base = 15
var grosor = grosor_base
var disparando = false
var comenzar = false

@onready var line_2d: Line2D = $Line2D as Line2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D as RayCast2D
@onready var the_boi: Sprite2D = $TheBoi as Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $Line2D/HurtBox/CollisionShape2D
@onready var timer: Timer = $Timer as Timer
@onready var entrenador: Jugador = $"../../.." as Jugador

@export var tiempo: float = 2.5

func _process(_delta: float) -> void:
	if comenzar:
		disparando = true
		timer.start(tiempo)
		
		line_2d.width = grosor
		ray_cast_2d.target_position *= RANGO_MAXIMO
		comenzar = false
	
	if disparando:
		collision_shape_2d.shape.b = line_2d.points[1] 
		collision_shape_2d.disabled = false
		visible = true
	
	if ray_cast_2d.is_colliding():
		the_boi.global_position = ray_cast_2d.get_collision_point()
		line_2d.set_point_position(1, line_2d.to_local((the_boi.global_position)))
	else:
		the_boi.global_position = ray_cast_2d.target_position
		line_2d.points[1] = the_boi.global_position

func _cuando_termina_el_tiempo() -> void:
		comenzar = false
		disparando = false
		visible = false
		collision_shape_2d.shape.b = Vector2.ZERO 
		collision_shape_2d.disabled = true
		emit_signal("termino_el_railgun")
