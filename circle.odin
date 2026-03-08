package main
import rl "vendor:raylib"


Circle :: struct {
	center: rl.Vector2,
	radius: f32,
	color:  rl.Color,
}


update_circle :: proc(c: ^Circle, velocity: rl.Vector2) {
	c.center.x += velocity.x * rl.GetFrameTime()
	c.center.y += velocity.y * rl.GetFrameTime()

}

draw_circle :: proc(c: ^Circle) {
	rl.DrawCircleV(c.center, c.radius, c.color)
}

connect_circles :: proc(c1: ^Circle, c2: ^Circle) {
	rl.DrawLineV(c1.center, c2.center, rl.GREEN)
}
