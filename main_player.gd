extends Sprite2D

func playerBorderLimit():
	var screen_size = get_viewport().size
	var sprite_half_width = self.texture.get_width() / 2
	var sprite_half_height = self.texture.get_height() / 2
	position.x = clamp(position.x, sprite_half_width, screen_size.x - sprite_half_width)
	position.y = clamp(position.y, sprite_half_height, screen_size.y - sprite_half_height)
