extends CanvasLayer

@export var GoldLabel : Label 
@export var SunLabel : Label 
@export var PollutionLabel : Label 

func _ready():
	Global.G_S_P_changed.connect(update_topHUD)
	update_topHUD()

func update_topHUD():
	GoldLabel.text = str(Global.gold)
	SunLabel.text = str(Global.sun)
	PollutionLabel.text = str(Global.pollution)
