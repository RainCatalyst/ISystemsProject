class_name UI extends Control

signal any_clicked

@export var overlay: Overlay
@export var textbox: TextBox

func show_text(text):
	textbox.show_text(text)

func show_correct(answer):
	overlay.fade_in(Color(0.15, 0.9, 0.1, 0.2))
	textbox.show_text("[color=42f563]Correct![/color] [b]%s[/b]\nClick to reveal the item." % answer)
	await any_clicked
	overlay.fade_out()
	textbox.hide_text()

func show_wrong(answer):
	overlay.fade_in(Color(0.9, 0.2, 0.1, 0.2))
	textbox.show_text("[color=eb3e31]Wrong![/color] [b]%s[/b]\nClick to try next item." % answer)
	await any_clicked
	overlay.fade_out()
	textbox.hide_text()
	
func _input(event):
	if (event is InputEventKey or event is InputEventMouseButton) and event.is_pressed():
		any_clicked.emit()
