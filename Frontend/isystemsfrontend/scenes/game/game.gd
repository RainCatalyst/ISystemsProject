extends Node2D

@export var ui: UI

@onready var _serial = $SerComm
@onready var _items = $Items.get_children()

var _item: Item

func _ready():
	_serial.on_message.connect(_on_message)
	await _serial.connected
	get_new_word()

func get_new_word():
	if len(_items) == 0:
		# Game finished
		win()
		return
	var last_item = _item
	_item = _items[randi() % len(_items)]
	_serial.write_serial("%s\n%s\n" % [_item.word, DataManager.word_to_article[_item.word]["article"]])
	ui.show_text("Guess the article for [b]%s[/b]" % _item.word)
	print('Got new word %s' % _item.word)
	
func win():
	print('All done!')
	
func _on_correct():
	await ui.show_correct(_format_item())
	await get_tree().create_timer(0.1).timeout
	for i in range(_items.size() - 1, -1, -1):
		if _items[i].word == _item.word:
			await _items[i].reveal()
			_items.remove_at(i)
	
	get_new_word()
	
func _on_wrong():
	await ui.show_wrong(_format_item())
	await get_tree().create_timer(0.1).timeout
	get_new_word()

func _on_message(msg):
	print(msg)
	if msg.begins_with("Correct"):
		_on_correct()
	elif msg.begins_with("Wrong"):
		_on_wrong()

func _format_item():
	return "%s %s" % [DataManager.word_to_article[_item.word]["article"], _item.word]
