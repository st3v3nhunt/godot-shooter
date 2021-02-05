extends Actor

func _ready() -> void:
  _velocity.x = -speed.x

func _physics_process(delta: float) -> void:
  _velocity.x *= -1.0 if is_on_wall() else 1.0
  _velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y