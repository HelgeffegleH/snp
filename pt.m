% snp new point calculator.
function new = pt(Z)
	% Constants
	u1 = 0.5;
	u2 = 1.5;
	u3 = 2.5;
	u4 = 3.5;

	b0 = u1 ^ 3 / 6;
	b1 = (u2 ^ 2 * (2 - u2) + u2 * (3 - u2) * (u2 - 1) + (4 - u2) * (u2 - 1) ^ 2) / 6;
	b2 = ((4 - u3) ^ 2 * (u3 - 2) + (3- u3) * (4 - u3) * (u3 - 1) + u3 * (3 - u3) ^ 2) / 6;
	b3 = (4 - u4) ^ 3 / 6;

	new = b0 * Z(1) + b1 * Z(2) + b2 * Z(3) + b3 * Z(4);
end