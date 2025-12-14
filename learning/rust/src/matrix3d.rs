use crate::vector3d::Vector3D;
use std::ops::{Index, IndexMut};

#[derive(Default)]
struct Matrix3D {
    n: [[f64; 3]; 3],
}

impl Matrix3D {
    fn new(
        n00: f64, n01: f64, n02: f64,
        n10: f64, n11: f64, n12: f64,
        n20: f64, n21: f64, n22: f64
    ) -> Self {
        Matrix3D {
            n: [
                [n00, n01, n02],
                [n10, n11, n12],
                [n20, n21, n22],
            ],
        }
    }

    fn from_vectors(a: &Vector3D, b: &Vector3D, c: &Vector3D) -> Self {
        Matrix3D {
            n: [
                [a.x, a.y, a.z],
                [b.x, b.y, b.z],
                [c.x, c.y, c.z],
            ],
        }
    }

    fn row(&self, i:usize) -> Vector3D {
        Vector3D::new(self.n[i][0], self.n[i][1], self.n[i][2])
    }
}

impl Index<usize> for Matrix3D {
    type Output = [f64; 3];
    fn index(&self, i: usize) -> &Self::Output {
        if i >= self.n.len() {
            panic!("Index out of matric bounds");
        }
        &self.n[i]
    }
}

impl IndexMut<usize> for Matrix3D {
    fn index_mut(&mut self, i: usize) -> &mut Self::Output {
        if i >= self.n.len() {
            panic!("Index out of matric bounds");
        }
        &mut self.n[i]
    }
}