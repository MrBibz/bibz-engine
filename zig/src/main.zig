const rl = @import("raylib");

pub fn main() anyerror!void {
    rl.initWindow(800, 450, "test");
    defer rl.closeWindow();

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(.white);

        rl.drawText("Fuck yeah!", 190, 200, 20, .light_gray);
    }
}
