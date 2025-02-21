const ray = @cImport({
    @cInclude("raylib.h");
});
const objects = @import("objects.zig");

const title = "Zig Pong!";

pub fn main() !void {
    const windows_width = 600;
    const windows_height = 400;
    const bgcolor = ray.BLACK;
    var obj: objects.Object = .{ .bar = .{ .physics = objects.Physics{ .x = 50, .y = 50, .dx = 0, .dy = 0, .width = 5, .height = 50, .windowHeight = windows_height, .windowWidth = windows_width } } };

    ray.InitWindow(windows_width, windows_height, title);
    defer ray.CloseWindow();

    ray.SetTargetFPS(60);

    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        defer ray.EndDrawing();
        ray.ClearBackground(bgcolor);

        const dt = 0.08;
        obj.handleInput();
        obj.updatePhysics(dt);
        obj.render(ray);
    }
}
