extends RefCounted
class_name Pid3D


var _p: float
var _i: float
var _d: float


var _prev_error: Vector3
var _error_integral: Vector3


func _init(p: float, i: float, d: float) -> void:
	_p = p
	_i = i
	_d = d


func update(error: Vector3, delta: float) -> Vector3:
	var error_derivative = (error - _prev_error) / delta
	_error_integral += error * delta
	return _p * error + _i * _error_integral + _d * error_derivative
