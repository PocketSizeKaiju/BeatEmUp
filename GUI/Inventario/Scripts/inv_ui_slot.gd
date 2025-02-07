extends Panel

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay as Sprite2D

func _ready() -> void:
	pass 


func _process(_delta: float) -> void:
	pass

func actualizar(item: Item_Inventario) -> void:
	if !item:
		item_display.visible = false
	else:
		item_display.visible = true
		item_display.texture = item.textura
