extends CanvasLayer

@export var GoldLabel : Label 
@export var SunLabel : Label 
@export var PollutionLabel : Label

@export var HaricotSprite : Sprite2D
var base_y : int = 760
var max_y : int = 294
var pixel_up : int = 0

var y_tier1 : int = 670
var y_tier2 : int = 547
var y_tier3 : int = 415

var winned = false
var WinScene : PackedScene = preload("res://Menu/win_layer.tscn")

func _ready():
	Global.G_S_P_changed.connect(update_topHUD)
	update_topHUD()

func update_topHUD():
	GoldLabel.text = str(Global.gold)
	SunLabel.text = str(Global.sun)
	PollutionLabel.text = str(Global.pollution)
	
	pixel_up = int(Global.sun) / 10
	if base_y - pixel_up >= max_y:
		HaricotSprite.position.y = base_y - pixel_up
	
	if base_y - pixel_up < max_y and not winned:
		winned = true
		var instance = WinScene.instantiate()
		add_child(instance)
