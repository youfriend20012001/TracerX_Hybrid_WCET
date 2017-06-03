/*
 * First KLEE tutorial: testing a small function
 */
//#include <klee/klee.h>
#include <stdio.h>
#include <string.h>
/**
  * Compares two digests for equality. Does a simple byte compare.
  *
  * @param digesta one of the digests to compare.
  *
  * @param digestb the other digest to compare.
  *
  * @return true if the digests are equal, false otherwise.
  */
int isEqual(int digesta[], int digestb[]) {
	for (int i = 0; i < 6; i++) {
		if (digesta[i] != digestb[i]) {
			return 0;
		}
	}
    return 1;
}

int main() {
  //Declare
  int key[6];
  int attempt[6];
  int test;

  //Set symbolic
  klee_make_symbolic(&key, sizeof(key), "key");
  klee_make_symbolic(&attempt, sizeof(attempt), "attempt");
  klee_make_symbolic(&test, sizeof(test), "test");

  //Set taint
  klee_set_taint(1, &key, sizeof(key));

  //Test
  //test = key[0] << 1;
  //advanceKey is tainted
  int advanceKey[6] = {key[0] + 1,key[1] + 1,key[2] + 1,key[3] + 1,key[4] + 1,key[5] + 1};

  if(attempt[0] > 0 && (key[0] << 1) > 1)
	  return isEqual(advanceKey,attempt);
  else return 1;
} 
