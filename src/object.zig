const state = @import("state.zig");

pub const ObjectType = enum {Ball, Paddle, Wall};

pub const GameObject = struct {
    state: state.State,

    doHandleInput:      *const fn (*GameObject) void,
    doUpdateState:      *const fn (*GameObject, f32) void,
    doRender:           *const fn (*GameObject) void,
    doResolveCollision: *const fn (*GameObject, *GameObject) void,

    score: u8,
    name: []const u8,
    objectType: ObjectType,

    pub fn handleInput(self: *GameObject) void {
        self.doHandleInput(self);
    }
    pub fn updateState(self: *GameObject, dt: f32) void {
        self.doUpdateState(self, dt);
    }
    pub fn render(self: *GameObject) void {
        self.doRender(self);
    }
    pub fn resolveCollision(self: *GameObject, other: *GameObject) void {
        self.doResolveCollision(self, other);
    }
};
