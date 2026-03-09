package main
import "core:strings"
import rl "vendor:raylib"


draw_title :: proc(text: string) {
	font_size: i32 = auto_cast 40
	c_text := strings.clone_to_cstring(text)
	text_width := rl.MeasureText(c_text, font_size) // Get the width of the text
	x: i32 = (SCREEN_WIDTH / 2) - (text_width / 2) // Calculate the X position

	rl.DrawText(c_text, x, 0, 40, rl.BLACK) // Draw the text at the calculated position
}


SCREEN_WIDTH :: 480
SCREEN_HEIGHT :: 480

MAX_CIRCLES :: 100

main :: proc() {

	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "CONNECT MANY")
	defer rl.CloseWindow()

	world := World{}
	for !rl.WindowShouldClose() {
		add_circle(&world)
		defer remove_dead_circles(&world)

		rl.BeginDrawing()
		defer rl.EndDrawing()

		rl.ClearBackground(rl.RAYWHITE)

		draw_world(&world)
		update_world(&world)
		world_connect_circles(&world)

		draw_title("HELLO")


	}
}
