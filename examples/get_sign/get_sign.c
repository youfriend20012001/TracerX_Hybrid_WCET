/*
 * First KLEE tutorial: testing a small function
 */
#include <klee/klee.h>
#include <stdio.h>
#include <string.h>


void testTaintPropagate(int i)
{
	klee_get_taint (&i, sizeof (i));
}


int main() {

  int key;
  klee_make_symbolic(&key, sizeof(key), "key");
  klee_set_taint(1, &key, sizeof(key));

  int clean = key;
  //int clean2;
  testTaintPropagate(clean);
  clean = ~key;

  //clean2 = clean + 2;
  testTaintPropagate(clean);
} 


