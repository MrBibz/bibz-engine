const std = @import("std");
const Vector3D = @import("vector3d");
const expect = std.testing.expect;

const Matrix3D = struct {
    n: [3][3]f64,

    fn new(
        n00: f64, n01: f64, n02: f64,
        n10: f64, n11: f64, n12: f64,
        n20: f64, n21: f64, n22: f64
    ) Matrix3D {    
        return Matrix3D {
            .n = .{
                .{n00, n01, n02},
                .{n10, n11, n12},
                .{n20, n21, n22}
            }
        };
    }

    fn from_vectors(a: Vector3D, b: Vector3D, c: Vector3D) Matrix3D {
        return Matrix3D {
            .n = .{
                .{a.x, a.y, a.z},
                .{b.x, b.y, b.z},
                .{c.x, c.y, c.z}
            }
        };
    }
};