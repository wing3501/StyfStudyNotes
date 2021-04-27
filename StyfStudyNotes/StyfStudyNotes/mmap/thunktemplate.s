//
//  thunktemplate.s
//  StyfStudyNotes
//
//  Created by styf on 2021/4/26.
//

#if __arm64__

#include <mach/vm_param.h>

/*
  指令在代码段中，声明外部符号_thunktemplate，并且指令地址按页的大小对齐！
 */
.text
.private_extern _thunktemplate
.align PAGE_MAX_SHIFT
_thunktemplate:
mov x2, x1
mov x1, x0
ldr x0, PAGE_MAX_SIZE - 8
ldr x3, PAGE_MAX_SIZE - 4
br x3

#endif


