package main
import rl "vendor:raylib"


Circle :: struct {
	center:   rl.Vector2,
	velocity: rl.Vector2,
	radius:   f32,
	color:    rl.Color,
}
update_circle :: proc(c: ^Circle) {
	c.center.x += c.velocity.x * rl.GetFrameTime()
	c.center.y += c.velocity.y * rl.GetFrameTime()

}

draw_circle :: proc(c: ^Circle) {
	rl.DrawCircleV(c.center, c.radius, c.color)
}

connect_circles :: proc(c1: ^Circle, c2: ^Circle) {
	rl.DrawLineV(c1.center, c2.center, rl.GREEN)
}


World :: struct {
	circles: []Circle,
}


draw_world :: proc(world: ^World) {
	for &c in world.circles {
		draw_circle(&c)
	}
}

update_world :: proc(world: ^World) {
	for i in 0 ..< len(world.circles) {
		update_circle(&world.circles[i])

		if (i < len(world.circles) - 1) {
			connect_circles(&world.circles[i], &world.circles[i + 1])
		}

	}
}
