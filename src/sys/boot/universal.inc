; Linux x86_64 Syscalls Definitions for FASM/UASM
; Generated for BelowOS Project

SYS_READ                 equ 0
SYS_WRITE                equ 1
SYS_OPEN                 equ 2
SYS_CLOSE                equ 3
SYS_STAT                 equ 4
SYS_FSTAT                equ 5
SYS_LSTAT                equ 6
SYS_POLL                 equ 7
SYS_LSEEK                equ 8
SYS_MMAP                 equ 9
SYS_MPROTECT             equ 10
SYS_MUNMAP               equ 11
SYS_BRK                  equ 12
SYS_RT_SIGACTION         equ 13
SYS_RT_SIGPROCMASK       equ 14
SYS_RT_SIGRETURN         equ 15
SYS_IOCTL                equ 16
SYS_PREAD64              equ 17
SYS_PWRITE64             equ 18
SYS_READV                equ 19
SYS_WRITEV               equ 20
SYS_ACCESS               equ 21
SYS_PIPE                 equ 22
SYS_SELECT               equ 23
SYS_SCHED_YIELD          equ 24
SYS_MREMAP               equ 25
SYS_MSYNC                equ 26
SYS_MINCORE              equ 27
SYS_MADVISE              equ 28
SYS_SHMGET               equ 29
SYS_SHMAT                equ 30
SYS_SHMCTL               equ 31
SYS_DUP                  equ 32
SYS_DUP2                 equ 33
SYS_PAUSE                equ 34
SYS_NANOSLEEP            equ 35
SYS_GETITIMER            equ 36
SYS_ALARM                equ 37
SYS_SETITIMER            equ 38
SYS_GETPID               equ 39
SYS_SENDFILE             equ 40
SYS_SOCKET               equ 41
SYS_CONNECT              equ 42
SYS_ACCEPT               equ 43
SYS_SENDTO               equ 44
SYS_RECVFROM             equ 45
SYS_SENDMSG              equ 46
SYS_RECVMSG              equ 47
SYS_SHUTDOWN             equ 48
SYS_BIND                 equ 49
SYS_LISTEN               equ 50
SYS_GETSOCKNAME          equ 51
SYS_GETPEERNAME          equ 52
SYS_SOCKETPAIR           equ 53
SYS_SETSOCKOPT           equ 54
SYS_GETSOCKOPT           equ 55
SYS_CLONE                equ 56
SYS_FORK                 equ 57
SYS_VFORK                equ 58
SYS_EXECVE               equ 59
SYS_EXIT                 equ 60
SYS_WAIT4                equ 61
SYS_KILL                 equ 62
SYS_UNAME                equ 63
SYS_SEMGET               equ 64
SYS_SEMOP                equ 65
SYS_SEMCTL               equ 66
SYS_SHMDT                equ 67
SYS_MSGGET               equ 68
SYS_MSGSND               equ 69
SYS_MSGRCV               equ 70
SYS_MSGCTL               equ 71
SYS_FCNTL                equ 72
SYS_FLOCK                equ 73
SYS_FSYNC                equ 74
SYS_FDATASYNC            equ 75
SYS_TRUNCATE             equ 76
SYS_FTRUNCATE            equ 77
SYS_GETDENTS             equ 78
SYS_GETCWD               equ 79
SYS_CHDIR                equ 80
SYS_FCHDIR               equ 81
SYS_RENAME               equ 82
SYS_MKDIR                equ 83
SYS_RMDIR                equ 84
SYS_CREAT                equ 85
SYS_LINK                 equ 86
SYS_UNLINK               equ 87
SYS_SYMLINK              equ 88
SYS_READLINK             equ 89
SYS_CHMOD                equ 90
SYS_FCHMOD               equ 91
SYS_CHOWN                equ 92
SYS_FCHOWN               equ 93
SYS_LCHOWN               equ 94
SYS_UMASK                equ 95
SYS_GETTIMEOFDAY         equ 96
SYS_GETRLIMIT            equ 97
SYS_GETRUSAGE            equ 98
SYS_SYSINFO              equ 99
SYS_TIMES                equ 100
SYS_PTRACE               equ 101
SYS_GETUID               equ 102
SYS_SYSLOG               equ 103
SYS_GETGID               equ 104
SYS_SETUID               equ 105
SYS_SETGID               equ 106
SYS_GETEUID              equ 107
SYS_GETEGID              equ 108
SYS_SETPGID              equ 109
SYS_GETPPID              equ 110
SYS_GETPGRP              equ 111
SYS_SETSID               equ 112
SYS_SETREUID             equ 113
SYS_SETREGID             equ 114
SYS_GETGROUPS            equ 115
SYS_SETGROUPS            equ 116
SYS_SETRESUID            equ 117
SYS_GETRESUID            equ 118
SYS_SETRESGID            equ 119
SYS_GETRESGID            equ 120
SYS_GETPGID              equ 121
SYS_SETFSUID             equ 122
SYS_SETFSGID             equ 123
SYS_GETSID               equ 124
SYS_CAPGET               equ 125
SYS_CAPSET               equ 126
SYS_RT_SIGPENDING        equ 127
SYS_RT_SIGTIMEDWAIT      equ 128
SYS_RT_SIGQUEUEINFO      equ 129
SYS_RT_SIGSUSPEND        equ 130
SYS_SIGALTSTACK          equ 131
SYS_UTIME                equ 132
SYS_MKNOD                equ 133
SYS_USELIB               equ 134
SYS_PERSONALITY          equ 135
SYS_USTAT                equ 136
SYS_STATFS               equ 137
SYS_FSTATFS              equ 138
SYS_SYSFS                equ 139
SYS_GETPRIORITY          equ 140
SYS_SETPRIORITY          equ 141
SYS_SCHED_SETPARAM       equ 142
SYS_SCHED_GETPARAM       equ 143
SYS_SCHED_SETSCHEDULER   equ 144
SYS_SCHED_GETSCHEDULER   equ 145
SYS_SCHED_GET_PRIORITY_MAX equ 146
SYS_SCHED_GET_PRIORITY_MIN equ 147
SYS_SCHED_RR_GET_INTERVAL equ 148
SYS_MLOCK                equ 149
SYS_MUNLOCK              equ 150
SYS_MLOCKALL             equ 151
SYS_MUNLOCKALL           equ 152
SYS_VHANGUP              equ 153
SYS_MODIFY_LDT           equ 154
SYS_PIVOT_ROOT           equ 155
SYS__SYSCTL              equ 156
SYS_PRCTL                equ 157
SYS_ARCH_PRCTL           equ 158
SYS_ADJTIMEX             equ 159
SYS_SETRLIMIT            equ 160
SYS_CHROOT               equ 161
SYS_SYNC                 equ 162
SYS_ACCT                 equ 163
SYS_SETTIMEOFDAY         equ 164
SYS_MOUNT                equ 165
SYS_UMOUNT2              equ 166
SYS_SWAPON               equ 167
SYS_SWAPOFF              equ 168
SYS_REBOOT               equ 169
SYS_SETHOSTNAME          equ 170
SYS_SETDOMAINNAME        equ 171
SYS_IOPL                 equ 172
SYS_IOPERM               equ 173
SYS_CREATE_MODULE        equ 174
SYS_INIT_MODULE          equ 175
SYS_DELETE_MODULE        equ 176
SYS_GET_KERNEL_SYMS      equ 177
SYS_QUERY_MODULE         equ 178
SYS_QUOTACTL             equ 179
SYS_NFSSERVCTL           equ 180
SYS_GETPMSG              equ 181
SYS_PUTPMSG              equ 182
SYS_AFS_SYSCALL          equ 183
SYS_TUXCALL              equ 184
SYS_SECURITY             equ 185
SYS_GETTID               equ 186
SYS_READAHEAD            equ 187
SYS_SETXATTR             equ 188
SYS_LSETXATTR            equ 189
SYS_FSETXATTR            equ 190
SYS_GETXATTR             equ 191
SYS_LGETXATTR            equ 192
SYS_FGETXATTR            equ 193
SYS_LISTXATTR            equ 194
SYS_LLISTXATTR           equ 195
SYS_FLISTXATTR           equ 196
SYS_REMOVEXATTR          equ 197
SYS_LREMOVEXATTR         equ 198
SYS_FREMOVEXATTR         equ 199
SYS_TKILL                equ 200
SYS_TIME                 equ 201
SYS_FUTEX                equ 202
SYS_SCHED_SETAFFINITY    equ 203
SYS_SCHED_GETAFFINITY    equ 204
SYS_SET_THREAD_AREA      equ 205
SYS_IO_SETUP             equ 206
SYS_IO_DESTROY           equ 207
SYS_IO_GETEVENTS         equ 208
SYS_IO_SUBMIT            equ 209
SYS_IO_CANCEL            equ 210
SYS_GET_THREAD_AREA      equ 211
SYS_LOOKUP_DCOOKIE       equ 212
SYS_EPOLL_CREATE         equ 213
SYS_EPOLL_CTL_OLD        equ 214
SYS_EPOLL_WAIT_OLD       equ 215
SYS_REMAP_FILE_PAGES     equ 216
SYS_GETDENTS64           equ 217
SYS_SET_TID_ADDRESS      equ 218
SYS_RESTART_SYSCALL      equ 219
SYS_SEMTIMEDOP           equ 220
SYS_FADVISE64            equ 221
SYS_TIMER_CREATE         equ 222
SYS_TIMER_SETTIME        equ 223
SYS_TIMER_GETTIME        equ 224
SYS_TIMER_GETOVERRUN     equ 225
SYS_TIMER_DELETE         equ 226
SYS_CLOCK_SETTIME        equ 227
SYS_CLOCK_GETTIME        equ 228
SYS_CLOCK_GETRES         equ 229
SYS_CLOCK_NANOSLEEP      equ 230
SYS_EXIT_GROUP           equ 231
SYS_EPOLL_WAIT           equ 232
SYS_EPOLL_CTL            equ 233
SYS_TGKILL               equ 234
SYS_UTIMES               equ 235
SYS_VSERVER              equ 236
SYS_MBIND                equ 237
SYS_SET_MEMPOLICY        equ 238
SYS_GET_MEMPOLICY        equ 239
SYS_MQ_OPEN              equ 240
SYS_MQ_UNLINK            equ 241
SYS_MQ_TIMEDSEND         equ 242
SYS_MQ_TIMEDRECEIVE      equ 243
SYS_MQ_NOTIFY            equ 244
SYS_MQ_GETSETATTR        equ 245
SYS_KEXEC_LOAD           equ 246
SYS_WAITID               equ 247
SYS_ADD_KEY              equ 248
SYS_REQUEST_KEY          equ 249
SYS_KEYCTL               equ 250
SYS_IOPRIO_SET           equ 251
SYS_IOPRIO_GET           equ 252
SYS_INOTIFY_INIT         equ 253
SYS_INOTIFY_ADD_WATCH    equ 254
SYS_INOTIFY_RM_WATCH     equ 255
SYS_MIGRATE_PAGES        equ 256
SYS_OPENAT               equ 257
SYS_MKDIRAT              equ 258
SYS_MKNODAT              equ 259
SYS_FCHOWNAT             equ 260
SYS_FUTIMESAT            equ 261
SYS_NEWFSTATAT           equ 262
SYS_UNLINKAT             equ 263
SYS_RENAMEAT             equ 264
SYS_LINKAT               equ 265
SYS_SYMLINKAT            equ 266
SYS_READLINKAT           equ 267
SYS_FCHMODAT             equ 268
SYS_FACCESSAT            equ 269
SYS_PSELECT6             equ 270
SYS_PPOLL                equ 271
SYS_UNSHARE              equ 272
SYS_SET_ROBUST_LIST      equ 273
SYS_GET_ROBUST_LIST      equ 274
SYS_SPLICE               equ 275
SYS_TEE                  equ 276
SYS_SYNC_FILE_RANGE      equ 277
SYS_VMSPLICE             equ 278
SYS_MOVE_PAGES           equ 279
SYS_UTIMENSAT            equ 280
SYS_EPOLL_PWAIT          equ 281
SYS_SIGNALFD             equ 282
SYS_TIMERFD_CREATE       equ 283
SYS_EVENTFD              equ 284
SYS_FALLOCATE            equ 285
SYS_TIMERFD_SETTIME      equ 286
SYS_TIMERFD_GETTIME      equ 287
SYS_ACCEPT4              equ 288
SYS_SIGNALFD4            equ 289
SYS_EVENTFD2             equ 290
SYS_EPOLL_CREATE1        equ 291
SYS_DUP3                 equ 292
SYS_PIPE2                equ 293
SYS_INOTIFY_INIT1        equ 294
SYS_PREADV               equ 295
SYS_PWRITEV              equ 296
SYS_RT_TGSIGQUEUEINFO    equ 297
SYS_PERF_EVENT_OPEN      equ 298
SYS_RECVMMSG             equ 299
SYS_FANOTIFY_INIT        equ 300
SYS_FANOTIFY_MARK        equ 301
SYS_PRLIMIT64            equ 302
SYS_NAME_TO_HANDLE_AT    equ 303
SYS_OPEN_BY_HANDLE_AT    equ 304
SYS_CLOCK_ADJTIME        equ 305
SYS_SYNCFS               equ 306
SYS_SENDMMSG             equ 307
SYS_SETNS                equ 308
SYS_GETCPU               equ 309
SYS_PROCESS_VM_READV     equ 310
SYS_PROCESS_VM_WRITEV    equ 311
SYS_KCMP                 equ 312
SYS_FINIT_MODULE         equ 313
SYS_SCHED_SETATTR        equ 314
SYS_SCHED_GETATTR        equ 315
SYS_RENAMEAT2            equ 316
SYS_SECCOMP              equ 317
SYS_GETRANDOM            equ 318
SYS_MEMFD_CREATE         equ 319
SYS_KEXEC_FILE_LOAD      equ 320
SYS_BPF                  equ 321
SYS_EXECVEAT             equ 322
SYS_USERFAULTFD          equ 323
SYS_MEMBARRIER           equ 324
SYS_MLOCK2               equ 325
SYS_COPY_FILE_RANGE      equ 326
SYS_PREADV2              equ 327
SYS_PWRITEV2             equ 328
SYS_PKEY_MPROTECT        equ 329
SYS_PKEY_ALLOC           equ 330
SYS_PKEY_FREE            equ 331
SYS_STATX                equ 332


