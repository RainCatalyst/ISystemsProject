extends SerComm

func _ready():
	print(list_serial_ports())
	#port = 7;
	if open_serial():
		pass
