extends Node


## Assets ##

export(Script) onready var _example_script

export(Texture) onready var _script_icon
export(Texture) onready var _sprite_icon
export(Texture) onready var _folder_icon

## End Assets ##


enum RESOURCE_TYPE {
	FOLDER
	SCRIPT,
	SPRITE,
	SCENE
}


export(Script) onready var folder_resource_script
export(Script) onready var script_resource_script
export(Script) onready var sprite_resource_script


func create(idx, folder):
	var res
	match idx:
		FOLDER:
			res = folder_resource_script.new()
			res.resname = 'NewFolder'
			#res.tree_item = item
			res.icon = _folder_icon
		SCRIPT:
			res = script_resource_script.new()
			res.resname = 'NewScript.gd'
			res.icon = _script_icon
			res.resource = _example_script
		SPRITE:
			res = sprite_resource_script.new()
			res.resname = 'NewSprite.tres'
			res.icon = _sprite_icon
	
	res.folder = folder
	if folder :
		folder.content.append(res)
	return res


# @param idx_type
# @param folder resource model object
# @param resname
func create_named(idx, folder, resname):
	var res = create(idx, folder)
	res.resname = resname
	return res
	
	
