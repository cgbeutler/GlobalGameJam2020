extends PanelContainer


onready var __sizing_label = $MarginContainer/Label
onready var __rich_label = $MarginContainer/OLabel

export var text = "Enter text" setget set_text, get_text
func set_text( value ):
	text = value ; __dirty = true
func get_text():  return text

export var bg_color := Color.white setget set_bg_color, get_bg_color
func set_bg_color( value ):
	bg_color = value ; __dirty = true
func get_bg_color():  return bg_color


var __dirty = false

# \\\\ Stripping BBCode \\\\
var __remove_bb_regex_code = "(?!\\[next\\])\\[.+?\\]"
var __remove_bb_regex = RegEx.new() # Compiled in _init()
func __stip_bb_code( s : String ):
	print ( "stripping: ", s )
	var result = __remove_bb_regex.sub(s, "", true)
	if not result:
		push_error("regex failed")
		return s
	print ( "result: ", result )
	return result
# //////////////////////////


func _init() -> void:
	__remove_bb_regex.compile(__remove_bb_regex_code)

func __update():
	if __dirty:
		__sizing_label.text = __stip_bb_code( text )
		__rich_label.bbcode_text = "[center]" + text + "[/center]"
		self_modulate = bg_color
		__dirty = false


func _ready() -> void:
	__update()

func _process(_delta: float) -> void:
	__update()
