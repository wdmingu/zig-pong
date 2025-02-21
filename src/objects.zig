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

pub const Object = union(enum) {
    bar: Bar,
    ball: Ball,

    pub fn handleInput(self: *Object) void {
        switch (self.*) {
            inline else => |*obj| obj.handleInput(),
        }
    }
    pub fn updatePhysics(self: *Object, dt: f32) void {
        switch (self.*) {
            inline else => |*obj| obj.updatePhysics(dt),
        }
    }
    pub fn render(self: *Object, ray: anytype) void {
        switch (self.*) {
            inline else => |*obj| obj.render(ray),
        }
    }
};

pub const Bar = struct {
    physics: Physics,

    pub fn handleInput(self: *Bar) void {
        // assume user is holding down
        self.physics.dy = 20;
    }

    pub fn updatePhysics(self: *Bar, dt: f32) void {
        self.physics.y = self.physics.y + dt * self.physics.dy;

        // Trivial collision resolution
        if (self.physics.y + self.physics.height > self.physics.windowHeight) {
            self.physics.y = self.physics.height;
        }
    }

    pub fn render(self: *Bar, ray: anytype) void {
        const rec = ray.Rectangle{ .x = self.physics.x, .y = self.physics.y, .width = self.physics.width, .height = self.physics.height };
        ray.DrawRectangleRec(rec, ray.WHITE);
    }
};

pub const Ball = struct {
    physics: Physics,

    pub fn handleInput(self: *Ball) void {
        // Not implemented
        _ = self;
    }

    pub fn updatePhysics(self: *Ball, dt: f32) void {
        // Not implemented
        _ = self;
        _ = dt;
    }

    pub fn render(self: *Ball, ray: anytype) void {
        // Not implemented
        _ = self;
        _ = ray;
    }
};
