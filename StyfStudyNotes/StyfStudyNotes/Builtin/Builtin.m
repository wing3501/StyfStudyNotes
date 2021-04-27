//
//  Builtin.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/25.
//

#import "Builtin.h"

@interface Builtin ()

@end

@implementation Builtin

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    __builtin_choose_expr(true, printf("111"), printf("222"));
}

- (void)builtin_types_compatible_p {
    //    __builtin_types_compatible_p(type1, type2)
    //用来判断两个变量的类型是否一致，如果一致返回true否则返回false
    int a, b;
    long c;

    int ret1= __builtin_types_compatible_p(typeof(a), typeof(b));  //true
    int ret2 = __builtin_types_compatible_p(typeof(a), typeof(c)); //false
    int ret3 = __builtin_types_compatible_p(int , const int);  //true
    if  (__builtin_types_compatible_p(typeof(a), int))   //true
    {
        
    }
}

- (void)builtin_constant_p {
//    __builtin_constant_p(val)
//    这个函数用来判断某个表达式是否是一个常量，如果是常量返回true否则返回false。
    
   int a = 10;
   const int b = 10;
   int ret1  = __builtin_constant_p(10);  //true
   int ret2 = __builtin_constant_p(a);  //false
   int ret3 = __builtin_constant_p(b);  //true
}

- (void)builtin_offsetof {
//    __builtin_offsetof(struct, name)
//    这个函数用来获取一个结构体成员在结构中的偏移量。函数的第一个参数是结构体类型，第二个参数是其中的数据成员的名字。
    
    struct S
    {
        char m_a;
        long m_b;
    };

    int offset1 = __builtin_offsetof(struct S, m_a);  //0
    int offset2 = __builtin_offsetof(struct S, m_b);  //8

    struct S s;
    s.m_a = 'a';
    s.m_b = 10;
        
    char m_a = *(char*)((char*)&s + offset1);   //'a'
    long m_b = *(long*)((char*)&s + offset2);  // 10
}

- (void)builtin_return_address {
//    这个函数返回调用函数的返回地址，参数为调用返回的层级，从0开始，并且只能是一个常数。
    //这个例子演示一个函数foo。如果是被fout1函数调用则返回1，被其他函数调用时则返回0。

//    #include <dlfcn.h>
//    extern int foo();
//    void fout1()
//    {
//        printf("ret1 = %d\n", foo());    //ret1 = 1
//    }
//    void fout2()
//    {
//        printf("ret2 = %d\n", foo());    //ret2= 0
//    }
//    int foo()
//    {
//         void *retaddr = __builtin_return_address(0);  //这个返回地址就是调用者函数的某一处的地址。
//        //根据返回地址可以通过dladdr函数获取调用者函数的信息。
//        Dl_info dlinfo;
//        dladdr(retaddr, &dlinfo);
//        if (dlinfo.dli_saddr == fout1)
//            return 1;
//        else
//            return 0;
//    }
}

- (void)builtin_frame_address {
//    __builtin_frame_address(level)
//    这个函数返回调用函数执行时栈内存为其分配的栈帧(stack frame)区间中的高位地址值。参数为调用函数的层级，从0开始并且只能是一个常数。
}

- (void)builtin_choose_expr {
//    __builtin_choose_expr(exp, e1, e2)
//    这个函数主要用于实现在编译时进行分支判断和选择处理，从而可以实现在编译级别上的函数重载的能力。
//    判断表达式exp的值，如果值为真则使用e1代码块的内容，而如果值为假时则使用e2代码块的内容
//    void fooForInt(int a)
//    {
//        printf("int a = %d\n", a);
//    }
//
//    void fooForDouble(double a)
//    {
//        printf("double a=%f\n", a);
//    }
//
//    //如果x的数据类型是整型则使用fooForInt函数，否则使用fooForDouble函数。
//    #define fooFor(x) __builtin_choose_expr(__builtin_types_compatible_p(typeof(x), int), fooForInt(x), fooForDouble(x))
//
//    //根据传递进入的参数类型来决定使用哪个具体的函数。
//    fooFor(10);
//    fooFor(10.0);
}

- (void)builtin_expect {
//    __builtin_expect(bool exp, probability)
//    这个函数的主要作用是进行条件分支预测。 函数主要有两个参数: 第一个参数是一个布尔表达式、第二个参数表明第一个参数的值为真值的概率，这个参数只能取1或者0，当取值为1时表示布尔表达式大部分情况下的值是真值，而取值为0时则表示布尔表达式大部分情况下的值是假值。

//    为了简化函数的使用，iOS系统的两个宏fastpath和slowpath来实现这种分支优化判断处理。

//    #define fastpath(x) (__builtin_expect(bool(x), 1))
//    #define slowpath(x) (__builtin_expect(bool(x), 0))
    
//    if (__builtin_expect (x, 0))
//         foo ();
}

- (void)builtin_prefetch {
//    __builtin_prefetch(addr, rw, locality)
//    这个函数主要用来实现内存数据的预抓取处理
    
//    //定义一个数组，在接下来的时间中需要对数组进行频繁的写处理，因此可以将数组的内存地址预抓取到高速缓存中去。
//    int arr[10];
//    for (int i = 0; i < 10; i++)
//    {
//         __builtin_prefetch(arr+i, 1, 3);
//    }
//
//    //后面会频繁的对数组元素进行写入处理，因此如果不调用预抓取函数的话，每次写操作都是直接对内存地址进行写处理。
//    //而当使用了高速缓存后，这些写操作可能只是在高速缓存中执行。
//    for (int i = 0; i < 1000000; i++)
//    {
//         arr[i%10] = i;
//    }

}
@end
