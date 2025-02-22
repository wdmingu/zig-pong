const state = @import("state.zig");

pub const GameObject = struct {
    state: state.State,
    doHandleInput: *const fn (*GameObject) void,
    doUpdateState: *const fn (*GameObject, f32) void,
    doRender:      *const fn (*GameObject) void,

    pub fn handleInput(self: *GameObject) void {
        self.doHandleInput(self);
    }
    pub fn updateState(self: *GameObject, dt: f32) void {
        self.doUpdateState(self, dt);
    }
    pub fn render(self: *GameObject) void {
        self.doRender(self);
    }
};
