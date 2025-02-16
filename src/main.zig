const std = @import("std");
const ray = @cImport({
    @cInclude("raylib.h");
});

const title = "Triangle!";

pub fn main() !void {
    const windows_width = 600;
    const windows_height = 400;
    const color = ray.ORANGE;
    const bgcolor = ray.BLACK;

    ray.InitWindow(windows_width, windows_height, title);
    defer ray.CloseWindow();

    ray.SetTargetFPS(60);

    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        defer ray.EndDrawing();

        ray.ClearBackground(bgcolor);

        const a = ray.Vector2{ .x = 50.0, .y = 200.0 };
        const b = ray.Vector2{ .x = 200.0, .y = 50.0 };
        const c = ray.Vector2{ .x = 50.0, .y = 50.0 };
        ray.DrawTriangle(a, b, c, color);
    }
}
