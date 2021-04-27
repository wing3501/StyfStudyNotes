//
//  MMAPNote.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/26.
//
//  Thunk程序的实现原理以及在iOS中的应用
//  https://juejin.cn/post/6844903773031104525
//  Thunk程序的实现原理以及在iOS中的应用(二)
//  https://juejin.cn/post/6844903773031284750

#import "MMAPNote.h"
#include <sys/mman.h>
#import <mach/mach.h>

@interface MMAPNote ()

@end

@implementation MMAPNote

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self remap1];
}

extern void *thunktemplate;   //声明使用thunk模板符号，注意不要带下划线

- (void)remap1 {
    vm_address_t thunkaddr = 0;
    vm_size_t page_size = 0;
    host_page_size(mach_host_self(), &page_size);
    //分配2页虚拟内存，
    kern_return_t ret = vm_allocate(mach_task_self(), &thunkaddr, page_size * 2, VM_FLAGS_ANYWHERE);
    if (ret == KERN_SUCCESS)
    {
        //第一页用来重映射到thunktemplate地址处。
        vm_prot_t cur,max;
        ret = vm_remap(mach_task_self(), &thunkaddr, page_size, 0, VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE, mach_task_self(), (vm_address_t)&thunktemplate, false, &cur, &max, VM_INHERIT_SHARE);
        if (ret == KERN_SUCCESS)
        {
            student_t students[5] = {{20,"Tom"},{15,"Jack"},{30,"Bob"},{10,"Lily"},{30,"Joe"}};
            int idxs[5] = {0,1,2,3,4};
            
            //第二页的对应位置填充数据。
            void **p = (void**)(thunkaddr + page_size);
            p[0] = students;
            p[1] = ageidxcomparfn;
            
            //将thunkaddr作为回调函数的地址。
            qsort(idxs, 5, sizeof(int), (int (*)(const void*, const void*))thunkaddr);
            for (int i = 0; i < 5; i++)
            {
                printf("student:[age:%d, name:%s]\n", students[idxs[i]].age, students[idxs[i]].name);
            }
        }
        
        vm_deallocate(mach_task_self(), thunkaddr, page_size * 2);
    }
    
}

//因为新分配的虚拟内存是以页为单位的，所以要被映射的内存也要页对齐，所以这里的函数起始地址是以页为单位对齐的。
int __attribute__ ((aligned (PAGE_MAX_SIZE))) testfn(int a, int b)
{
    int c = a + b;
    return c;
}

- (void)remap {
    //通过vm_alloc以页为单位分配出一块虚拟内存。
    vm_size_t page_size = 0;
    host_page_size(mach_host_self(), &page_size);  //获取一页虚拟内存的尺寸
    vm_address_t addr = 0;
    //在当前进程内的空闲区域中分配出一页虚拟内存出来,addr指向虚拟内存的开始位置。
    kern_return_t ret = vm_allocate(mach_task_self(), &addr, page_size, VM_FLAGS_ANYWHERE);
    if (ret == KERN_SUCCESS)
    {
        //addr被分配出来后，我们可以对这块内存进行读写操作
        memcpy((void*)addr, "Hello World!\n", 14);
        printf((const char*)addr);
        //执行上述代码后，这时候内存addr的内容除了最开始有“Hello World!\n“其他区域是一篇空白，而且并不是可执行的代码区域。
        
        //虚拟内存的remap重映射。执行完vm_remap函数后addr的内存将被重新映射到testfn函数所在的内存页中，这时候addr所指的内容将不在是Hello world!了，而是和函数testfn的代码保持一致。
        vm_prot_t cur,max;
        ret = vm_remap(mach_task_self(), &addr, page_size, 0, VM_FLAGS_FIXED | VM_FLAGS_OVERWRITE, mach_task_self(), (vm_address_t)testfn, false, &cur, &max, VM_INHERIT_SHARE);
        if (ret == KERN_SUCCESS)
        {
           int c1 = testfn(10, 20);    //执行testfn函数
           int c2 = ((int (*)(int,int))addr)(10,20); //addr重新映射后将和testfn函数具有相同内容，所以这里可以将addr当做是testfn函数一样被调用。
           NSAssert(c1 == c2, @"oops!");
        }

       vm_deallocate(mach_task_self(), addr, page_size);
    }
}


//因为结构体定义中存在对齐的问题，但是这里要求要单字节对齐，所以要加#pragma pack(push,1)这个编译指令。
#pragma  pack (push,1)
    typedef struct
    {
        unsigned int mov_x2_x1;
        unsigned int mov_x1_x0;
        unsigned int ldr_x0_0x0c;
        unsigned int ldr_x3_0x10;
        unsigned int br_x3;
        void *arg0;
        void *realfn;
    }thunkblock_t;
#pragma pack(pop)

typedef struct
{
    int age;
    char *name;
}student_t;

//按年龄升序排列的函数
int ageidxcomparfn(student_t students[], const int *idx1ptr, const int *idx2ptr)
{
    return students[*idx1ptr].age - students[*idx2ptr].age;
}


- (void)mmap2 {
    student_t students[5] = {{20,"Tom"},{15,"Jack"},{30,"Bob"},{10,"Lily"},{30,"Joe"}};
    int idxs[5] = {0,1,2,3,4};
       
   //第一步： 构造出机器指令
    thunkblock_t tb = {
        /* 汇编代码
         mov x2, x1
         mov x1, x0
         ldr x0, #0x0c
         ldr x3, #0x10
         br x3
         arg0:
         .quad 0
         realfn:
         .quad 0
         */
        //机器指令: E2 03 01 AA E1 03 00 AA 60 00 00 58 83 00 00 58 60 00 1F D6
        .mov_x2_x1 = 0xAA0103E2,
        .mov_x1_x0 = 0xAA0003E1,
        .ldr_x0_0x0c = 0x58000060,
        .ldr_x3_0x10 = 0x58000083,
        .br_x3 = 0xD61F0060,
        .arg0 = students,
        .realfn = ageidxcomparfn
     };

    //第二步：分配指令内存并设置可执行权限
     void  *thunkfn = mmap(0, 128, PROT_EXEC|PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
     memcpy(thunkfn, &tb, sizeof(thunkblock_t));
     mprotect(thunkfn, sizeof(thunkblock_t), PROT_EXEC);
 
   //第三步：为排序函数传递thunk代码块。
     qsort(idxs, 5, sizeof(int), (int (*)(const void*, const void*))thunkfn);
     for (int i = 0; i < 5; i++)
     {
        printf("student:[age:%d, name:%s]\n", students[idxs[i]].age, students[idxs[i]].name);
     }

     munmap(thunkfn, 128);
}

- (void)mmap1 {
    //分配一块长度为128字节的可读写和可执行的内存区域
    char  *bytes = (char *)mmap(0, 128, PROT_EXEC|PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
    memcpy(bytes, "Hello world!", 13);
    //修改内存的权限为只可读,不可写。
    mprotect(bytes, 128, PROT_READ);
    printf(bytes);
    memcpy(bytes, "Oops!", 6);  //oops! 内存不可写！
}

@end
