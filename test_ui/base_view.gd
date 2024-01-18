extends View

func _ready():
	modulate = Color.BLACK
	super._ready()

func _post_open():
	var tw = create_tween()
	tw.tween_property(self, "modulate", Color.WHITE,0.3).from(Color.BLACK)
	await tw.finished
	
func _post_close():
	var tw = create_tween()
	tw.tween_property(self, "modulate", Color.BLACK,0.3).from(Color.WHITE)
	await tw.finished

