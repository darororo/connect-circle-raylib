package main
import "core:strings"
import rl "vendor:raylib"


get_random_color :: #force_inline proc() -> rl.Color {
	return rl.Color {
		cast(u8)rl.GetRandomValue(0, 255),
		cast(u8)rl.GetRandomValue(0, 255),
		cast(u8)rl.GetRandomValue(0, 255),
		255,
	}
}

draw_title :: proc(text: string) {
	font_size: i32 = auto_cast 40
	c_text := strings.clone_to_cstring(text)
	text_width := rl.MeasureText(c_text, font_size) // Get the width of the text
	x: i32 = (SCREEN_WIDTH / 2) - (text_width / 2) // Calculate the X position

	rl.DrawText(c_text, x, 0, 40, rl.BLACK) // Draw the text at the calculated position
}


SCREEN_WIDTH :: 480
SCREEN_HEIGHT :: 480

main :: proc() {

	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "raylib-odin example :: Bunnymark")
	defer rl.CloseWindow()

	builder := strings.Builder{}


	c1 := Circle {
		center   = rl.Vector2{200.0, 120.0},
		radius   = 4.0,
		color    = rl.PURPLE,
		velocity = rl.Vector2{100.0, 40.0},
	}

	c2 := Circle {
		center   = rl.Vector2{100.0, 120.0},
		radius   = 4.0,
		color    = rl.PINK,
		velocity = rl.Vector2{100.0, 40.0},
	}

	c3 := Circle {
		center   = rl.Vector2{100.0, 120.0},
		radius   = 4.0,
		color    = rl.PINK,
		velocity = rl.Vector2{120.0, -10.0},
	}

	world := World {
		circles = []Circle{c1, c2, c3},
	}


	for !rl.WindowShouldClose() {

		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.RAYWHITE)

		draw_world(&world)
		update_world(&world)

		draw_title("HELLO")
	}
}
