extends Node2D

var sizeX
var sizeY
var pixelColor
var frameTexture
var pixelArrey = {}
export var hight = 7
export var wight = 7
var thread
var threadFlag = true

var sprite_x = 0

func _ready():	
	frameTexture = $VideoPlayer.get_video_texture()
	
	sizeX = frameTexture.get_size().x
	sizeY = frameTexture.get_size().y
		
	for x in sizeX/3:
		for y in sizeY/3:
			$pixel.global_position = Vector2(x*hight, y*wight)
			pixelArrey[Vector2(x,y)] = $pixel.duplicate(15)
			add_child(pixelArrey[Vector2(x,y)])
						
func _process(delta):
	var image = frameTexture.get_data()
	if image != null:
		image.lock()
		var x = 0
		var y = 0
		while(true):
			pixelArrey[Vector2(x/3,y/3)].modulate = image.get_pixel(x, y)
			x += 3
			if x >= sizeX:
				x = 0
				y += 3
			if y >= sizeY:
				break
		image.unlock()
