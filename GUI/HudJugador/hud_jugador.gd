extends CanvasLayer

@onready var hp_bar: TextureProgressBar = $HP_Barra/TextureProgressBar as TextureProgressBar
@onready var maximo: Label = $HP_Barra/Max as Label
@onready var actual: Label = $HP_Barra/Actual as Label
@onready var animation_player: AnimationPlayer = $HP_Barra/AnimationPlayer as AnimationPlayer
@onready var retrato: Sprite2D = $HP_Barra/Retrato as Sprite2D

const LLENA:Color = "68f3d2"
const MEDIA:Color = "f2d757"
const OJO:Color = "ea004c"

var porcentaje:float = 100

func _ready() -> void:
	pass

func actualizar_hp(_hp: int, _max_hp: int) -> void:
	if _hp < _max_hp:
		animation_player.play("Hurt")
	hp_bar.value = _hp
	hp_bar.max_value = _max_hp
	
	maximo.text = str(_max_hp)
	actual.text = str(_hp)
	
	porcentaje = (hp_bar.value/hp_bar.max_value) * 100
	if porcentaje >= 50:
		hp_bar.tint_progress = LLENA
	elif porcentaje < 50 && porcentaje > 20:
		hp_bar.tint_progress = MEDIA
	else:
		hp_bar.tint_progress = OJO


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if porcentaje >= 50:
		retrato.frame = 0
	elif porcentaje < 50 && porcentaje > 20:
		retrato.frame = 1
	else:
		retrato.frame = 2
