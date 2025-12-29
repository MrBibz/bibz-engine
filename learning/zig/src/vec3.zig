const std = @import("std");
const expect = std.testing.expect;
const sqrt = std.math.sqrt;

pub const Vec3 = struct {
    x: f32,
    y: f32,
    z: f32,

    fn add(self: Vec3, other: Vec3) Vec3 {
        return Vec3.new(self.x + other.x, self.y + other.y, self.z + other.z);
    }

    fn add_assign(self: *Vec3, other: Vec3) void {
        self.x += other.x;
        self.y += other.y;
        self.z += other.z;
    }

    fn div(self: Vec3, d: f32) Vec3 {
        const S = 1.0 / d;

        return Vec3.new(self.x * S, self.y * S, self.z * S);
    }

    fn div_assign(self: *Vec3, d: f32) void {
        const S = 1.0 / d;

        self.x *= S;
        self.y *= S;
        self.z *= S;
    }

    fn equals(self: Vec3, other: Vec3) bool {
        return self.x == other.x and
            self.y == other.y and
            self.z == other.z;
    }

    fn get(self: Vec3, idx: u8) Vec3Error!f32 {
        return switch (idx) {
            0 => self.x,
            1 => self.y,
            2 => self.z,
            else => Vec3Error.IndexOutOfBounds,
        };
    }

    fn mag(self: Vec3) f32 {
        return sqrt(self.x * self.x +
            self.y * self.y +
            self.z * self.z);
    }

    fn mult(self: Vec3, s: f32) Vec3 {
        return Vec3.new(
            self.x * s,
            self.y * s,
            self.z * s,
        );
    }

    fn mult_assign(self: *Vec3, s: f32) void {
        self.x *= s;
        self.y *= s;
        self.z *= s;
    }

    fn neg(self: Vec3) Vec3 {
        return Vec3.new(-self.x, -self.y, -self.z);
    }

    pub fn new(x: f32, y: f32, z: f32) Vec3 {
        return Vec3{ .x = @as(f32, x), .y = @as(f32, y), .z = @as(f32, z) };
    }

    fn norm(self: Vec3) Vec3 {
        return self.div(self.mag());
    }

    fn sub(self: Vec3, other: Vec3) Vec3 {
        return Vec3.new(self.x - other.x, self.y - other.y, self.z - other.z);
    }

    fn sub_assign(self: *Vec3, other: Vec3) void {
        self.x -= other.x;
        self.y -= other.y;
        self.z -= other.z;
    }
};

const Vec3Error = error{IndexOutOfBounds};

const EPS_F32: f32 = 1e-6;

fn approx_f32(a: f32, b: f32) bool {
    const d = a - b;
    return if (d < 0) -d < EPS_F32 else d < EPS_F32;
}

test "add" {
    const V1 = Vec3.new(1, 2, 3);
    const V2 = Vec3.new(4, 5, 6);
    const EXPECTED = Vec3.new(5, 7, 9);

    try expect(EXPECTED.equals(V1.add(V2)));
}

test "add_assign" {
    var v1 = Vec3.new(1, 2, 3);
    const V2 = Vec3.new(4, 5, 6);
    const EXPECTED = Vec3.new(5, 7, 9);

    v1.add_assign(V2);

    try expect(EXPECTED.equals(v1));
}

test "div" {
    const V = Vec3.new(2, 4, 6);
    const EXPECTED = Vec3.new(1, 2, 3);

    try expect(EXPECTED.equals(V.div(2)));
}

test "div_assign" {
    var v = Vec3.new(2, 4, 6);
    const EXPECTED = Vec3.new(1, 2, 3);

    v.div_assign(2);

    try expect(EXPECTED.equals(v));
}

test "get" {
    const V = Vec3.new(1, 2, 3);
    const EXPECTED = Vec3.new(try V.get(0), try V.get(1), try V.get(2));

    try expect(EXPECTED.equals(V));
}

test "mag" {
    const V = Vec3.new(1, 2, 2);

    try expect(approx_f32(V.mag(), 3));
}

test "mult" {
    const V = Vec3.new(1, 2, 3);
    const EXPECTED = Vec3.new(2, 4, 6);

    try expect(EXPECTED.equals(V.mult(2)));
}

test "mult_assign" {
    var v = Vec3.new(1, 2, 3);
    const EXPECTED = Vec3.new(2, 4, 6);

    v.mult_assign(2);

    try expect(EXPECTED.equals(v));
}

test "neg" {
    const V = Vec3.new(1, 2, 3);
    const EXPECTED = Vec3.new(-1, -2, -3);

    try expect(EXPECTED.equals(V.neg()));
}

test "norm" {
    const V = Vec3.new(3, 0, 0);
    const N = V.norm();

    try expect(approx_f32(N.mag(), 1));
}

test "sub" {
    const V1 = Vec3.new(5, 7, 9);
    const V2 = Vec3.new(4, 5, 6);
    const EXPECTED = Vec3.new(1, 2, 3);

    try expect(EXPECTED.equals(V1.sub(V2)));
}

test "sub_assign" {
    var v1 = Vec3.new(5, 7, 9);
    const V2 = Vec3.new(4, 5, 6);
    const EXPECTED = Vec3.new(1, 2, 3);

    v1.sub_assign(V2);

    try expect(EXPECTED.equals(v1));
}
