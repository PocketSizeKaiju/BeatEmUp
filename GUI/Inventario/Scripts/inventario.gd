class_name Inventario
extends Resource

signal actualizar_slots

@export var slots: Array[InvSlot]

func insertar(item: Item_Inventario) ->void:
	var slotsLibres = slots.filter(func(slot): return slot.item == null)
	if !slotsLibres.is_empty():
		slotsLibres[0].item = item
	actualizar_slots.emit()
