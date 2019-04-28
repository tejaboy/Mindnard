def MotorOnForSeconds(_motor, _speed_sp, _seconds, _brake = True, _block = True):
	_motor.on_for_seconds(speed_sp = _speed_sp, seconds = _seconds, brake = _brake, block = _block);

def MotorOnForRotations(_motor, _speed, _rotations, _brake = True, _block = True):
	_motor.on_for_rotations(speed_sp = _speed_sp, rotations = _rotations, brake = _brake, block = _block);