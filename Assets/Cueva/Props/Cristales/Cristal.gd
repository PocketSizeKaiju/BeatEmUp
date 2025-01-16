class_name Planta
extends Node2D

@onready var animation_player: AnimationPlayer = $Destrudio/AnimationPlayer

func _ready() -> void:
	animation_player.animation_finished.connect(fueDestruido)
	$HitBox.Daniado.connect(tomoDanio)


func tomoDanio(_hit_box: HurtBox) -> void:
	animation_player.play("Destruir")

func fueDestruido(_nuevoNombreAnimacion: String):
	queue_free()
