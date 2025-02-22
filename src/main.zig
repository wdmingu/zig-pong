const ray = @cImport({
    @cInclude("raylib.h");
});
const object = @import("object.zig");
const state = @import("state.zig");
const render = @import("render.zig");
const input = @import("input.zig");

const title = "Zig Pong!";

pub fn main() !void {
    const windows_width = 600;
    const windows_height = 400;
    const bgcolor = ray.BLACK;
    var paddle: object.GameObject = .{.state = state.State{.x = 50, 
                                                           .y = 50, 
                                                           .dx = 0, 
                                                           .dy = 0, 
                                                           .width = 5, 
                                                           .height = 50, 
                                                           .windowHeight = windows_height, 
                                                           .windowWidth = windows_width},
                                      .doHandleInput = input.demoController,
                                      .doUpdateState = state.updatePaddleState,
                                      .doRender      = render.renderPaddle,
                                     };

    ray.InitWindow(windows_width, windows_height, title);
    defer ray.CloseWindow();

    ray.SetTargetFPS(60);

    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        defer ray.EndDrawing();
        ray.ClearBackground(bgcolor);

        const dt = 0.08;
        paddle.handleInput();
        paddle.updateState(dt);
        paddle.render();
    }
}
