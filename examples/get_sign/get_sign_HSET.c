/*
 * First KLEE tutorial: testing a small function
 */
#include <klee/klee.h>
#include <stdio.h>
#include <string.h>

int main() {
  int x;
  klee_make_symbolic(&x, sizeof(x), "x");

  if(x < 1){
	  x = x + 1;
  }

  if(x < 3){
	  x = x + 1;
	  x = x + 2;
	  x = x + 3;
  }
} 
