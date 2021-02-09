extends Area2D

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

export var score: = 100

func _on_body_entered(body: Node) -> void:
  picked()

func picked() -> void:
  PlayerData.score += score
  animation_player.play("fade_out")
