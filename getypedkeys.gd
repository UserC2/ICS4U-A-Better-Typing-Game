extends RichTextLabel

@export var reject_invalid_characters : bool
@export var pattern : String
var _cursor_location = 0

enum CursorBackground {
	EMPTY,
	CORRECT,
	ERROR
}

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_BACKSPACE:
			if _cursor_location > 0:
				_set_cursor_background(CursorBackground.EMPTY)
				_cursor_location -= 1
			else:
				print("invalid backspace")
				# later: shake label on invalid input
		elif event.keycode >= KEY_A and event.keycode <= KEY_Z:
			if _cursor_location < pattern.length():
				var letter = OS.get_keycode_string(event.keycode).to_lower()
				if pattern[_cursor_location] == letter:
					_set_cursor_background(CursorBackground.CORRECT)
					_cursor_location += 1
				else:
					_set_cursor_background(CursorBackground.ERROR)
					if not reject_invalid_characters:
						_cursor_location += 1
			else:
				print("reached end of pattern")
				# later: shake label on invalid input				

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# setup bbcode
	# loop through pattern and wrap each character in [bgcolor=EMPTY]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _set_cursor_background(cursor_background):
	var color : String
	match cursor_background:
		CursorBackground.EMPTY:
			color = "grey"
		CursorBackground.CORRECT:
			color = "green"
		CursorBackground.ERROR:
			color = "red"
	print(color)
