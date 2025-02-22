const ray = @cImport({
    @cInclude("raylib.h");
});
const world = @import("world.zig");
const std = @import("std");

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

const title = "Zig Pong!";

pub fn main() !void {
    const windows_width = 600;
    const windows_height = 400;
    const bgcolor = ray.BLACK;
    var pongWorld = try world.World.init(allocator, windows_height, windows_width);
    defer pongWorld.deinit();

    ray.InitWindow(windows_width, windows_height, title);
    defer ray.CloseWindow();

    ray.SetTargetFPS(60);

    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        defer ray.EndDrawing();
        ray.ClearBackground(bgcolor);

        const dt = 0.08;
        pongWorld.handleInput();
        pongWorld.updateState(dt);
        pongWorld.render();
    }
}
