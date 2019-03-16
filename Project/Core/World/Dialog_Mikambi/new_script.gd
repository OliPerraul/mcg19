extends Control

onready var tie = get_node("Panel/TextInterfaceEngine")

func select_demo(i):
	tie.reset()
	if(i == 0):
		tie.set_color(Color(1,1,1))
		tie.buff_text("This is a song, ", 0.1)
	elif(i == 1):
		tie.set_color(Color(1,1,0.3))
		# If velocity is 0, than whole text is printed 
		tie.buff_text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras semper finibus sapien, ut fringilla nulla vehicula ac. In hac habitasse platea dictumst. Nulla lobortis tempus sem vel lobortis. Mauris facilisis mollis nunc, vitae aliquet dui dictum id. Nullam ultricies facilisis interdum. Ut id semper eros, in lobortis diam. Nam consequat, dolor pharetra imperdiet finibus, lacus turpis tincidunt velit, ut fringilla ligula orci et justo. Praesent sagittis lectus eu metus faucibus aliquam. Donec sollicitudin porttitor massa a mollis. Nulla eleifend orci lacus, et tristique dui viverra eu. Sed nec mollis ligula. Quisque eu tellus libero. Nulla id hendrerit mauris.",0)
	elif(i == 2):
		tie.set_color(Color(0.3,1,1))
		# Schedule an Input in the buffer, after all
		# the text before it is displayed
		tie.buff_text("Hey there!! What's your name?\n", 0.01)
	tie.set_state(tie.STATE_OUTPUT)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("OptionButton").add_item("Papa_text")
	get_node("OptionButton").add_item("Mama_text")
	get_node("OptionButton").add_item("Yeti_text")
	
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OptionButton_item_selected(ID):
	select_demo(ID)
