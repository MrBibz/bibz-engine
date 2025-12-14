use std::ops::{
    Add, 
    AddAssign, 
    Div, 
    DivAssign, 
    Index, 
    IndexMut, 
    Mul, 
    MulAssign, 
    Neg,
    Sub,
    SubAssign
};

#[derive(Default)]
pub struct Vector3D {
    pub x: f64,
    pub y: f64,
    pub z: f64,
}

impl Vector3D {
    pub fn new(x: f64, y: f64, z: f64) -> Self {
        Vector3D { x, y, z }
    }

    fn mag(&self) -> f64 {
        (
            self.x * self.x + 
            self.y * self.y +
            self.z * self.z
        ).sqrt()
    }

    fn norm(self) -> Self {
        let m = self.mag();
        self / m
    }
}

impl Add for Vector3D {
    type Output = Self;
    fn add(self, other: Self) -> Self {
        Self {
            x: self.x + other.x,
            y: self.y + other.y,
            z: self.z + other.z,
        }
    }
}

impl AddAssign for Vector3D {
    fn add_assign(&mut self, other: Self) {
        self.x += other.x;
        self.y += other.y;
        self.z += other.z;
    }
}

impl Div<f64> for Vector3D {
    type Output = Self;
    fn div(self, div: f64) -> Self::Output {
        let s = 1.0 / div;
        Self { 
            x: self.x * s,
            y: self.y * s,
            z: self.z * s,
        }
    }
}

impl DivAssign<f64> for Vector3D {
    fn div_assign(&mut self, div: f64) {
        let s = 1.0 / div;
        self.x *= s;
        self.y *= s;
        self.z *= s;
    }
}

impl Index<usize> for Vector3D {
    type Output = f64;
    fn index(&self, i: usize) -> &Self::Output {
        match i {
            0 => &self.x,
            1 => &self.y,
            2 => &self.z,
            _ => panic!("Vector3D index out of bounds"),
        }
    }
}

impl IndexMut<usize> for Vector3D {
    fn index_mut(&mut self, i: usize) -> &mut Self::Output {
        match i {
            0 => &mut self.x,
            1 => &mut self.y,
            2 => &mut self.z,
            _ => panic!("Vector3D index out of bounds"),
        }
    }
}

impl Mul<f64> for Vector3D {
    type Output = Self;
    fn mul(self, mult: f64) -> Self::Output {
        Self { 
            x: self.x * mult,
            y: self.y * mult,
            z: self.z * mult,
        }
    }
}

impl MulAssign<f64> for Vector3D {
    fn mul_assign(&mut self, mult: f64) {
        self.x *= mult;
        self.y *= mult;
        self.z *= mult;
    }
}

impl Neg for Vector3D {
    type Output = Self;

    fn neg(self) -> Self {
        Self {
            x: -self.x,
            y: -self.y,
            z: -self.z,
        }
    }
}

impl Sub for Vector3D {
    type Output = Self;
    fn sub(self, other: Self) -> Self {
        Self {
            x: self.x - other.x,
            y: self.y - other.y,
            z: self.z - other.z,
        }
    }
}

impl SubAssign for Vector3D {
    fn sub_assign(&mut self, other: Self) {
        self.x -= other.x;
        self.y -= other.y;
        self.z -= other.z;
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    const EPS: f64 = 1e-6;
    fn approx(a: f64, b: f64) -> bool { (a - b).abs() < EPS }

    #[test]
    fn test_add() {
        let v1 = Vector3D::new(1.0, 2.0, 3.0);
        let v2 = Vector3D::new(2.0, 3.0, 4.0);
        let v3 = v1 + v2;
        assert!(approx(v3.x, 3.0) && approx(v3.y, 5.0) && approx(v3.z, 7.0));
    }

    #[test]
    fn test_add_assign() {
        let mut v1 = Vector3D::new(1.0, 2.0, 3.0);
        let v2 = Vector3D::new(2.0, 3.0, 4.0);
        v1 += v2;
        assert!(approx(v1.x, 3.0) && approx(v1.y, 5.0) && approx(v1.z, 7.0));
    }

    #[test]
    fn test_new() {
        let v = Vector3D::new(1.0, 2.0, 3.0);
        assert!(approx(v.x, 1.0) && approx(v.y, 2.0) && approx(v.z, 3.0));
    }

    #[test]
    fn test_mag() {
        let v = Vector3D::new(1.0, 2.0, 2.0);
        assert!(approx(v.mag(), 3.0));
    }

    #[test]
    fn test_norm() {
        let v = Vector3D::new(3.0, 0.0, 0.0);
        let n = v.norm();
        assert!(approx(n.mag(), 1.0));
    }

    #[test]
    fn test_div() {
        let v = Vector3D::new(2.0, 4.0, 6.0);
        let r = v / 2.0;
        assert!(approx(r.x, 1.0) && approx(r.y, 2.0) && approx(r.z, 3.0));
    }

    #[test]
    fn test_div_assign() {
        let mut v = Vector3D::new(2.0, 4.0, 6.0);
        v /= 2.0;
        assert!(approx(v.x, 1.0) && approx(v.y, 2.0) && approx(v.z, 3.0));
    }

    #[test]
    fn test_mul() {
        let v = Vector3D::new(1.0, 2.0, 3.0);
        let r = v * 2.0;
        assert!(approx(r.x, 2.0) && approx(r.y, 4.0) && approx(r.z, 6.0));
    }

    #[test]
    fn test_mul_assign() {
        let mut v = Vector3D::new(1.0, 2.0, 3.0);
        v *= 3.0;
        assert!(approx(v.x, 3.0) && approx(v.y, 6.0) && approx(v.z, 9.0));
    }

    #[test]
    fn test_neg() {
        let v = Vector3D::new(1.0, -2.0, 3.0);
        let r = -v;
        assert!(approx(r.x, -1.0) && approx(r.y, 2.0) && approx(r.z, -3.0));
    }

    #[test]
    fn test_index() {
        let v = Vector3D::new(5.0, 6.0, 7.0);
        assert!(approx(v[0], 5.0) && approx(v[1], 6.0) && approx(v[2], 7.0));
    }

    #[test]
    fn test_index_mut() {
        let mut v = Vector3D::new(0.0, 0.0, 0.0);
        v[1] = 9.0;
        assert!(approx(v.y, 9.0));
    }

    #[test]
    fn test_sub() {
        let v1 = Vector3D::new(3.0, 5.0, 7.0);
        let v2 = Vector3D::new(2.0, 3.0, 4.0);
        let v3 = v1 - v2;
        assert!(approx(v3.x, 1.0) && approx(v3.y, 2.0) && approx(v3.z, 3.0));
    }

    #[test]
    fn test_sub_assign() {
        let mut v1 = Vector3D::new(3.0, 5.0, 7.0);
        let v2 = Vector3D::new(2.0, 3.0, 4.0);
        v1 -= v2;
        assert!(approx(v1.x, 1.0) && approx(v1.y, 2.0) && approx(v1.z, 3.0));
    }
}