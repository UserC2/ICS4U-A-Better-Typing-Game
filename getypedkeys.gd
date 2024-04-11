extends RichTextLabel

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_BACKSPACE:
			text = text.erase(text.length() - 1)
		elif event.keycode >= KEY_A and event.keycode <= KEY_Z:
			append_text(OS.get_keycode_string(event.keycode))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
