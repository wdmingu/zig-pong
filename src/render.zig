const object = @import("object.zig");
const ray = @cImport({
    @cInclude("raylib.h");
});

pub fn renderPaddle(self: *object.GameObject) void {
    const rec = ray.Rectangle{ .x = self.state.x, .y = self.state.y, .width = self.state.width, .height = self.state.height };
    ray.DrawRectangleRec(rec, ray.WHITE);
}

pub fn renderBall(self: *object.GameObject) void {
    // Not implemented
    _ = self;
}
