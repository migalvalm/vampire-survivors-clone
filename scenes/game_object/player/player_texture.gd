extends Sprite2D
class_name PlayerTexture

func set_player_skin(texture_path: String):
	texture = load_png(texture_path)

func load_png(file) -> ImageTexture:
	var png_file = FileAccess.open(file,FileAccess.READ)
	if FileAccess.file_exists(file):
		var img = Image.new()
		var err = img.load(file)
		if err != OK:
			print("Image load error")
			
		return ImageTexture.create_from_image(img)
	return null
