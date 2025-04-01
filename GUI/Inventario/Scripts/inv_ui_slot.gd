extends Panel

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay as Sprite2D
@onready var selector: Sprite2D = $CenterContainer/Panel/Selector 

func actualizar(slot: InvSlot) -> void:
	if !slot.item:
		item_display.visible = false
	else:
		item_display.visible = true
		item_display.texture = slot.item.textura

func seleccionar(slot: InvSlot) -> void:
	if !slot.item:
		item_display.visible = false
		selector.visible = false
	else:
		item_display.visible = true
		selector.visible = true

func deseleccionar(slot: InvSlot) -> void:
	selector.visible = false
