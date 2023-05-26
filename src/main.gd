extends TileMap

var Globals = preload("res://src/globals/global_resource.tres")

var mouse_button_down: bool = false

func _ready():
	var tmp = []
	tmp.resize(64)
	tmp.fill(0)

	for i in range(32):
		Globals.map.append(tmp.duplicate())


func _process(_delta):

	for row in range(len(Globals.map)):
		for col in range(len(Globals.map[row])):
			var cell_type = Globals.map[row][col]
			set_cell(
			0,                     #Layer ID (0 by default)
			Vector2i(col, row) ,       #Coordinate (x, y)
			cell_type,                     #Tile id, (Image 01)
			Vector2i(0, 0)         #If you're working with an atlas, you should
			)


func _input(event):
	if event is InputEventMouseButton:
		mouse_button_down = !mouse_button_down
		var pos = event.position
		if pos.x < 1280 && pos.y < 640:
			pos.x = floori(pos.x / 20)
			pos.y = floori(pos.y / 20)

			if Globals.pen_tool:
				Globals.map[pos.y][pos.x] = 1
			else:
				Globals.map[pos.y][pos.x] = 0

	if event is InputEventMouseMotion && mouse_button_down:
		var pos = event.position
		if pos.x < 1280 && pos.y < 640:
			pos.x = floori(pos.x / 20)
			pos.y = floori(pos.y / 20)

			if Globals.pen_tool:
				Globals.map[pos.y][pos.x] = 1
			else:
				Globals.map[pos.y][pos.x] = 0