; Macroinstructions for HLL-style conditional operations

macro .if [arg]
{
  common
  __IF equ
  local ..endif
  __ENDIF equ ..endif
  local ..else
  __ELSE equ ..else
  JNCOND __ELSE,arg
}

macro .else
{
  jmp __ENDIF
  __ELSE:
  restore __IF
  __IF equ ,
}

macro .elseif [arg]
{
  common
  jmp __ENDIF
  __ELSE:
  restore __ELSE
  local ..else
  __ELSE equ ..else
  JNCOND __ELSE,arg
}

macro .endif
{
  if __IF eq
   __ELSE:
  end if
  __ENDIF:
  restore __ELSE
  restore __ENDIF
  restore __IF
}

macro .while [arg]
{
  common
  local ..while
  __WHILE equ ..while
  local ..endw
  __ENDW equ ..endw
  __WHILE:
  JNCOND __ENDW,arg
}

macro .endw
{
  jmp __WHILE
  __ENDW:
  restore __ENDW
  restore __WHILE
}

macro .repeat
{
  local ..repeat
  __REPEAT equ ..repeat
  __REPEAT:
}

macro .until [arg]
{
  common
  JNCOND __REPEAT,arg
  restore __REPEAT
}

jnne equ je
jnna equ ja
jnnb equ jb
jnng equ jg
jnnl equ jl
jnnae equ jae
jnnbe equ jbe
jnnge equ jge
jnnle equ jle

