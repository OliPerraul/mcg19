extends MenuButton

#Sections indicated by '$'
export(Array, String) var content

var menu = null

func _ready():
	menu = get_popup()
	if content :
		for item in content:
			if item == '$' :
				menu.add_separator()
			else:
				menu.add_item(item)


	
