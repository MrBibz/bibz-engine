import c3;

fn void test_add() @test {
	const Vector3D V1 = { 1, 2, 3 };
	const Vector3D V2 = { 2, 3, 4 };
	Vector3D v3 = V1 + V2;

	test::eq(v3.x, 3);
	test::eq(v3.y, 5);
	test::eq(v3.z, 7);
}

fn void test_add_assign() @test {
	Vector3D v1 = { 1, 2, 3 };
	const Vector3D V2 = { 2, 3, 4 };
	v1 += V2;
    
	test::eq(v1.x, 3);
	test::eq(v1.y, 5);
	test::eq(v1.z, 7);
}

fn void test_div() @test {
	const Vector3D V1 = { 2, 4, 6 };
	Vector3D v2 = V1 / 2;

	test::eq(v2.x, 1);
	test::eq(v2.y, 2);
	test::eq(v2.z, 3);
}

fn void test_div_assign() @test {
	Vector3D v1 = { 2, 4, 6 };
	v1 /= 2;
    
	test::eq(v1.x, 1);
	test::eq(v1.y, 2);
	test::eq(v1.z, 3);
}

fn void test_mult() @test {
	const Vector3D V1 = { 1, 2, 3 };
	Vector3D v2 = V1 * 2;

	test::eq(v2.x, 2);
	test::eq(v2.y, 4);
	test::eq(v2.z, 6);
}

fn void test_mult_assign() @test {
	Vector3D v1 = { 1, 2, 3 };
	v1 *= 2;
    
	test::eq(v1.x, 2);
	test::eq(v1.y, 4);
	test::eq(v1.z, 6);
}

fn void test_neg() @test {
    const Vector3D V1 = { 1, -2, 3 };
    Vector3D v2 = V1.neg();

    test::eq(v2.x, -1);
    test::eq(v2.y, 2);
    test::eq(v2.z, -3);
}

fn void test_sub() @test {
	const Vector3D V1 = { 3, 5, 7 };
	const Vector3D V2 = { 2, 3, 4 };
	Vector3D v3 = V1 - V2;

	test::eq(v3.x, 1);
	test::eq(v3.y, 2);
	test::eq(v3.z, 3);
}

fn void test_sub_assign() @test {
	Vector3D v1 = { 3, 5, 7 };
	const Vector3D V2 = { 2, 3, 4 };
	v1 -= V2;
    
	test::eq(v1.x, 1);
	test::eq(v1.y, 2);
	test::eq(v1.z, 3);
}