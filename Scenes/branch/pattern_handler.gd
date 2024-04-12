extends RichTextLabel

@export var reject_invalid_characters : bool
@export var pattern : String
var _character_backgrounds : Array[CharacterBackground]
var _cursor_position = 0

enum CharacterBackground {
	EMPTY,
	CORRECT,
	ERROR
}

func is_complete():
	return _character_backgrounds.all(func(bg): return bg == CharacterBackground.CORRECT)

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.keycode == KEY_BACKSPACE:
			if _cursor_position > 0:
				_cursor_position -= 1
				_set_cursor_background(CharacterBackground.EMPTY)
			else:
				print("invalid backspace")
				# later: shake label on invalid input
		elif event.keycode >= KEY_A and event.keycode <= KEY_Z:
			if _cursor_position < pattern.length():
				var letter = OS.get_keycode_string(event.keycode).to_lower()
				if pattern[_cursor_position] == letter:
					_set_cursor_background(CharacterBackground.CORRECT)
					_cursor_position += 1
				else:
					_set_cursor_background(CharacterBackground.ERROR)
					if not reject_invalid_characters:
						_cursor_position += 1
			else:
				print("reached end of pattern")
				# later: shake label on invalid input

# Called when the node enters the scene tree for the first time.
func _ready():
	for character in pattern:
		_character_backgrounds.append(CharacterBackground.EMPTY)
	_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _character_background_to_color(cursor_background):
	match cursor_background:
		CharacterBackground.EMPTY:
			return "grey"
		CharacterBackground.CORRECT:
			return "green"
		CharacterBackground.ERROR:
			return "red"

func _set_cursor_background(cursor_background):
	_character_backgrounds[_cursor_position] = cursor_background
	_redraw()

func _redraw():
	text = ""
	text = "[center]" # there is no push_center()
	push_mono()
	assert(_character_backgrounds.size() == pattern.length())
	for i in range(_character_backgrounds.size()):
		push_bgcolor(_character_background_to_color(_character_backgrounds[i]))
		append_text(pattern[i])
		pop()