macro JNCOND label,v1,c,v2
{
 match any,c
 \{
   cmp v1,v2
   jn\#c label
 \}
 match ,c
 \{
   PARSECOND parsed@cond,v1
   match cond,parsed@cond \\{ JNCONDEXPR label,cond \\}
 \}
}

gt equ >
lt equ <

macro PARSECOND parsed,cond
{
 define parsed
 define neg@cond
 define status@cond
 define nest@cond
 irps symb,cond
 \{
   define symb@cond symb
   match >,symb
   \\{
      define symb@cond gt
   \\}
   match <,symb
   \\{
      define symb@cond lt
   \\}
   current@cond equ status@cond
   match ,current@cond
   \\{
      match ~,symb
      \\\{
	  neg@cond equ neg@cond ~
	  match ~~,neg@cond
	  \\\\{
	       define neg@cond
	  \\\\}
	  define symb@cond
      \\\}
      match (,symb
      \\\{
	  parsed equ parsed neg@cond,<
	  define nest@cond +
	  define symb@cond
	  define neg@cond
      \\\}
      match any,symb@cond
      \\\{
	  parsed equ parsed neg@cond,symb@cond
	  define status@cond +
      \\\}
   \\}
   match status,current@cond
   \\{
      match &,symb
      \\\{
	  parsed equ parsed,&,
	  define status@cond
	  define symb@cond
	  define neg@cond
      \\\}
      match |,symb
      \\\{
	  parsed equ parsed,|,
	  define status@cond
	  define symb@cond
	  define neg@cond
      \\\}
      match (,symb
      \\\{
	  define nest@cond (
      \\\}
      match ),symb
      \\\{
	  match +,nest@cond
	  \\\\{
	       parsed equ parsed>
	       define symb@cond
	  \\\\}
	  restore nest@cond
      \\\}
      match any,symb@cond
      \\\{
	  parsed equ parsed symb@cond
      \\\}
   \\}
 \}
}

macro define_JNCONDEXPR
{
 macro JNCONDEXPR elabel,[mod,cond,op]
 \{
  \common
   \local ..t,..f
   define t@cond ..t
   define f@cond ..f
  \forward
   match ,op
   \\{
      match ,mod \\\{ JNCONDEL elabel,<cond> \\\}
      match ~,mod \\\{ JCONDEL elabel,<cond> \\\}
   \\}
   match &:flabel:tlabel, op:f@cond:t@cond
   \\{
      match ,mod \\\{ JNCONDEL flabel,<cond> \\\}
      match ~,mod \\\{ JCONDEL flabel,<cond> \\\}
      tlabel:
      \\local ..tnew
      restore t@cond
      define t@cond ..tnew
   \\}
   match |:flabel:tlabel, op:f@cond:t@cond
   \\{
      match ,mod \\\{ JCONDEL tlabel,<cond> \\\}
      match ~,mod \\\{ JNCONDEL tlabel,<cond> \\\}
      flabel:
      \\local ..fnew
      restore f@cond
      define f@cond ..fnew
   \\}
  \common
   label f@cond at elabel
   t@cond:
   restore t@cond
   restore f@cond
 \}
}

macro define_JCONDEXPR
{
 macro JCONDEXPR elabel,[mod,cond,op]
 \{
  \common
   \local ..t,..f
   define t@cond ..t
   define f@cond ..f
  \forward
   match ,op
   \\{
      match ,mod \\\{ JCONDEL elabel,<cond> \\\}
      match ~,mod \\\{ JNCONDEL elabel,<cond> \\\}
   \\}
   match |:flabel:tlabel, op:f@cond:t@cond
   \\{
      match ,mod \\\{ JCONDEL flabel,<cond> \\\}
      match ~,mod \\\{ JNCONDEL flabel,<cond> \\\}
      tlabel:
      \\local ..tnew
      restore t@cond
      define t@cond ..tnew
   \\}
   match &:flabel:tlabel, op:f@cond:t@cond
   \\{
      match ,mod \\\{ JNCONDEL tlabel,<cond> \\\}
      match ~,mod \\\{ JCONDEL tlabel,<cond> \\\}
      flabel:
      \\local ..fnew
      restore f@cond
      define f@cond ..fnew
   \\}
  \common
   label f@cond at elabel
   t@cond:
   restore t@cond
   restore f@cond
 \}
}

macro define_JNCONDEL
{
 macro JNCONDEL label,cond
 \{
   \local COND
   match car=,cdr,:cond
   \\{
      define_JNCONDEXPR
      define_JCONDEXPR
      define_JCONDEL
      define_JNCONDEL
      JNCONDEXPR label,cond
      purge JNCONDEXPR,JCONDEXPR,JCONDEL,JNCONDEL
      define COND
   \\}
   match c,cond ; replace gt and lt
   \\{
      match =COND =signed v1>==v2, COND c
      \\\{
	  cmp v1,v2
	  jl label
	  define COND
      \\\}
      match =COND =signed v1<==v2, COND c
      \\\{
	  cmp v1,v2
	  jg label
	  define COND
      \\\}
      match =COND v1>==v2, COND c
      \\\{
	  cmp v1,v2
	  jb label
	  define COND
      \\\}
      match =COND v1<==v2, COND c
      \\\{
	  cmp v1,v2
	  ja label
	  define COND
      \\\}
      match =COND v1==v2, COND c
      \\\{
	  cmp v1,v2
	  jne label
	  define COND
      \\\}
      match =COND v1<>v2, COND c
      \\\{
	  cmp v1,v2
	  je label
	  define COND
      \\\}
      match =COND =signed v1>v2, COND c
      \\\{
	  cmp v1,v2
	  jle label
	  define COND
      \\\}
      match =COND =signed v1<v2, COND c
      \\\{
	  cmp v1,v2
	  jge label
	  define COND
      \\\}
      match =COND v1>v2, COND c
      \\\{
	  cmp v1,v2
	  jbe label
	  define COND
      \\\}
      match =COND v1<v2, COND c
      \\\{
	  cmp v1,v2
	  jae label
	  define COND
      \\\}
      match =COND =ZERO?, COND c
      \\\{
	  jnz label
	  define COND
      \\\}
      match =COND =CARRY?, COND c
      \\\{
	  jnc label
	  define COND
      \\\}
      match =COND =OVERFLOW?, COND c
      \\\{
	  jno label
	  define COND
      \\\}
      match =COND =SIGN?, COND c
      \\\{
	  jns label
	  define COND
      \\\}
      match =COND =PARITY?, COND c
      \\\{
	  jnp label
	  define COND
      \\\}
      match =COND v, COND c
      \\\{
	  if v eqtype 0
	   if ~ v
	    jmp label
	   end if
	  else if v eqtype eax
	   test v,v
	   jz label
	  else
	   cmp v,0
	   je label
	  end if
      \\\}
   \\}
 \}
}

macro define_JCONDEL
{
 macro JCONDEL label,cond
 \{
   \local COND
   match car=,cdr,:cond
   \\{
      define_JNCONDEXPR
      define_JCONDEXPR
      define_JCONDEL
      define_JNCONDEL
      JCONDEXPR label,cond
      purge JNCONDEXPR,JCONDEXPR,JCONDEL,JNCONDEL
      define COND
   \\}
   match c,cond ; replace gt and lt
   \\{
      match =COND =signed v1>==v2, COND c
      \\\{
	  cmp v1,v2
	  jge label
	  define COND
      \\\}
      match =COND =signed v1<==v2, COND c
      \\\{
	  cmp v1,v2
	  jle label
	  define COND
      \\\}
      match =COND v1>==v2, COND c
      \\\{
	  cmp v1,v2
	  jae label
	  define COND
      \\\}
      match =COND v1<==v2, COND c
      \\\{
	  cmp v1,v2
	  jbe label
	  define COND
      \\\}
      match =COND v1==v2, COND c
      \\\{
	  cmp v1,v2
	  je label
	  define COND
      \\\}
      match =COND v1<>v2, COND c
      \\\{
	  cmp v1,v2
	  jne label
	  define COND
      \\\}
      match =COND =signed v1>v2, COND c
      \\\{
	  cmp v1,v2
	  jg label
	  define COND
      \\\}
      match =COND =signed v1<v2, COND c
      \\\{
	  cmp v1,v2
	  jl label
	  define COND
      \\\}
      match =COND v1>v2, COND c
      \\\{
	  cmp v1,v2
	  ja label
	  define COND
      \\\}
      match =COND v1<v2, COND c
      \\\{
	  cmp v1,v2
	  jb label
	  define COND
      \\\}
      match =COND =ZERO?, COND c
      \\\{
	  jz label
	  define COND
      \\\}
      match =COND =CARRY?, COND c
      \\\{
	  jc label
	  define COND
      \\\}
      match =COND =OVERFLOW?, COND c
      \\\{
	  jo label
	  define COND
      \\\}
      match =COND =SIGN?, COND c
      \\\{
	  js label
	  define COND
      \\\}
      match =COND =PARITY?, COND c
      \\\{
	  jp label
	  define COND
      \\\}
      match =COND v, COND c
      \\\{
	  if v eqtype 0
	   if v
	    jmp label
	   end if
	  else if v eqtype eax
	   test v,v
	   jnz label
	  else
	   cmp v,0
	   jne label
	  end if
      \\\}
   \\}
 \}
}

define_JNCONDEXPR
define_JCONDEXPR
define_JNCONDEL
define_JCONDEL


; Macroinstructions for defining data structures

macro struct name
 { virtual at 0
   define @struct
   field@struct equ name
   match child parent, name \{ restore field@struct
			       field@struct equ child,fields@\#parent \}
   sub@struct equ
   struc db [val] \{ \common define field@struct .,db,<val> \}
   struc dw [val] \{ \common define field@struct .,dw,<val> \}
   struc du [val] \{ \common define field@struct .,du,<val> \}
   struc dd [val] \{ \common define field@struct .,dd,<val> \}
   struc dp [val] \{ \common define field@struct .,dp,<val> \}
   struc dq [val] \{ \common define field@struct .,dq,<val> \}
   struc dt [val] \{ \common define field@struct .,dt,<val> \}
   struc rb count \{ define field@struct .,db,count dup (?) \}
   struc rw count \{ define field@struct .,dw,count dup (?) \}
   struc rd count \{ define field@struct .,dd,count dup (?) \}
   struc rp count \{ define field@struct .,dp,count dup (?) \}
   struc rq count \{ define field@struct .,dq,count dup (?) \}
   struc rt count \{ define field@struct .,dt,count dup (?) \}
   macro db [val] \{ \common \local anonymous
		     define field@struct anonymous,db,<val> \}
   macro dw [val] \{ \common \local anonymous
		     define field@struct anonymous,dw,<val> \}
   macro du [val] \{ \common \local anonymous
		     define field@struct anonymous,du,<val> \}
   macro dd [val] \{ \common \local anonymous
		     define field@struct anonymous,dd,<val> \}
   macro dp [val] \{ \common \local anonymous
		     define field@struct anonymous,dp,<val> \}
   macro dq [val] \{ \common \local anonymous
		     define field@struct anonymous,dq,<val> \}
   macro dt [val] \{ \common \local anonymous
		     define field@struct anonymous,dt,<val> \}
   macro rb count \{ \local anonymous
		     define field@struct anonymous,db,count dup (?) \}
   macro rw count \{ \local anonymous
		     define field@struct anonymous,dw,count dup (?) \}
   macro rd count \{ \local anonymous
		     define field@struct anonymous,dd,count dup (?) \}
   macro rp count \{ \local anonymous
		     define field@struct anonymous,dp,count dup (?) \}
   macro rq count \{ \local anonymous
		     define field@struct anonymous,dq,count dup (?) \}
   macro rt count \{ \local anonymous
		     define field@struct anonymous,dt,count dup (?) \}
   macro union \{ field@struct equ ,union,<
		  sub@struct equ union \}
   macro struct \{ field@struct equ ,substruct,<
		  sub@struct equ substruct \} }

macro ends
 { match , sub@struct \{ restruc db,dw,du,dd,dp,dq,dt
			 restruc rb,rw,rd,rp,rq,rt
			 purge db,dw,du,dd,dp,dq,dt
			 purge rb,rw,rd,rp,rq,rt
			 purge union,struct
			 irpv fields,field@struct \\{ restore field@struct
						      \\common define fields@struct fields \\}
			 match name tail,fields@struct, \\{ if $
							    display 'Error: definition of ',\\`name,' contains illegal instructions.',0Dh,0Ah
							    err
							    end if \\}
			 match name=,fields,fields@struct \\{ restore @struct
							      make@struct name,fields
							      define fields@\\#name fields \\}
			 end virtual \}
   match any, sub@struct \{ tmp@struct equ field@struct
			    restore field@struct
			    field@struct equ tmp@struct> \}
   restore sub@struct }

macro make@struct name,[field,type,def]
 { common
    local define
    define equ name
   forward
    local sub
    match , field \{ make@substruct type,name,sub def
		     define equ define,.,sub, \}
    match any, field \{ define equ define,.#field,type,<def> \}
   common
    match fields, define \{ define@struct fields \} }

macro define@struct name,[field,type,def]
 { common
    virtual
    db `name
    load initial@struct byte from 0
    if initial@struct = '.'
    display 'Error: name of structure should not begin with a dot.',0Dh,0Ah
    err
    end if
    end virtual
    local list
    list equ
   forward
    if ~ field eq .
     name#field type def
     sizeof.#name#field = $ - name#field
    else
     label name#.#type
     rb sizeof.#type
    end if
    local value
    match any, list \{ list equ list, \}
    list equ list <value>
   common
    sizeof.#name = $
    restruc name
    match values, list \{
    struc name value \\{ \\local \\..base
    match , @struct \\\{ define field@struct .,name,<values> \\\}
    match no, @struct \\\{ label \\..base
   forward
     match , value \\\\{ field type def \\\\}
     match any, value \\\\{ field type value
			    if ~ field eq .
			     rb sizeof.#name#field - ($-field)
			    end if \\\\}
   common label . at \\..base \\\}
   \\}
    macro name value \\{
    match , @struct \\\{ \\\local anonymous
				  define field@struct anonymous,name,<values> \\\}
    match no, @struct \\\{
   forward
     match , value \\\\{ type def \\\\}
     match any, value \\\\{ \\\\local ..field
			   ..field = $
			   type value
			   if ~ field eq .
			    rb sizeof.#name#field - ($-..field)
			   end if \\\\}
   common \\\} \\} \} }

macro enable@substruct
 { macro make@substruct substruct,parent,name,[field,type,def]
    \{ \common
	\local define
	define equ parent,name
       \forward
	\local sub
	match , field \\{ match any, type \\\{ enable@substruct
					       make@substruct type,parent,sub def
					       purge make@substruct
					       define equ define,.,sub, \\\} \\}
	match any, field \\{ define equ define,.\#field,type,<def> \\}
       \common
	match fields, define \\{ define@\#substruct fields \\} \} }

enable@substruct

macro define@union parent,name,[field,type,def]
 { common
    virtual at parent#.#name
   forward
    if ~ field eq .
     virtual at parent#.#name
      parent#field type def
      sizeof.#parent#field = $ - parent#field
     end virtual
     if sizeof.#parent#field > $ - parent#.#name
      rb sizeof.#parent#field - ($ - parent#.#name)
     end if
    else
     virtual at parent#.#name
      label parent#.#type
      type def
     end virtual
     label name#.#type at parent#.#name
     if sizeof.#type > $ - parent#.#name
      rb sizeof.#type - ($ - parent#.#name)
     end if
    end if
   common
    sizeof.#name = $ - parent#.#name
    end virtual
    struc name [value] \{ \common
    label .\#name
    last@union equ
   forward
    match any, last@union \\{ virtual at .\#name
			       field type def
			      end virtual \\}
    match , last@union \\{ match , value \\\{ field type def \\\}
			   match any, value \\\{ field type value \\\} \\}
    last@union equ field
   common rb sizeof.#name - ($ - .\#name) \}
    macro name [value] \{ \common \local ..anonymous
			  ..anonymous name value \} }

macro define@substruct parent,name,[field,type,def]
 { common
    virtual at parent#.#name
   forward
    local value
    if ~ field eq .
     parent#field type def
     sizeof.#parent#field = $ - parent#field
    else
     label parent#.#type
     rb sizeof.#type
    end if
   common
    sizeof.#name = $ - parent#.#name
    end virtual
    struc name value \{
    label .\#name
   forward
     match , value \\{ field type def \\}
     match any, value \\{ field type value
			  if ~ field eq .
			   rb sizeof.#parent#field - ($-field)
			  end if \\}
   common \}
    macro name value \{ \local ..anonymous
			..anonymous name \} }


uint8_t  equ db
uint16_t equ dw
uint32_t equ dd
uint64_t equ dq

size_t   equ dq

macro align_to boundary {
    db (boundary - 1) - (($ + boundary - 1) mod boundary) dup 0
}

;align_to 4096 

macro preserve {
    push rax rbx rcx rdx rsi rdi r8 r9 r10 r11
}

macro restore {
    pop r11 r10 r9 r8 rdi rsi rdx rcx rbx rax
}

macro halt {
	cli
	hlt
}

macro pcpu, dur {
	repeat dur
		rep nop 
	end repeat
}

macro wait_irq {
	sti
	hlt
}

macro read_tsc {
	rdtsc
	shl rdx, 32
	or rax, rdx
}

ENABLE = 1
DISABLE = 0

macro ULcpu, p* {
	if p = 1 
		cli
	else
		sti
		nop
	endif
}

macro writectrl {
	out 0x20, al
}

macro vprint char, color, pos {
	mov word [0xB8000 + pos], (color shl 0) or char 
}

;vprint '!', 0x0F, 0

macro proc_start {
    push rbp
    mov rbp, rsp
}

macro proc_end {
    mov rsp, rbp
    pop rbp
    ret
}

macro isr_wrapper label, handler {
    label:
        push_all      
        call handler
        pop_all       
        iretq         
}

macro pushm [arg] {
	common 
	forward 
		push arg
}

;pushm ra, rbx, rcx, rdx, rsi, rdi...

macro popm [arg] {
	common 
	reverse
		pop arg
}

;popm ra, rbx, rcx, rdx, rsi, rdi...

macro dstr name, [content] {
    common
        name db content, 0
}

struct MemoryBlock
    size    dq ?    
    is_free db ?    
    next    dq ?    
ends

macro mallc size_reg {
    
    mov rbx, [heap_bottom] 
    
    .search:
        cmp [rbx + MemoryBlock.is_free], 1
        jne .next
        cmp [rbx + MemoryBlock.size], rcx
        jae .found
        
    .next:
        mov rbx, [rbx + MemoryBlock.next]
        test rbx, rbx
        jz .no_memory 
        jmp .search
        
    .found:
        mov [rbx + MemoryBlock.is_free], 0
        lea rax, [rbx + sizeof.MemoryBlock] 
}

macro kmalloc size* {
    mov rcx, size
    add rcx, 15
    and rcx, -16
    call malloc
}

macro kfree ptr* {
    if ~ ptr eq rax
        mov rax, ptr
    end if
    call free
}

macro kcalloc count*, size* {
    mov rcx, count
    mov rdx, size
    call calloc
}

macro krealloc ptr*, new_size* {
    mov rax, ptr
    mov rcx, new_size
    call realloc
}


macro .for var*, cond*, limit*, op*, step* {
    local .loop, .end

    define __f_var var
    define __f_op  op
    define __f_val step
    define __f_lbl .loop

    .loop:
        cmp var, limit
        
        if cond eq '<'
            jnl .end
        else if cond eq '>'
            jng .end
        else if cond eq '<='
            jnle .end
        else if cond eq '>='
            jnge .end
        else if cond eq '=='
            jne .end
        else if cond eq '!='
            je .end
        end if
}

macro .endf {
    if __f_op eq '+'
        if __f_val eq 1
            inc __f_var
        else
            add __f_var, __f_val
        end if
    else if __f_op eq '-'
        if __f_val eq 1
            dec __f_var
        else
            sub __f_var, __f_val
        end if
    end if
    jmp __f_lbl
    .end:
    restore __f_var, __f_op, __f_val, __f_lbl
}

;.for eax, <, 10, +, 1

macro unisys nr, p1, p2, p3, p4, p5, p6 {
    mov rax, nr
    if ~ p1 eq
        if p1 eqtype rdi | ~ p1 eq rdi
            mov rdi, p1
        end if
    end if
    if ~ p2 eq
        if p2 eqtype rsi | ~ p2 eq rsi
            mov rsi, p2
        end if
    end if
    if ~ p3 eq
        if p3 eqtype rdx | ~ p3 eq rdx
            mov rdx, p3
        end if
    end if
    if ~ p4 eq
        mov r10, p4
    end if
    if ~ p5 eq
        mov r8, p5
    end if
    if ~ p6 eq
        mov r9, p6
    end if
    syscall
}
