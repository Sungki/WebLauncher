extends Control

var sizeX
var sizeY
var frameTexture
var pixelArrey = {}
export var hight = 0
export var wight = 0
var thread
var threadFlag = true

func _ready():
	thread = Thread.new()
	thread.start(self, "_thread_function")
	frameTexture = $VideoPlayer.get_video_texture()
	sizeX = frameTexture.get_size().x
	sizeY = frameTexture.get_size().y
	
	for x in sizeX/3:
		for y in sizeY/3:
			$pixel.global_position = Vector2(x*hight, y*wight)
			pixelArrey[Vector2(x,y)] = $pixel.duplicate(15)
			add_child(pixelArrey[Vector2(x,y)])

func _thread_function(userdata):
	while threadFlag:
		frameTexture = $VideoPlayer.get_video_texture()
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

func _exit_tree():
	thread.wait_to_finish()

func _on_VideoPlayer_finished():
		threadFlag = false
		get_tree().quit()
