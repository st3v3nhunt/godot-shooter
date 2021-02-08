tool
extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer

export var next_scene: PackedScene

func _on_body_entered(body: Node) -> void:
  body.hide()
  teleport()

func _get_configuration_warning() -> String:
  return "Next scene is required" if not next_scene else ""

func teleport() -> void:
  animation_player.play("fade_in")
  yield(animation_player, "animation_finished")
  get_tree().change_scene_to(next_scene)
