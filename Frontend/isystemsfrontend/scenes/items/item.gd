extends Sprite2D
class_name Item

@export var word: String
var tween: Tween

func _ready():
	hide()

func reveal():
	await get_tree().create_timer(2.0).timeout
	scale = Vector2.ZERO
	modulate = Color(3, 3, 3, 1)
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.parallel().tween_property(self, "modulate", Color.WHITE, 0.15)
	show()
