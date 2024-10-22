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

var tier1_reached = false
var tier2_reached = false
var tier3_reached = false
			
var sun_to_tier1 = 5000
var sun_to_tier2 = 25000
var sun_to_tier3 = 500000
var final_sun = 10000000

var winned = false
var WinScene : PackedScene = preload("res://Menu/win_layer.tscn")

func _ready():
	Global.G_S_P_changed.connect(update_topHUD)
	update_topHUD()

func update_topHUD():
	update_resources()
	update_progress_bar()
	
func update_resources():
	GoldLabel.text = str(Global.gold)
	SunLabel.text = str(Global.sun)
	PollutionLabel.text = str(Global.pollution)

func update_progress_bar():
	var sun := Global.sun  # La quantité actuelle de soleil

	if sun <= sun_to_tier1:
		var progress = sun / float(sun_to_tier1)
		HaricotSprite.position.y = lerp(base_y, y_tier1, progress)
	elif sun <= sun_to_tier2:
		if not tier1_reached:
			tier1_reached = true
			emit_signal("tier_reached", 1)
		var progress = float(sun - sun_to_tier1) / float(sun_to_tier2 - sun_to_tier1)
		HaricotSprite.position.y = lerp(y_tier1, y_tier2, progress)
	elif sun <= sun_to_tier3:
		if not tier2_reached:
			tier2_reached = true
			emit_signal("tier_reached", 2)
		var progress = float(sun - sun_to_tier2) / float(sun_to_tier3 - sun_to_tier2)
		HaricotSprite.position.y = lerp(y_tier2, y_tier3, progress)
	else:
		if not tier3_reached:
			tier3_reached = true
			emit_signal("tier_reached", 3)
		var progress = float(sun - sun_to_tier3) / float(final_sun - sun_to_tier3)
		HaricotSprite.position.y = lerp(y_tier3, max_y, progress)

	# Gérer la victoire (si la barre dépasse max_y)
	if HaricotSprite.position.y <= max_y and not winned:
		winned = true
		var instance = WinScene.instantiate()
		add_child(instance)


#func update_progress_bar():
	#pixel_up = int(Global.sun) / 40
	#if base_y - pixel_up >= max_y:
		#HaricotSprite.position.y = base_y - pixel_up
	#
	#if base_y - pixel_up < max_y and not winned:
		#winned = true
		#var instance = WinScene.instantiate()
		#add_child(instance)
