/*
 ============================================================================
 Name        : Pomentale.cu
 Author      : stomo
 Version     :
 Copyright   : Your copyright notice
 Description : Compute sum of reciprocals using STL on CPU and Thrust on GPU
 ============================================================================
 */

#include <iostream>
#include <cstdlib>
#include <cmath>
#include <cassert>
#include <vector>
#include <algorithm>
#include <thrust/complex.h>

#define EPS 0.000001  // 停止判定
#define MAXIT 16      // 最大反復回数

int P;  // Pomentale法の次数

// ゼロ点
std::vector< thrust::complex<double> > Zrs
{
	thrust::complex<double> (  1.0,  1.0 ),  // z1
	thrust::complex<double> ( -1.0,  1.0 ),  // z2
	thrust::complex<double> (  0.0, -1.0 )   // z3
};

// ゼロ点の重複度
std::vector<double> Mul
{
	1.0,  // n1
	2.0,  // n2
	3.0   // n3
};

// Polynomial function value
template<typename T> thrust::complex<T> Pval( thrust::complex<T> z )
{
	thrust::complex<T> tmp;
	tmp = thrust::complex<T> (1.0,0.0);


	for (int i=0; i<Zrs.size(); i++)
	{
		tmp *= pow( z - Zrs[i], Mul[i] );
	}
	return tmp;
}

int main(int argc, char *argv[])
{
	if (argc<4)
	{
		std::cerr << "Usage: a.out [Order] [Real(z0)] [Imag(z0)]\n";
		exit(EXIT_FAILURE);
	}
	P = atoi(argv[1]); // Pomentale法の次数
	assert( (P==2) | (P==4) | (P==8) | (P==16) | (P==32) );

	double rez0 = atof(argv[2]);
	double imz0 = atof(argv[3]);

	thrust::complex<double> z0 = thrust::complex<double>( rez0, imz0 );
	thrust::complex<double> z = Pval(z0);

	std::cout << "z0 = (" << z0.real() << ", " << z0.imag() << ")\n";
	std::cout << "z  = (" << z.real() << ", " << z.imag() << ")\n";

	return 0;
}
