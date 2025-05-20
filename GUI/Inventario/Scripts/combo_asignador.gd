extends CheckBox

@onready var selector: Sprite2D = $Selector
var seleccionado: bool = false

func seleccionar():
	selector.visible = true
	seleccionado = true

func deseleccionar():
	selector.visible = false
	seleccionado = false


func checkear():
	button_pressed = true

func descheckear():
	button_pressed = false
