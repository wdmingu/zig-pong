const std = @import("std");
pub const Physics = struct {
    x: f32,
    y: f32,
    dx: f32,
    dy: f32,
    height: f32,
    width: f32,
    windowHeight: f32,
    windowWidth: f32,
};

pub const Bar = struct {
    physics: Physics,

    pub fn handleInput(self: *Bar) void {
        // assume user is holding down
        self.physics.dy = 20;
    }

    pub fn updatePhysics(self: *Bar, dt: f32) void {
        self.physics.y = self.physics.y + dt * self.physics.dy;
        if (self.physics.y + self.physics.height > self.physics.windowHeight) {
            self.physics.y = self.physics.height;
        }
    }

    pub fn updateGraphics(self: *Bar, ray: anytype) void {
        const rec = ray.Rectangle{ .x = self.physics.x, .y = self.physics.y, .width = self.physics.width, .height = self.physics.height };
        ray.DrawRectangleRec(rec, ray.WHITE);
    }
};
