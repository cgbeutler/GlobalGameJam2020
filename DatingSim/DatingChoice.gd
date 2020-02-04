extends Control

export var logText = "Enter text"


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

func _ready():
	$MarginContainer/Label.text = __stip_bb_code(logText)
	$MarginContainer/OLabel.bbcode_text = "[center]" + logText + "[/center]"


func _on_Button_pressed():
	print ("You chose " + logText)
	$"..".emit_signal("choiceMade",logText)


func _on_ButtonCover_pressed():
	_on_Button_pressed()
