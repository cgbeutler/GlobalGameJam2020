extends VBoxContainer
var DatingLog := preload("res://DatingSim/DatingLog.tscn")
var DatingChoice := preload("res://DatingSim/DatingChoice.tscn")

signal choiceMade(caller)
signal triggered(message)


onready var parent : ScrollContainer = $".."

var __sim_dict : Dictionary
var __lastResponses : Array = []
var __activeChoices : Array = []


func start_sim( sim_dict : Dictionary ):
	__sim_dict = sim_dict
	__loadChoice()


func _process(delta):
	parent.scroll_vertical = 99999


func __loadChoice():
	for i in __activeChoices:  i.queue_free()
	__activeChoices.clear()
	for i in __lastResponses:  i.bg_color *= Color.gray
	__lastResponses.clear()
	
	if __sim_dict.has("trigger_scene"):
		print ("triggering new Scene..")
		get_tree().change_scene(__sim_dict["trigger_scene"])
		return
	
	if __sim_dict.has("trigger"):
		self.emit_signal("triggered", __sim_dict["trigger"])
	
	if __sim_dict.has("choice"):
		var text : String = __sim_dict["choice"]
		print (text)
		if text.empty():  text = "[next]"
		if not text == "[next]":
			var curLog := DatingLog.instance()
			curLog.text = text
			curLog.bg_color = Color.red
			self.add_child(curLog)
			__lastResponses.append( curLog )
	
	if __sim_dict.has("response"):
		var response = __sim_dict["response"]
		var date_log = DatingLog.instance()
		date_log.text = __sim_dict["response"]
		if __sim_dict.has("responseColor") and __bg_colors.has(__sim_dict["responseColor"]):
			date_log.bg_color = __bg_colors[__sim_dict["responseColor"]]
		else:
			date_log.bg_color = Color.gray
		self.add_child(date_log)
		__lastResponses.append( date_log )
	
	for choice in __sim_dict["nextChoices"]:
		var childChoice = DatingChoice.instance()
		childChoice.logText = choice["choice"]
		__activeChoices.append(childChoice)
		self.add_child(childChoice)
	


func _on_VBoxContainer_choiceMade(choiceText):
	for c in __sim_dict["nextChoices"]:
		if c["choice"] == choiceText:
			__sim_dict = c
			break
	
	__loadChoice()


