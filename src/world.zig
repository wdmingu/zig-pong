const std = @import("std");
const object = @import("object.zig");
const state = @import("state.zig");
const _render_ = @import("render.zig");
const input = @import("input.zig");

pub const World = struct {
    windowHeight: f32,
    windowWidth: f32,
    gameObjects: std.ArrayList(object.GameObject),

    pub fn init(allocator: std.mem.Allocator, windowHeight: f32, windowWidth: f32 ) !World {
        const paddle1: object.GameObject = .{.state = state.State{.x = 50, 
                                                                 .y = 50, 
                                                                 .dx = 0, 
                                                                 .dy = 0, 
                                                                 .width = 5, 
                                                                 .height = 50, 
                                                                 .windowHeight = windowHeight, 
                                                                 .windowWidth = windowWidth},
                                          .doHandleInput = input.demoController,
                                          .doUpdateState = state.updatePaddleState,
                                          .doRender      = _render_.renderPaddle,
                                         };
        const paddle2: object.GameObject = .{.state = state.State{.x = windowWidth - 50, 
                                                                 .y = 50, 
                                                                 .dx = 0, 
                                                                 .dy = 0, 
                                                                 .width = 5, 
                                                                 .height = 50, 
                                                                 .windowHeight = windowHeight, 
                                                                 .windowWidth = windowWidth},
                                          .doHandleInput = input.demoController,
                                          .doUpdateState = state.updatePaddleState,
                                          .doRender      = _render_.renderPaddle,
                                         };
        var gameObjects = std.ArrayList(object.GameObject).init(allocator);
        try gameObjects.append(paddle1);
        try gameObjects.append(paddle2);
        return World{.windowHeight = windowHeight, .windowWidth = windowWidth, .gameObjects = gameObjects};
    }

    pub fn handleInput(self: *World) void {
        // TODO: Make async
        for (self.gameObjects.items[0..self.gameObjects.items.len]) |*gameObject| {
            gameObject.handleInput();
        }
    }

    pub fn updateState(self: *World, dt: f32) void {
        // This cannot be asynchronous if the game is to be deterministic.
        for (self.gameObjects.items[0..self.gameObjects.items.len]) |*gameObject| {
            gameObject.updateState(dt);
        }
    }

    pub fn render(self: *World) void {
        // TODO: Make async
        for (self.gameObjects.items[0..self.gameObjects.items.len]) |*gameObject| {
            gameObject.render();
        }
    }

    pub fn deinit(self: *World) void {
        self.gameObjects.deinit();
    }

};