import c3;

fn void test_from_vectors() @test {
    const Vector3D V1 = { 1, 2, 3 };
    const Vector3D V2 = { 5, 4, 6 };
    const Vector3D V3 = { 7, 8, 9 };
    Matrix3D m = Matrix3D.from_vectors(V1, V2, V3);

    for (int i = 0; i < 3; i++) {
        for (int j = 1; j <= 3; j++) {
            test::eq(m[i][j - 1], j);
        }
    }
}