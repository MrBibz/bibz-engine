const std = @import("std");
const expect = std.testing.expect;
const sqrt = std.math.sqrt;

const Vector3D = struct {
    x: f64, 
    y: f64, 
    z: f64,

    fn default() Vector3D {
        return Vector3D {
            .x = undefined,
            .y = undefined,
            .z = undefined,
        };
    }

    fn new(x: f64, y: f64, z: f64) Vector3D {
        return Vector3D {
            .x = x,
            .y = y,
            .z = z,
        };
    }

    fn add(self: Vector3D, other: Vector3D) Vector3D {
        return Vector3D {
            .x = self.x + other.x,
            .y = self.y + other.y,
            .z = self.z + other.z,
        };
    }

    fn add_assign(self: *Vector3D, other: Vector3D) void {
        self.x += other.x;
        self.y += other.y;
        self.z += other.z;
    }

    fn div(self: Vector3D, d: f64) Vector3D {
        const s = 1.0 / d;
        return Vector3D {
            .x = self.x * s,
            .y = self.y * s,
            .z = self.z * s,
        };
    }

    fn div_assign(self: *Vector3D, d: f64) void {
        const s = 1.0 / d;
        self.x *= s;
        self.y *= s;
        self.z *= s;
    }

    fn mag(self: Vector3D) f64 {
        return sqrt(
            self.x * self.x +
            self.y * self.y +
            self.z * self.z
        );
    }

    fn mul(self: Vector3D, m: f64) Vector3D {
        return Vector3D {
            .x = self.x * m,
            .y = self.y * m,
            .z = self.z * m,
        };
    }

    fn mul_assign(self: *Vector3D, m: f64) void {
        self.x *= m;
        self.y *= m;
        self.z *= m;
    }

    fn neg(self: Vector3D) Vector3D {
        return Vector3D {
            .x = -self.x,
            .y = -self.y,
            .z = -self.z,
        };
    }

    fn norm(self: Vector3D) Vector3D {
        return self.div(self.mag());
    }

    fn sub(self: Vector3D, other: Vector3D) Vector3D {
        return Vector3D {
            .x = self.x - other.x,
            .y = self.y - other.y,
            .z = self.z - other.z,
        };
    }

    fn sub_assign(self: *Vector3D, other: Vector3D) void {
        self.x -= other.x;
        self.y -= other.y;
        self.z -= other.z;
    }
};

const EPS_F64: f64 = 1e-6;

fn approx_f64(a: f64, b: f64) bool {
    const d = a - b;
    return if (d < 0.0) -d < EPS_F64 else d < EPS_F64;
}

test "default then assign fields" {
    var v = Vector3D.default();
    v.x = 1.0;
    v.y = 2.0;
    v.z = 3.0;
    try expect(v.x == 1.0);
    try expect(v.y == 2.0);
    try expect(v.z == 3.0);
}

test "add" {
    const v1 = Vector3D.new(1.0, 2.0, 3.0);
    const v2 = Vector3D.new(2.0, 3.0, 4.0);
    const v3 = v1.add(v2);
    try expect(v3.x == 3.0);
    try expect(v3.y == 5.0);
    try expect(v3.z == 7.0);
}

test "add_assign" {
    var v1 = Vector3D.new(1.0, 2.0, 3.0);
    const v2 = Vector3D.new(2.0, 3.0, 4.0);
    v1.add_assign(v2);
    try expect(v1.x == 3.0);
    try expect(v1.y == 5.0);
    try expect(v1.z == 7.0);
}

test "new" {
    const v = Vector3D.new(1.0, 2.0, 3.0);
    try expect(v.x == 1.0);
    try expect(v.y == 2.0);
    try expect(v.z == 3.0);
}

test "div" {
    const v = Vector3D.new(2.0, 4.0, 6.0);
    const r = v.div(2.0);
    try expect(r.x == 1.0);
    try expect(r.y == 2.0);
    try expect(r.z == 3.0);
}

test "div_assign" {
    var v = Vector3D.new(2.0, 4.0, 6.0);
    v.div_assign(2.0);
    try expect(v.x == 1.0);
    try expect(v.y == 2.0);
    try expect(v.z == 3.0);
}

test "mag" {
    const v = Vector3D.new(1.0, 2.0, 2.0);
    try expect(approx_f64(v.mag(), 3.0));
}

test "mul" {
    const v = Vector3D.new(1.0, 2.0, 3.0);
    const r = v.mul(2.0);
    try expect(r.x == 2.0);
    try expect(r.y == 4.0);
    try expect(r.z == 6.0);
}

test "mul_assign" {
    var v = Vector3D.new(1.0, 2.0, 3.0);
    v.mul_assign(3.0);
    try expect(v.x == 3.0);
    try expect(v.y == 6.0);
    try expect(v.z == 9.0);
}

test "neg" {
    const v = Vector3D.new(1.0, -2.0, 3.0);
    const r = v.neg();
    try expect(r.x == -1.0);
    try expect(r.y == 2.0);
    try expect(r.z == -3.0);
}

test "norm" {
    const v = Vector3D.new(3.0, 0.0, 0.0);
    const n = v.norm();
    try expect(approx_f64(n.mag(), 1.0));
}

test "sub" {
    const v1 = Vector3D.new(3.0, 5.0, 7.0);
    const v2 = Vector3D.new(2.0, 3.0, 4.0);
    const v3 = v1.sub(v2);
    try expect(v3.x == 1.0);
    try expect(v3.y == 2.0);
    try expect(v3.z == 3.0);
}

test "sub_assign" {
    var v1 = Vector3D.new(3.0, 5.0, 7.0);
    const v2 = Vector3D.new(2.0, 3.0, 4.0);
    v1.sub_assign(v2);
    try expect(v1.x == 1.0);
    try expect(v1.y == 2.0);
    try expect(v1.z == 3.0);
}