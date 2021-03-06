extends Actor

export var stomp_impulse = 1500.0
var can_jump: = 0

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
  _velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

# kill player
func _on_EnemyDetector_body_entered(body: Node) -> void:
  die()

func _physics_process(delta: float) -> void:
  can_jump = 10 if is_on_floor() else can_jump - 1
  var is_jump_interrupted: = Input.is_action_just_released("jump") && _velocity.y < 0.0
  var direction: = get_direction()
  _velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
  _velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
  return Vector2(
    Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
    -1.0 if Input.get_action_strength("jump") && (is_on_floor() || can_jump > 0) else 0.0
  )

func calculate_move_velocity(
    linear_velocity: Vector2,
    direction: Vector2,
    speed: Vector2,
    is_jump_interrupted: bool
  ) -> Vector2:
    var velocity: = linear_velocity
    velocity.x = speed.x * direction.x
    if direction.y != 0.0:
      velocity.y = speed.y * direction.y
    if is_jump_interrupted:
      velocity.y = 0.0
    return velocity

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
  var velocity: = linear_velocity
  velocity.y = -impulse
  return velocity

func die() -> void:
  PlayerData.deaths += 1
  queue_free()
