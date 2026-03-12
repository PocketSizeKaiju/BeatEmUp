extends Node

const JUGADOR = preload("res://Jugador/Escenas/jugador.tscn")

var jugador: Jugador
var jugador_invocado: bool = false
var pokes_en_combo: Dictionary = {
	"Combo 1": null,
	"Combo 2": null,
	"Combo 3": null
}

func _ready() -> void:
	if get_tree().get_current_scene().name == "playground":
		invocar_jugador()

func invocar_jugador() -> void:
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

func asignar_poke_a_combo(nombrePoke: String, combo: String) -> void:
	if pokes_en_combo.find_key(nombrePoke):
		var prevCombo = pokes_en_combo.find_key(nombrePoke)
		pokes_en_combo[prevCombo] = pokes_en_combo[combo]
	pokes_en_combo[combo] = nombrePoke
	print(pokes_en_combo)

func desasignar_poke_a_combo(combo: String) -> void:
	pokes_en_combo[combo] = null
	print(pokes_en_combo)
