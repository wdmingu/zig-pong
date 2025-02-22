const object = @import("object.zig");

pub fn demoController(self: *object.GameObject) void {
    self.state.dy = 20;
}

pub fn inputController(self: *object.GameObject) void {
    // Not implemented
    _ = self;
}

pub fn aiController(self: *object.GameObject) void {
    // Not implemented
    _ = self;
}
