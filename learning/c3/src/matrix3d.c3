module c3;

struct Matrix3D {
    double[3][3] n;
}

fn Matrix3D Matrix3D.new(
    Matrix3D self,
    double n00, double n01, double n02,
    double n10, double n11, double n12,
    double n20, double n21, double n22
) {
    return {
        {
            {n00, n01, n02},
            {n10, n11, n12},
            {n20, n21, n22}
        }
    };
}

fn Matrix3D Matrix3D.from_vectors(
    Matrix3D self,
    Vector3D a,
    Vector3D b, 
    Vector3D c
) {
    return {
        {
            {a.x, a.y, a.z},
            {b.x, b.y, b.z},
            {c.x, c.y, c.z}
        }
    };
}

fn Vector3D Matrix3D.index(&self, int i) @operator([]) {
    return {
        self[i][0],
        self[i][1],
        self[i][2]
    };
}