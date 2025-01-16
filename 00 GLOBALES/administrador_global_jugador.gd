extends Node

const JUGADOR = preload("res://Jugador/Escenas/jugador.tscn")

var jugador: Jugador
var jugador_invocado: bool = false

func _ready() -> void:
	if get_tree().get_current_scene().name == "playground":
		invocar_jugador()

func invocar_jugador():
	agregar_instancia_jugador()
	await get_tree().create_timer(0.2).timeout
	jugador_invocado = true

func agregar_instancia_jugador() -> void:
	jugador = JUGADOR.instantiate()
	add_child(jugador)

func asignar_posicion_jugador(_nueva_pos: Vector2) -> void:
	if !jugador:
		invocar_jugador()
	jugador.global_position = _nueva_pos

func asignar_como_padre(_padre: Node2D) -> void:
	if jugador.get_parent():
		jugador.get_parent().remove_child(jugador)
	_padre.add_child(jugador)

func desparentar_jugador(_padre: Node2D) -> void:
	_padre.remove_child(jugador)
