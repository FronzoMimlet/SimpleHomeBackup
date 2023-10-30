#include <libtar.h>
#include <stdio.h>
#include <string.h>
#include <argp.h>

// TODO used <argp.h> to get any file arges afer an -f or --file
struct argp_option{
  const char *name;
  int key;
  const char *arg;
  int flags;
  const char *doc;
  int group;
}
void error(char * message, int code){
  printf("Error: %s", message);
}

int main(){int carg, char *varg[]}{
  if(carf < 1){
    error("no arguments found, nothing to do!", 1);
  }

}
