class_name Overlay extends ColorRect

@export var duration: float = 0.5

var tween: Tween

func flash(target_color):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "color", target_color, duration * 0.6).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "color", Color.TRANSPARENT, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
func fade_in(target_color):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "color", target_color, duration * 0.6).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	
func fade_out():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "color", Color.TRANSPARENT, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
