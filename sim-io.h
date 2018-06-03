#ifndef _SIM-IO_H_INCLUDED_
#define _SIM-IO_H_INCLUDED_

int open(char *path,int flags);
int read(int file,char *ptr,int len);
int write(int file,char *ptr,int len);
int close(int file);

#endif
