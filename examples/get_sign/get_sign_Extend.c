/*
 * First KLEE tutorial: testing a small function
 */
#include <klee/klee.h>
#include <stdio.h>
#include <string.h>

int isEqual(char digesta[], char digestb[]) {
	for (int i = 0; i < 6; i++) {
		if (digesta[0] != digestb[0]) {
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
  klee_set_taint(1, &attempt, sizeof(attempt));

  char cloneAttempt[6];
  cloneAttempt[0] = attempt[0] << 2;

  klee_get_taint (&cloneAttempt, sizeof (cloneAttempt));

  isEqual(key,cloneAttempt);

} 
