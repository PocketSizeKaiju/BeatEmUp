extends Control

@onready var inv = preload("res://GUI/Inventario/Daru_Inventario.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()


var esta_abierto = false

func _ready() -> void:
	actualizar_slots()
	cerrar()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if esta_abierto:
			cerrar()
		else:
			abrir()

func cerrar() -> void:
	visible = false
	esta_abierto = false

func abrir() -> void:
	visible = true
	esta_abierto = true

func actualizar_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].actualizar(inv.items[i])
