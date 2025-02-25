extends Panel

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay as Sprite2D

func actualizar(slot: InvSlot) -> void:
	if !slot.item:
		item_display.visible = false
	else:
		item_display.visible = true
		item_display.texture = slot.item.textura
