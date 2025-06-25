extends SerComm

signal connected

@export var simulate: bool = false

func _ready():
	if simulate:
		await get_tree().process_frame
		connected.emit()
		return
	print(list_serial_ports())
	if open_serial():
		print('Serial connection opened!')
		await get_tree().process_frame
		connected.emit()

func _input(event):
	if not simulate:
		return
	if event.is_action_pressed("right"):
		on_message.emit("Correct")
	elif event.is_action_pressed("wrong"):
		on_message.emit("Wrong")
		
