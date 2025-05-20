extends Control

@onready var inv = preload("res://GUI/Inventario/Recursos/Daru_Inventario.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var poke_desc: NinePatchRect = $PokeDesc
@onready var combo_selector: GridContainer = $PokeDesc/ComboSelector

var seleccionando_combos = false
var esta_abierto = false

func _ready() -> void:
	inv.actualizar_slots.connect(actualizar_slots)
	actualizar_slots()
	cerrar()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Menu"):
		if esta_abierto:
			cerrar()
		else:
			abrir()

func cerrar() -> void:
	visible = false
	esta_abierto = false
	poke_desc.visible = false
	get_tree().paused = false

func abrir() -> void:
	visible = true
	esta_abierto = true
	get_tree().paused = true

func actualizar_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].actualizar(inv.slots[i])

func _input(event: InputEvent) -> void:
	if esta_abierto:
		if event.is_action_pressed("abajo") || event.is_action_pressed("derecha") || event.is_action_pressed("arriba") || event.is_action_pressed("izquierda"):
			if !seleccionando_combos:
				moverse_menu_principal(event)
			else:
				moverse_menu_combos(event)
		if event.is_action_pressed("accion"):
			var current = slots.filter(func(inv): return inv.selector.visible == true )
			if current != []:
				var combosSelectors = combo_selector.get_children()
				if !seleccionando_combos:
					combosSelectors[0].seleccionar()
					seleccionando_combos = true
				else:
					var aCheckear = combosSelectors.filter(func(inv): return inv.selector.visible == true )
					if aCheckear != []:
						var index = combosSelectors.find(aCheckear[0])
						if combosSelectors[index].button_pressed == false:
							for selector in combosSelectors:
								if selector == combosSelectors[index]:
									selector.checkear()
								else:
									selector.descheckear()
						else:
							combosSelectors[index].descheckear()
						seleccionando_combos = false
						combosSelectors[index].deseleccionar()

func mostrar_descripcion(pokemonAMostrar: InvSlot) -> void:
	if pokemonAMostrar.item:
		poke_desc.visible = true
		poke_desc.get_child(0).actualizar(pokemonAMostrar)
		poke_desc.get_child(1).text = pokemonAMostrar.item.nombre
	else:
		poke_desc.visible = false

func moverse_menu_principal(event: InputEvent) -> void:
	if event.is_action_pressed("abajo") || event.is_action_pressed("derecha"):
			var current = slots.filter(func(inv): return inv.selector.visible == true )
			if current == []:
				slots[0].seleccionar(inv.slots[0])
				mostrar_descripcion(inv.slots[0])
			else:
				var index = slots.find(current[0])
				if index+1 >= inv.slots.size():
					slots[index].deseleccionar(inv.slots[index])
					slots[0].seleccionar(inv.slots[0])
					mostrar_descripcion(inv.slots[0])
				else:
					slots[index].deseleccionar(inv.slots[index])
					slots[index+1].seleccionar(inv.slots[index+1])
					mostrar_descripcion(inv.slots[index+1])
	elif event.is_action_pressed("arriba") || event.is_action_pressed("izquierda"):
		var current = slots.filter(func(inv): return inv.selector.visible == true)
		if current == []:
			slots[0].seleccionar(inv.slots[0])
			mostrar_descripcion(inv.slots[0])
		else:
			var index = slots.find(current[0])
			if index-1 < 0:
				slots[index].deseleccionar(inv.slots[index])
				slots[0].seleccionar(inv.slots[0])
				mostrar_descripcion(inv.slots[0])
			else:
				slots[index].deseleccionar(inv.slots[index])
				slots[index-1].seleccionar(inv.slots[index-1])
				mostrar_descripcion(inv.slots[index-1])

func moverse_menu_combos(event: InputEvent) -> void:
	if event.is_action_pressed("abajo") || event.is_action_pressed("derecha"):
			var combosSelectors = combo_selector.get_children()
			var current = combosSelectors.filter(func(inv): return inv.selector.visible == true )
			if current == []:
				combosSelectors[0].seleccionar()
			else:
				var index = combosSelectors.find(current[0])
				if index+1 >= combosSelectors.size():
					combosSelectors[index].deseleccionar()
					combosSelectors[0].seleccionar()
				else:
					combosSelectors[index].deseleccionar()
					combosSelectors[index+1].seleccionar()
	elif event.is_action_pressed("arriba") || event.is_action_pressed("izquierda"):
		var combosSelectors = combo_selector.get_children()
		var current = combosSelectors.filter(func(inv): return inv.selector.visible == true )
		if current == []:
			combosSelectors[0].seleccionar()
		else:
			var index = combosSelectors.find(current[0])
			if index-1 < 0:
				combosSelectors[index].deseleccionar()
				combosSelectors[0].seleccionar()
			else:
				combosSelectors[index].deseleccionar()
				combosSelectors[index-1].seleccionar()
