/*
 * First KLEE tutorial: testing a small function
 */
#include <klee/klee.h>
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
int isEqual(char digesta[], char digestb[]) {
	for (int i = 0; i < 2; i++) {
		if (digesta[i] != digestb[i]) {
			if(digesta[i] > 0)
			   return 0;
		}

	}
    return 1;
}

int main() {
  char key[6];
  klee_make_symbolic(&key, sizeof(key), "key");

  char attempt[6];
  klee_make_symbolic(&attempt, sizeof(attempt), "attempt");

  char another_key[6];
  klee_make_symbolic(&another_key, sizeof(another_key), "anotherKey");

  klee_set_taint(1, &key, sizeof(key));
  klee_set_taint(2, &another_key, sizeof(another_key));


  if(attempt[0] > 0)
	  isEqual(key,attempt);
  else isEqual(another_key,attempt);


} 
