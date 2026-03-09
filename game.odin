package main
import "core:math/rand"
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
	distance := rl.Vector2Distance(c1.center, c2.center)
	if (distance < 40) {
		rl.DrawLineV(c1.center, c2.center, rl.GRAY)
	}
}


World :: struct {
	circles: [dynamic]Circle,
}


draw_world :: proc(world: ^World) {
	for &c in world.circles {
		draw_circle(&c)
	}
}

update_world :: proc(world: ^World) {
	for i in 0 ..< len(world.circles) {
		update_circle(&world.circles[i])

	}
}

world_connect_circles :: proc(world: ^World) {
	for i in 0 ..< len(world.circles) {
		for j in i ..< len(world.circles) {
			connect_circles(&world.circles[i], &world.circles[j])
		}

	}
}

add_circle :: proc(world: ^World) {
	if (len(world.circles) > 100) {
		return
	}


	// Center of circle
	cx, cy: f32
	// Velocity of circle
	vx, vy: f32

	min_vx :: 50
	max_vx :: 120
	min_vy :: 50
	max_vy :: 120

	rng := rand.float32_range(0, 1)
	switch {
	case rng < 0.25:
		// Spawn circle in the left side
		cx = 0
		cy = rand.float32_range(0, SCREEN_HEIGHT)

		// Go right
		vx = rand.float32_range(min_vx, max_vx)
		vy = rand.float32_range(min_vy, max_vy)


	case rng < 0.5:
		// Spawn circle in the right side
		cx = SCREEN_WIDTH
		cy = rand.float32_range(0, SCREEN_HEIGHT)

		// Go left
		vx = -rand.float32_range(min_vx, max_vx)
		vy = rand.float32_range(min_vy, max_vy)


	case rng < 0.75:
		// Spawn circle at the top
		cx = rand.float32_range(0, SCREEN_WIDTH)
		cy = 0

		// Go down
		vx = rand.float32_range(min_vx, max_vx)
		vy = rand.float32_range(min_vy, max_vy)

	case rng < 1:
		// Spawn circle at the bottom
		cx = rand.float32_range(0, SCREEN_WIDTH)
		cy = SCREEN_HEIGHT

		// Go up
		vx = rand.float32_range(min_vx, max_vx)
		vy = -rand.float32_range(min_vy, max_vy)
	}


	c := Circle {
		center   = rl.Vector2{cx, cy},
		velocity = rl.Vector2{vx, vy},
		color    = get_random_color(),
		radius   = 4,
	}

	append(&world.circles, c)
}

remove_dead_circles :: proc(world: ^World) {
	for &c, index in world.circles {
		inside_width := c.center.x > 0 && c.center.x < SCREEN_WIDTH
		inside_heigth := c.center.y > 0 && c.center.y < SCREEN_HEIGHT

		if !inside_width || !inside_heigth {
			unordered_remove(&world.circles, index)
		}

	}
}

get_random_color :: proc() -> rl.Color {
	return rl.Color {
		cast(u8)rl.GetRandomValue(0, 255),
		cast(u8)rl.GetRandomValue(0, 255),
		cast(u8)rl.GetRandomValue(0, 255),
		255,
	}
}
