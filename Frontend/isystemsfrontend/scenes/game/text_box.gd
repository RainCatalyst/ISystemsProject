class_name TextBox extends Control

@export var duration: float = 0.3
@export var label: RichTextLabel

var tween: Tween

func show_text(text):
	if tween:
		tween.kill()
	label.visible_ratio = 0.0
	label.text = text
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)

func hide_text():
	label.text = ""
