const object = @import("object.zig");
pub const State = struct {
    x: f32,
    y: f32,
    dx: f32,
    dy: f32,
    height: f32,
    width: f32,
    windowHeight: f32,
    windowWidth: f32,
};

pub fn updatePaddleState(self: *object.GameObject, dt: f32) void {
    self.state.y = self.state.y + self.state.dy * dt;
    self.state.x = self.state.x + self.state.dx * dt;

    // Trivial collision resolution
    if (self.state.y + self.state.height > self.state.windowHeight) {
        self.state.y = self.state.height;
    }
}

pub fn updateBallState(self: *object.GameObject, dt: f32) void {
    // Not implemented
    _ = self;
    _ = dt;
}
