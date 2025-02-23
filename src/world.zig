const std = @import("std");
const object = @import("object.zig");
const state = @import("state.zig");
const _render_ = @import("render.zig");
const input = @import("input.zig");

pub const World = struct {
    windowHeight: f32,
    windowWidth: f32,
    gameObjects: std.ArrayList(object.GameObject),
    maxScore: u8,

    pub fn init(allocator: std.mem.Allocator, windowHeight: f32, windowWidth: f32, maxScore: u8) !World {
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
                                             .doResolveCollision = state.resolvePaddleCollision,
                                             .doResetState = state.resetPaddleState,
                                             .score = 0,
                                             .name = "Player 1",
                                             .objectType = object.ObjectType.Paddle,
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
                                             .doResolveCollision = state.resolvePaddleCollision,
                                             .doResetState = state.resetPaddleState,
                                             .score = 0,
                                             .name = "Player 2",
                                             .objectType = object.ObjectType.Paddle,
                                            };
        var gameObjects = std.ArrayList(object.GameObject).init(allocator);
        try gameObjects.append(paddle1);
        try gameObjects.append(paddle2);
        return World{.windowHeight = windowHeight,
                     .windowWidth = windowWidth, 
                     .gameObjects = gameObjects, 
                     .maxScore = maxScore};
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

    pub fn resolveCollision(self: *World) void {
        // This cannot be asynchronous if the game is to be deterministic.
        const num_objects: usize = self.gameObjects.items.len;
        if (num_objects == 0) return;
        const num: usize = num_objects - 1;
        for (self.gameObjects.items[0..num], 0..num) |*gameObject1, i| {
            for (self.gameObjects.items[i+1..num+1]) |*gameObject2| {
                gameObject1.resolveCollision(gameObject2);
                gameObject2.resolveCollision(gameObject1);
            }
        }
    }

    pub fn render(self: *World) void {
        // TODO: Make async
        for (self.gameObjects.items[0..self.gameObjects.items.len]) |*gameObject| {
            gameObject.render();
        }
    }

    pub fn handleGameOver(self: *World) void {
        for (self.gameObjects.items[0..self.gameObjects.items.len]) |gameObject| {
            if (gameObject.score == self.maxScore) {
                std.debug.print("{s} wins.", .{gameObject.name});
                self.resetScores();
                self.resetState();
                return;
            }
        }
    }

    fn resetState(self: *World) void {
        for (self.gameObjects.items[0..self.gameObjects.items.len]) |*gameObject| {
            gameObject.resetState();
        }
    }

    fn resetScores(self: *World) void {
        // TODO: Make async
        for (self.gameObjects.items[0..self.gameObjects.items.len]) |*gameObject| {
            gameObject.score = 0;
        }
    }

    pub fn deinit(self: *World) void {
        self.gameObjects.deinit();
    }

};