extends RichTextLabel

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_BACKSPACE:
			print(text.length())			
			set_text(text.erase(text.length() - 1))
			print(text.length())
		elif event.keycode >= KEY_A and event.keycode <= KEY_Z:
			text += OS.get_keycode_string(event.keycode)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
