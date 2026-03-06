extends CheckBox

@onready var selector: Sprite2D = $Selector
@onready var nombre: RichTextLabel = $"../../Nombre"
var seleccionado: bool = false

func seleccionar():
	selector.visible = true
	seleccionado = true

func deseleccionar():
	selector.visible = false
	seleccionado = false


func checkear():
	AdministradorGlobalJugador.asignar_poke_a_combo(nombre.text, text)
	button_pressed = true

func descheckear():
	AdministradorGlobalJugador.desasignar_poke_a_combo(text)
	button_pressed = false
