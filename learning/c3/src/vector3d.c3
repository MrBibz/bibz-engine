module c3;

import std::io;
import std::math;
import std::os;

faultdef INDEX_OUT_OF_BOUNDS;

struct Vector3D {
	double x;
	double y;
	double z;
}

fn Vector3D Vector3D.def(self) {
	return { 0, 0, 0 };
}

fn Vector3D Vector3D.add(self, Vector3D other) @operator(+) {
	return {
		self.x + other.x,
		self.y + other.y,
		self.z + other.z
	};
}

fn void Vector3D.add_assign(&self, Vector3D other) @operator(+=) {
	self.x += other.x;
	self.y += other.y;
	self.z += other.z;
}

fn Vector3D Vector3D.div(self, double div) @operator(/) {
	double s = 1 / div;
	return {
		self.x * s,
		self.y * s,
		self.z * s,
	};
}

fn void Vector3D.div_assign(&self, double div) @operator(/=) {
	double s = 1 / div;
	self.x *= s;
	self.y *= s;
	self.z *= s;
}

fn double? Vector3D.index(&self, int i) @operator([]) {
	switch (i) {
		case 0:
			return self.x;
		case 1:
			return self.y;
		case 2:
			return self.z;
		default:
			io::printfn("Error: %s", INDEX_OUT_OF_BOUNDS);
			os::exit(1);
	}
}

fn double Vector3D.mag(self) {
	return math::sqrt(
		self.x * self.x +
		self.y * self.y +
		self.z * self.z
	);
}

fn Vector3D Vector3D.mult(self, double m) @operator(*) {
	return {
		self.x * m,
		self.y * m,
		self.z * m
	};
}

fn void Vector3D.mult_assign(&self, double m) @operator(*=) {
	self.x *= m;
	self.y *= m;
	self.z *= m;
}

fn Vector3D Vector3D.neg(self) {
	return {
		-self.x,
		-self.y,
		-self.z
	};
}

fn Vector3D Vector3D.norm(self) {
	return self / self.mag();
}

fn Vector3D Vector3D.sub(self, Vector3D other) @operator(-) {
	return {
		self.x - other.x,
		self.y - other.y,
		self.z - other.z
	};
}

fn void Vector3D.sub_assign(&self, Vector3D other) @operator(-=) {
	self.x -= other.x;
	self.y -= other.y;
	self.z -= other.z;
}