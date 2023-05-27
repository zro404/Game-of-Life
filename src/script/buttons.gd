extends Control

var Globals := preload("res://src/globals/global_resource.tres")


func _on_pen_button_down():
	Globals.pen_tool = true


func _on_eraser_button_down():
	Globals.pen_tool = false


func _on_play_button_down():
	Globals.run = !Globals.run


func _on_trash_button_down():
	Globals.map = Globals.map_template.duplicate(true)

