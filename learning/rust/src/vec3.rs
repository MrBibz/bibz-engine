use std::ops::{Add, AddAssign, Neg, Sub, SubAssign};

#[derive(Debug, PartialEq)]
struct Vec3 {
    x: f32,
    y: f32,
    z: f32,
}

impl Vec3 {
    fn mag(&self) -> f32 {
        (
            self.x * self.x +
            self.y * self.y +
            self.z * self.z
        ).sqrt()
    }
    
    fn new(x: f32, y: f32, z: f32) -> Self {
        Self { x, y, z }
    }

    fn norm(&self) -> Self {
        self.scalar_div(self.mag())
    }

    fn scalar_div(&self, d: f32) -> Self {
        let s = 1.0 / d;

        Self {
            x: self.x * s,
            y: self.y * s,
            z: self.z * s,
        }   
    }

    fn scalar_div_assign(&mut self, d: f32) {
        let s = 1.0 / d;

        self.x *= s;
        self.y *= s;
        self.z *= s;
    }

    fn scalar_mult(&self, s: f32) -> Self {
        Self {
            x: self.x * s,
            y: self.y * s,
            z: self.z * s,
        }
    }

    fn scalar_mult_assign(&mut self, s: f32) {
        self.x *= s;
        self.y *= s;
        self.z *= s;
    }
}

impl Add for Vec3 {
    type Output = Self;

    fn add(self, other: Self) -> Self {
        Self {
            x: self.x + other.x,
            y: self.y + other.y,
            z: self.z + other.z,
        }
    }
}

impl AddAssign for Vec3 {
    fn add_assign(&mut self, other: Self) {
        self.x += other.x;
        self.y += other.y;
        self.z += other.z;
    }
}

impl Neg for Vec3 {
    type Output = Self;
    
    fn neg(self) -> Self {
        Self {
            x: -self.x,
            y: -self.y,
            z: -self.z,
        }
    }
}

impl Sub for Vec3 {
    type Output = Self;

    fn sub(self, other: Self) -> Self {
        Self {
            x: self.x - other.x,
            y: self.y - other.y,
            z: self.z - other.z,
        }
    }
}

impl SubAssign for Vec3 {
    fn sub_assign(&mut self, other: Self) {
        self.x -= other.x;
        self.y -= other.y;
        self.z -= other.z;
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    const EPS_F32: f32 = 1e-6;

    fn approx_f32(a: f32, b: f32) -> bool {
        let d = a - b;

        match d < 0.0 {
            true => { -d < EPS_F32 },
            false => { d < EPS_F32 }
        }
    }

    #[test]
    fn test_add() {
        let v1 = Vec3::new(1.0, 2.0, 3.0);
        let v2 = Vec3::new(4.0, 5.0, 6.0);
        let expected = Vec3::new(5.0, 7.0, 9.0);

        assert_eq!(expected, v1 + v2);
    }

    #[test]
    fn test_add_assign() {
        let mut v1 = Vec3::new(1.0, 2.0, 3.0);
        let v2 = Vec3::new(4.0, 5.0, 6.0);
        let expected = Vec3::new(5.0, 7.0, 9.0);

        v1 += v2;

        assert_eq!(expected, v1);
    }

    #[test]
    fn test_mag() {
        let v = Vec3::new(1.0, 2.0, 2.0);

        assert!(approx_f32(v.mag(), 3.0));
    }

    #[test]
    fn test_neg() {
        let v = Vec3::new(1.0, 2.0, 3.0);
        let expected = Vec3::new(-1.0, -2.0, -3.0);

        assert_eq!(expected, -v);
    }

    #[test]
    fn test_norm() {
        let v = Vec3::new(3.0, 0.0, 0.0);
        let n = v.norm();

        assert!(approx_f32(n.mag(), 1.0));
    }


    #[test]
    fn test_scalar_div() {
        let v = Vec3::new(2.0, 4.0, 6.0);
        let expected = Vec3::new(1.0, 2.0, 3.0);

        assert_eq!(expected, v.scalar_div(2.0));
    }

    #[test]
    fn test_scalar_div_assign() {
        let mut v = Vec3::new(2.0, 4.0, 6.0);
        let expected = Vec3::new(1.0, 2.0, 3.0);

        v.scalar_div_assign(2.0);

        assert_eq!(expected, v);
    }
    
    #[test]
    fn test_scalar_mult() {
        let v = Vec3::new(1.0, 2.0, 3.0);
        let expected = Vec3::new(2.0, 4.0, 6.0);

        assert_eq!(expected, v.scalar_mult(2.0));
    }

    #[test]
    fn test_scalar_mult_assign() {
        let mut v = Vec3::new(1.0, 2.0, 3.0);
        let expected = Vec3::new(2.0, 4.0, 6.0);

        v.scalar_mult_assign(2.0);

        assert_eq!(expected, v);
    }

    #[test]
    fn test_sub() {
        let v1 = Vec3::new(5.0, 7.0, 9.0);
        let v2 = Vec3::new(4.0, 5.0, 6.0);
        let expected = Vec3::new(1.0, 2.0, 3.0);

        assert_eq!(expected, v1 - v2);
    }

    #[test]
    fn test_sub_assign() {
        let mut v1 = Vec3::new(5.0, 7.0, 9.0);
        let v2 = Vec3::new(4.0, 5.0, 6.0);
        let expected = Vec3::new(1.0, 2.0, 3.0);

        v1 -= v2;

        assert_eq!(expected, v1);
    }
}
