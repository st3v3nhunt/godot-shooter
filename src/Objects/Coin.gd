extends Area2D

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_body_entered(body: Node) -> void:
  animation_player.play("fade_out")
