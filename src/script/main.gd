extends TileMap

var Globals = preload("res://src/globals/global_resource.tres")

var mouse_button_down: bool = false

func _ready():
	var tmp = []
	tmp.resize(64)
	tmp.fill(0)

	for i in range(32):
		Globals.map.append(tmp.duplicate())
	
	Globals.map_template = Globals.map.duplicate(true)

func _process(_delta):
	if Globals.run:
		var next_gen_map = Globals.map_template.duplicate(true)

		for row in range(len(Globals.map)):
			for col in range(len(Globals.map[row])):
				simulate(next_gen_map, row, col)
		
		Globals.map =  next_gen_map

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

func simulate(next_gen_map, row, col):
	var neighbor_count = 0 
	for e in [[row-1, col-1], [row-1, col], [row-1, col+1], [row, col-1], [row, col+1], [row+1, col-1], [row+1, col], [row+1, col+1]]:
		if (e[0] >= 0 && e[0] < 32) && (e[1] >= 0 && e[1] < 64):
			if Globals.map[e[0]][e[1]] == 1:
				neighbor_count += 1

	if neighbor_count < 2:
		next_gen_map[row][col] = 0 
	elif neighbor_count < 3:
		next_gen_map[row][col] = Globals.map[row][col] 
	elif neighbor_count == 3:
		next_gen_map[row][col] = 1 
	elif neighbor_count > 3:
		next_gen_map[row][col] = 0 
		

