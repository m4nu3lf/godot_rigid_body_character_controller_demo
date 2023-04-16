extends RigidBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


var _pid := Pid3D.new(1.0, 0.1, 1.0)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		apply_central_impulse(JUMP_VELOCITY * mass * Vector3(0, 1, 0))
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var desired_velocity = SPEED * direction
	var velocity_error = desired_velocity - linear_velocity
	velocity_error.y = 0.0
	var correction_impulse = mass * _pid.update(velocity_error, delta) * 1e-2
	correction_impulse = correction_impulse.normalized() * min(correction_impulse.length(), 0.5)
	apply_central_impulse(correction_impulse)
