#include<iostream>
#include<time.h>
//#include<x86intrin.h>
#include<immintrin.h>

using namespace std;
#define REAL_T double 

void printFlops(int A_height, int B_width, int B_height, clock_t start, clock_t stop ){
	REAL_T flops = ( 2.0 * A_height * B_width * B_height ) / 1E9 /((stop -  start)/(CLOCKS_PER_SEC * 1.0));
	cout<<"GFLOPS:\t"<<flops<<endl;
}

void initMatrix( int n, REAL_T *A, REAL_T *B, REAL_T *C ){
	for( int i = 0; i < n; ++i )
		for( int j = 0; j < n; ++j ){
			A[i+j*n] = (i+j + (i*j)%100 ) %100;
			B[i+j*n] = ((i-j)*(i-j) + (i*j)%200 ) %100;
			C[i+j*n] = 0;
		}
}

void dgemm( int n, REAL_T *A, REAL_T *B, REAL_T *C){
	for( int i = 0; i < n; ++i )
		for( int j = 0; j < n; ++j ){
			REAL_T cij = C[i+j*n];
			for( int k = 0; k < n; k++ ){
				cij += A[i+k*n] * B[k+j*n];
			}
			C[i+j*n] = cij;
		}
}

void avx_dgemm(int n, REAL_T *A, REAL_T *B, REAL_T *C){
	for( int i = 0; i < n; i+=4 )
		for( int j = 0; j < n; ++j ){
			__m256d cij = _mm256_load_pd( C+i+j*n );
			for( int k = 0; k < n; k++ ){
				//cij += A[i+k*n] * B[k+j*n];
				cij = _mm256_add_pd( 
						cij, 
						_mm256_mul_pd( _mm256_load_pd(A+i+k*n),  _mm256_load_pd(B+i+k*n) )
						);
			}
			_mm256_store_pd(C+i+j*n,cij);
		}
}

#define UNROLL (4)

void pavx_dgemm(int n, REAL_T *A, REAL_T *B, REAL_T *C){
	for( int i = 0; i < n; i+=4*UNROLL )
		for( int j = 0; j < n; ++j ){
			__m256d cij[4];
			for( int x = 0; x < UNROLL; ++x)
				cij[x]= _mm256_load_pd( C+i+j*n );

			for( int k = 0; k < n; k++ ){
				//cij += A[i+k*n] * B[k+j*n];
				/*cij = _mm256_add_pd( 
						cij, 
						_mm256_mul_pd( _mm256_load_pd(A+i+k*n),  _mm256_load_pd(B+i+k*n) )
						);*/
				__m256d b = _mm256_broadcast_sd( B+k+j*n );
				for( int x = 0; x <UNROLL; ++x)
					cij[x] = _mm256_add_pd( 
						cij[x], 
						_mm256_mul_pd( _mm256_load_pd(A+i+4*x+k*n),  b ) );
			}
			for( int x = 0; x < UNROLL; ++x)
				_mm256_store_pd( C+i+x*4 +j*n, cij[x]);
		}
}

#define BLOCKSIZE (32)
void do_block( int n, int si, int sj, int sk, REAL_T *A, REAL_T *B, REAL_T *C){
	for( int i = si; i < si + BLOCKSIZE; i+=UNROLL*4 )
		for( int j = sj; j < sj + BLOCKSIZE; ++j){
			__m256d c[4];
			for( int x = 0; x < UNROLL; ++x )
				c[x] = _mm256_load_pd( C+i+4*x+j*n );

			for( int k = sk; k < sk + BLOCKSIZE; ++k ){
				__m256d b = b = _mm256_broadcast_sd( B+k+j*n );
				for( int x = 0; x <UNROLL; ++x)
					c[x] = _mm256_add_pd( 
						c[x], 
						_mm256_mul_pd( _mm256_load_pd(A+i+4*x+k*n),  b ) );
			}

			for( int x = 0; x < UNROLL; ++x)
				_mm256_store_pd( C+i+x*4+j*n, c[x]);
		}
}


void block_gemm(int n, REAL_T *A, REAL_T *B, REAL_T *C){
	for( int sj = 0; sj <n; sj+=BLOCKSIZE)
		for( int si = 0; si <n; si+=BLOCKSIZE)
			for( int sk = 0; sk <n; sk+=BLOCKSIZE)
				do_block( n, si, sj, sk, A, B, C);
}

void omp_gemm(int n, REAL_T *A, REAL_T *B, REAL_T *C){
#pragma omp parallel for
	for( int sj = 0; sj <n; sj+=BLOCKSIZE)
		for( int si = 0; si <n; si+=BLOCKSIZE)
			for( int sk = 0; sk <n; sk+=BLOCKSIZE)
				do_block( n, si, sj, sk, A, B, C);
}

void main()
{
	REAL_T *A, *B, *C;
	clock_t start,stop;
	int n = 1024;
	A = new REAL_T[n*n];
	B = new REAL_T[n*n];
	C = new REAL_T[n*n];
	initMatrix(n, A, B, C);
	
	cout<< "origin caculation begin...\n";
	start = clock();
	dgemm( n, A, B, C );
	stop = clock();
	cout <<(stop - start)/CLOCKS_PER_SEC<<"."<<(stop - start)%CLOCKS_PER_SEC<<"\t\t";
	printFlops(n, n, n, start, stop);

	initMatrix(n, A, B, C);
	cout<< "AVX caculation begin...\n";
	start = clock();
	avx_dgemm( n, A, B, C );
	stop = clock();
	cout <<(stop - start)/CLOCKS_PER_SEC<<"."<<(stop - start)%CLOCKS_PER_SEC<<"\t\t";
	printFlops(n, n, n, start, stop);

	initMatrix(n, A, B, C);
	cout<< "parallel AVX caculation begin...\n";
	start = clock();
	pavx_dgemm( n, A, B, C );
	stop = clock();
	cout <<(stop - start)/CLOCKS_PER_SEC<<"."<<(stop - start)%CLOCKS_PER_SEC<<"\t\t";
	printFlops(n, n, n, start, stop);

	initMatrix(n, A, B, C);
	cout<< "blocked AVX caculation begin...\n";
	start = clock();
	block_gemm( n, A, B, C );
	stop = clock();
	cout <<(stop - start)/CLOCKS_PER_SEC<<"."<<(stop - start)%CLOCKS_PER_SEC<<"\t\t";
	printFlops(n, n, n, start, stop);

	initMatrix(n, A, B, C);
	cout<< "OpenMP blocked AVX caculation begin...\n";
	start = clock();
	omp_gemm( n, A, B, C );
	stop = clock();
	cout <<(stop - start)/CLOCKS_PER_SEC<<"."<<(stop - start)%CLOCKS_PER_SEC<<"\t\t";
	printFlops(n, n, n, start, stop);
}