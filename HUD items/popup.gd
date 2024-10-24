extends Control

@export var IncomeLab : Label
@export var ScoreLab : Label
@export var TimeLab : Label
@export var PollutionLab : Label

var grid_componant : GridComponent

func _ready() -> void:
	if grid_componant != null and grid_componant.stats != null:
		IncomeLab.text = str(grid_componant.stats.income.calculate_value())
		ScoreLab.text = str(grid_componant.stats.score.calculate_value())
		if grid_componant is Plant:
			TimeLab.text = str(grid_componant.growManager.calculate_grow_time())
		PollutionLab.text = str(grid_componant.stats.pollutionGeneration.calculate_value())
