extends Node2D

var _item: Item

@onready var _serial = $SerComm
@onready var _items = $Items.get_children()

func _ready():
	_serial.on_message.connect(_on_message)
	await get_tree().create_timer(2.0).timeout
	get_new_word()

func get_new_word():
	if len(_items) == 0:
		# Game finished
		win()
		return
	_item = _items[randi() % len(_items)]
	print('Got new word %s' % _item.word)
	await get_tree().create_timer(2.0).timeout
	_serial.write_serial("%s\n%s\n" % [_item.word, DataManager.word_to_article[_item.word]["article"]])
	
func win():
	print('All done!')

func _on_message(msg):
	if msg.begins_with("Correct"):
		_item.reveal()
		_items.erase(_item)
		get_new_word()
	else:
		get_new_word()
