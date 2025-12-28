const std = @import("std");
const expect = std.testing.expect;
const vec3 = @import("vec3.zig");
const Vec3 = vec3.Vec3;

const Mat3 = struct {
    n: [3][3]f32,

    fn equals(self: Mat3, other: Mat3) bool {
        return self.n[0][0] == other.n[0][0] and self.n[0][1] == other.n[0][1] and self.n[0][2] == other.n[0][2] and
            self.n[1][0] == other.n[1][0] and self.n[1][1] == other.n[1][1] and self.n[1][2] == other.n[1][2] and
            self.n[2][0] == other.n[2][0] and self.n[2][1] == other.n[2][1] and self.n[2][2] == other.n[2][2];
    }

    fn from_vectors(v1: Vec3, v2: Vec3, v3: Vec3) Mat3 {
        return Mat3{
            .n = .{
                .{ v1.x, v1.y, v1.z },
                .{ v2.x, v2.y, v2.z },
                .{ v3.x, v3.y, v3.z },
            },
        };
    }

    fn new(n00: f32, n01: f32, n02: f32, n10: f32, n11: f32, n12: f32, n20: f32, n21: f32, n22: f32) Mat3 {
        return Mat3{
            .n = .{
                .{ n00, n01, n02 },
                .{ n10, n11, n12 },
                .{ n20, n21, n22 },
            },
        };
    }
};

test "from_vectors" {
    const V1 = Vec3.new(1, 2, 3);
    const V2 = Vec3.new(4, 5, 6);
    const V3 = Vec3.new(7, 8, 9);
    const EXPECTED = Mat3.new(1, 2, 3, 4, 5, 6, 7, 8, 9);

    try expect(EXPECTED.equals(Mat3.from_vectors(V1, V2, V3)));
}