const __bg_colors := {
	"gray" : Color.gray,
	"bisque" : Color.bisque,
	"blanchedalmond" : Color.blanchedalmond,
	"burlywood" : Color.burlywood,
	"chartreuse" : Color.chartreuse,
	"aqua" : Color.aqua,
	"blue" : Color.blue,
	"aliceblue" : Color.aliceblue,
	"blueviolet" : Color.blueviolet,
	"brown" : Color.brown,
	"cadetblue" : Color.cadetblue,
	"chocolate" : Color.chocolate,
	"antiquewhite" : Color.antiquewhite,
	"aquamarine" : Color.aquamarine,
	"azure" : Color.azure,
	"beige" : Color.beige,
	"black" : Color.black,
	"green" : Color.green,
	"crimson" : Color.crimson,
	"khaki" : Color.khaki,
	"lavender" : Color.lavender,
	"lightblue" : Color.lightblue,
	"darkturquoise" : Color.darkturquoise,
	"firebrick" : Color.firebrick,
	"darkorchid" : Color.darkorchid,
	"coral" : Color.coral,
	"cornsilk" : Color.cornsilk,
	"darkgreen" : Color.darkgreen,
	"darkslategray" : Color.darkslategray,
	"floralwhite" : Color.floralwhite,
	"gainsboro" : Color.gainsboro,
	"gold" : Color.gold,
	"goldenrod" : Color.goldenrod,
	"darkcyan" : Color.darkcyan,
	"indianred" : Color.indianred,
	"indigo" : Color.indigo,
	"lavenderblush" : Color.lavenderblush,
	"lawngreen" : Color.lawngreen,
	"deeppink" : Color.deeppink,
	"darkgray" : Color.darkgray,
	"dodgerblue" : Color.dodgerblue,
	"ghostwhite" : Color.ghostwhite,
	"darkred" : Color.darkred,
	"lemonchiffon" : Color.lemonchiffon,
	"lightcoral" : Color.lightcoral,
	"lightcyan" : Color.lightcyan,
	"lightgoldenrod" : Color.lightgoldenrod,
	"cyan" : Color.cyan,
	"darkgoldenrod" : Color.darkgoldenrod,
	"darkmagenta" : Color.darkmagenta,
	"darkolivegreen" : Color.darkolivegreen,
	"darkseagreen" : Color.darkseagreen,
	"darkslateblue" : Color.darkslateblue,
	"darksalmon" : Color.darksalmon,
	"deepskyblue" : Color.deepskyblue,
	"cornflower" : Color.cornflower,
	"darkkhaki" : Color.darkkhaki,
	"dimgray" : Color.dimgray,
	"fuchsia" : Color.fuchsia,
	"darkblue" : Color.darkblue,
	"darkviolet" : Color.darkviolet,
	"darkorange" : Color.darkorange,
	"greenyellow" : Color.greenyellow,
	"forestgreen" : Color.forestgreen,
	"honeydew" : Color.honeydew,
	"hotpink" : Color.hotpink,
	"ivory" : Color.ivory,
	"lightyellow" : Color.lightyellow,
	"mediumspringgreen" : Color.mediumspringgreen,
	"rebeccapurple" : Color.rebeccapurple,
	"red" : Color.red,
	"papayawhip" : Color.papayawhip,
	"rosybrown" : Color.rosybrown,
	"royalblue" : Color.royalblue,
	"lightsteelblue" : Color.lightsteelblue,
	"mediumaquamarine" : Color.mediumaquamarine,
	"mediumpurple" : Color.mediumpurple,
	"lightskyblue" : Color.lightskyblue,
	"mistyrose" : Color.mistyrose,
	"palevioletred" : Color.palevioletred,
	"plum" : Color.plum,
	"powderblue" : Color.powderblue,
	"purple" : Color.purple,
	"navyblue" : Color.navyblue,
	"lightseagreen" : Color.lightseagreen,
	"mediumseagreen" : Color.mediumseagreen,
	"mediumslateblue" : Color.mediumslateblue,
	"orchid" : Color.orchid,
	"midnightblue" : Color.midnightblue,
	"mediumblue" : Color.mediumblue,
	"mediumorchid" : Color.mediumorchid,
	"peru" : Color.peru,
	"lightpink" : Color.lightpink,
	"navajowhite" : Color.navajowhite,
	"palegoldenrod" : Color.palegoldenrod,
	"limegreen" : Color.limegreen,
	"olivedrab" : Color.olivedrab,
	"magenta" : Color.magenta,
	"mediumturquoise" : Color.mediumturquoise,
	"palegreen" : Color.palegreen,
	"lightslategray" : Color.lightslategray,
	"lime" : Color.lime,
	"maroon" : Color.maroon,
	"mintcream" : Color.mintcream,
	"lightgray" : Color.lightgray,
	"linen" : Color.linen,
	"oldlace" : Color.oldlace,
	"lightgreen" : Color.lightgreen,
	"orangered" : Color.orangered,
	"lightsalmon" : Color.lightsalmon,
	"moccasin" : Color.moccasin,
	"olive" : Color.olive,
	"paleturquoise" : Color.paleturquoise,
	"orange" : Color.orange,
	"mediumvioletred" : Color.mediumvioletred,
	"peachpuff" : Color.peachpuff,
	"pink" : Color.pink,
	"webgreen" : Color.webgreen,
	"violet" : Color.violet,
	"whitesmoke" : Color.whitesmoke,
	"seashell" : Color.seashell,
	"webmaroon" : Color.webmaroon,
	"sienna" : Color.sienna,
	"webpurple" : Color.webpurple,
	"white" : Color.white,
	"slategray" : Color.slategray,
	"silver" : Color.silver,
	"slateblue" : Color.slateblue,
	"steelblue" : Color.steelblue,
	"transparent" : Color.transparent,
	"yellow" : Color.yellow,
	"springgreen" : Color.springgreen,
	"thistle" : Color.thistle,
	"tomato" : Color.tomato,
	"seagreen" : Color.seagreen,
	"skyblue" : Color.skyblue,
	"teal" : Color.teal,
	"turquoise" : Color.turquoise,
	"webgray" : Color.webgray,
	"snow" : Color.snow,
	"wheat" : Color.wheat,
	"yellowgreen" : Color.yellowgreen,
	"tan" : Color.tan,
	"salmon" : Color.salmon,
	"saddlebrown" : Color.saddlebrown,
	"sandybrown" : Color.sandybrown
}
