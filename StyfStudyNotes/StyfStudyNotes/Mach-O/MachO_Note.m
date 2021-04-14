//
//  MachO_Note.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/14.
// 深入iOS系统底层之程序映像
// https://www.jianshu.com/p/3b83193ff851

#import "MachO_Note.h"
#import <mach-o/dyld.h>
#import <mach-o/getsect.h>
#include <dlfcn.h>

@interface MachO_Note ()

@end

@implementation MachO_Note

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    //进程映像(Image)操作API
    [self ImageAPI];
    NSLog(@"-------------------------------------------------");
    //段(Segment)和节(Section)操作API
    [self SegmentSectionAPI];
    NSLog(@"-------------------------------------------------");
    [self AddrAPI];
}

//地址和符号查询API    <dlfcn.h>
- (void)AddrAPI {
//    1.获取地址归属的库以及最近的符号信息。
//    int dladdr(const void *, Dl_info *);
//    typedef struct dl_info {
//            const char      *dli_fname;     /* 地址归属的映像库文件名称 */
//            void            *dli_fbase;     /* 地址归属的库在内存中的基地址 */
//            const char      *dli_sname;     /* 离地址最近的符号名称 */
//            void            *dli_saddr;     /* 离地址最近的符号名称的开始地址 */
//    } Dl_info;
//    这里值得关注的就是dli_fbase是指的库在内存中的映像的首地址
    
//    #import <dlfcn.h>
//    #import <objc/message.h>
//    #import <mach-o/loader.h>
//
//    Dl_info info;
//    memset(&info, 0, sizeof(info));
//    if (dladdr(objc_msgSend, &info) != 0)
//    {
//        printf("dli_fname=%s\ndli_fbase=%p\ndli_sname=%s\ndl_saddr=%p\n", info.dli_fname, info.dli_fbase, info.dli_sname, info.dli_saddr);
//
//        struct mach_header_64 *pheader = (struct mach_header_64*)info.dli_fbase;
//            //...
//    }
}

//段(Segment)和节(Section)操作API   对段和节进行操作的API都在import <mach-o/getsect.h>中声明
- (void)SegmentSectionAPI {
//    1. 获取进程中映像的某段中某个节的非Slide的数据指针和尺寸  （不建议使用🚫）
//    //获取进程中可执行程序映像的某个段中某个节的数据指针和尺寸。
//     char *getsectdata(const char *segname, const char *sectname, unsigned long *size)
//    //获取进程加载的库的segname段和sectname节的数据指针和尺寸。
//     char *getsectdatafromFramework(const char *FrameworkName, const char *segname, const char *sectname, unsigned long *size);
    
    //一般索引为1的都是可执行文件映像
    intptr_t  slide = _dyld_get_image_vmaddr_slide(0);
    unsigned long size = 0;
    char *paddr = getsectdata("__TEXT", "__text", &size);//有问题⚠️ 返回空
    char *prealaddr = paddr + slide;  //这才是真实要访问的地址。
    
//    2.获取段和节的边界信息
//    //获取当前进程可执行程序映像的最后一个段的数据后面的开始地址。
//    unsigned long get_end(void);
//    //获取当前进程可执行程序映像的第一个__TEXT段的__text节的数据后面的开始地址。
//     unsigned long get_etext(void);
//    //获取获取当前进程可执行程序映像的第一个_DATA段的__data节的数据后面的开始地址
//     unsigned long get_edata(void);
    
//    这几个函数主要用来获取指定段和节的结束位置，以及用来确定某个地址是否在指定的边界内。需要注意的是这几个函数返回的边界值是并未加Slide值的边界值。
    
//    3.获取进程中可执行程序映像的段描述信息
//    //获取进程中可执行程序映像的指定段名的段描述信息
//    const struct segment_command *getsegbyname(const char *segname)
//    //上面函数的64位版本
//    const struct segment_command_64 *getsegbyname(const char *segname)
    const struct segment_command_64 *segment = getsegbyname("__TEXT");
    
//    4.获取进程中可执行程序映像的某个段中某个节的描述信息
//    //获取进程中可执行程序映像的某个段中某个节的描述信息。
//    const struct section *getsectbyname(const char *segname,  const char *sectname)
//    //上面对应函数的64位系统版本
//    const struct section_64 *getsectbyname(const char *segname, const char *sectname)
    const struct section_64 *section = getsectbyname("__TEXT","__text");
    
//    5.获取进程中映像的段的数据
//    //获取指定映像的指定段的数据。
//    uint8_t *getsegmentdata(const struct mach_header *mhp, const char *segname, unsigned long *size)
//    //上面函数的64位版本
//    uint8_t *getsegmentdata(const struct mach_header_64 *mhp, const char *segname, unsigned long *size)
//    函数返回进程内指定映像mhp中的段segname中内容的地址指针，而整个段的尺寸则返回到size所指的指针当中。这个函数的内部实现就是返回段描述信息结构struct segment_command中的vmaddr数据成员的值加上映像mhp的slide值。而size中返回的就是段描述信息结构中的vmsize数据成员。
    
    //⚠️进程中每个映像中的第一个__TEXT段的数据的地址其实就是这个映像的mach_header头结构的地址。这是一个比较特殊的情况。
    extern const struct mach_header* _NSGetMachExecuteHeader(void);
    const struct mach_header *machHeader = _NSGetMachExecuteHeader();
    uint8_t *segmentdata = getsegmentdata((struct mach_header_64 *)machHeader, "__TEXT", &size);

//    6.获取进程映像的某段中某节的数据
//    //获取进程映像中的某段中某节的数据地址和尺寸。
//    uint8_t *getsectiondata(const struct mach_header *mhp, const char *segname, const char *sectname, unsigned long *size)
//    //上面函数的64位版本
//    uint8_t *getsectiondata(const struct mach_header_64 *mhp, const char *segname, const char *sectname, unsigned long *size)
//    函数返回进程内指定映像mhp中的段segname中sectname节中内容的地址指针，而整个节的尺寸则返回到size所指的指针当中。这个函数的内部实现就是返回节描述信息结构struct section中的addr数据成员的值加上映像mhp的slide值。而size中返回的就是段描述信息结构中的size数据成员的值。
    const struct mach_header_64 *mhp = (struct mach_header_64 *)_dyld_get_image_header(0);
    uint8_t *pdata = getsectiondata(mhp,  "__TEXT", "__text", &size);
    
//    7.获取mach-O文件中的某个段中某个节的描述信息
//    //获取指定mach-o文件中的某个段中某个节中的描述信息
//    const struct section *getsectbynamefromheader(const struct mach_header *mhp, const char *segname, const char *sectname)
//    //获取指定mach-o文件中的某个段中某个节中的描述信息。fSwap传NXByteOrder枚举值。
//    const struct section *getsectbynamefromheaderwithswap(struct mach_header *mhp, const char *segname, const char *sectname, int fSwap)
//    //上面对应函数的64位系统版本
//    const struct section_64 *getsectbynamefromheader_64(const struct mach_header_64 *mhp, const char *segname, const char *sectname)
//    //上面对应函数的64位系统版本
//    const struct section *getsectbynamefromheaderwithswap_64(struct mach_header_64 *mhp, const char *segname, const char *sectname, int fSwap)
    
//    8.获取mach-o文件中的某段中的某个节的数据指针和尺寸
//    //获取指定mach-o文件中的某个段中的某个节的数据指针和尺寸
//    char *getsectdatafromheader(const struct mach_header *mhp, const char *segname, const char *sectname, uint32_t *size)
//    //64位系统函数
//    char *getsectdatafromheader_64(const struct mach_header_64 *mhp, const char *segname, const char *sectname, uint64_t *size)
//    这两个函数其实就是返回对应的节描述信息结构struct section中的addr值和size值。因为这两个函数是针对mach-o文件的，但是也可以用在对应的库映像中，当应用在库映像中时就要记得对返回的结果加上对应的slide值才是真实的节数据所对应的地址！

    
    
    
}

//进程映像(Image)操作API   对映像进行操作的API都在<mach-o/dyld.h>中声明
- (void)ImageAPI {
    //    映像的Slide值 = 映像的mach_header结构体指针 - 映像的第一个__TEXT代码段描述结构体struct segmeng_command中的vmaddr数据成员的值。
        
        //1.获取当前进程中加载的映像的数量
    //    uint32_t  _dyld_image_count(void)
        uint32_t imageCount = _dyld_image_count();
        printf("映像的数量：%d\n",imageCount);
        
        //2.获取某个映像的mach-o头部信息结构体指针
    //    const struct mach_header*   _dyld_get_image_header(uint32_t image_index)
    #ifdef __LP64__
    typedef struct mach_header_64     mach_header_t;
    #else
    typedef struct mach_header        mach_header_t;
    #endif
        //    一个映像的头部信息结构体指针其实就是映像在内存中加载的基地址。
        //    一般情况下索引为0的映像是dyld库的映像，而索引为1的映像就是当前进程的可执行程序映像
        const struct mach_header *machHeader = _dyld_get_image_header(0);
        Dl_info info;
        dladdr(machHeader, &info);
        printf("%s %p\n",info.dli_fname,info.dli_fbase);

    //    系统还提供一个没有在头文件中声明的函数：
    //    const struct mach_header* _NSGetMachExecuteHeader()
    //    这个函数返回当前进程的可执行程序映像的头部信息结构体指针。
    //    因为这个函数没有在某个具体的头文件中被声明，所以当你要使用这个函数时需要在源代码文件的开头进行声明处理：
        extern const struct mach_header* _NSGetMachExecuteHeader(void);
        const struct mach_header *machHeader1 = _NSGetMachExecuteHeader();
        Dl_info info1;
        dladdr(machHeader1, &info1);
        printf("%s %p\n",info1.dli_fname,info1.dli_fbase);

    //    3.获取进程中某个映像加载的Slide值
    //    intptr_t   _dyld_get_image_vmaddr_slide(uint32_t image_index)
        intptr_t ptr = _dyld_get_image_vmaddr_slide(0);
        printf("slide: %p\n",ptr);
        
    //    4.获取进程中某个映像的名称
    //    const char*  _dyld_get_image_name(uint32_t image_index)
        const char *imageName = _dyld_get_image_name(0);
        printf("image：%s\n",imageName);
        
    //    5.注册映像加载和卸载的回调通知函数
    //    void _dyld_register_func_for_add_image(void (*func)(const struct mach_header* mh, intptr_t vmaddr_slide))
    //    void _dyld_register_func_for_remove_image(void (*func)(const struct mach_header* mh, intptr_t vmaddr_slide))
        
    //    6.获取某个库链接时和运行时的版本号
    //    //获取库运行时的版本号
    //    int32_t NSVersionOfRunTimeLibrary(const char* libraryName)
    //    //获取库链接时的版本号
    //    int32_t NSVersionOfLinkTimeLibrary(const char* libraryName)
        
        //这里的名称c++其实是指的libc++.dylib这个库。
    //        uint32_t v1 =  NSVersionOfRunTimeLibrary("c++");
    //        uint32_t v2 =  NSVersionOfLinkTimeLibrary("c++");
        
    //    7.获取当前进程可执行程序的路径文件名
    //    int _NSGetExecutablePath(char* buf, uint32_t* bufsize)
        char buf[256];
        uint32_t bufsize = sizeof(buf)/sizeof(char);
        _NSGetExecutablePath(buf, &bufsize);
        printf("path：%s\n",buf);
        
    //    8.注册当前线程结束时的回调函数
    //    void _tlv_atexit(void (*termFunc)(void* objAddr), void* objAddr)
    //    这个函数用来监控当前线程的结束，当线程结束或者终止时就会调用注册的回调函数，_tlv_atexit函数有两个参数：第一个是一个回调函数指针，第二个是一个扩展参数，作为回调函数的入参来使用。
}

//检查有没有被恶意HOOK
//BOOL checkMethodBeHooked(Class class, SEL selector)
//{
//    //你也可以借助runtime中的C函数来获取方法的实现地址
//    IMP imp = [class instanceMethodForSelector:selector];
//    if (imp == NULL)
//         return NO;
//
//    //计算出可执行程序的slide值。
//    intptr_t pmh = (intptr_t)_NSGetMachExecuteHeader();
//    intptr_t slide = 0;
//#ifdef __LP64__
//    const struct segment_command_64 *psegment = getsegbyname("__TEXT");
//#else
//    const struct segment_command *psegment = getsegbyname("__TEXT");
//#endif
//    intptr_t slide = pmh - psegment->vmaddr
//
//    unsigned long startpos = (unsigned long) pmh;
//    unsigned long endpos = get_end() + slide;
//    unsigned long imppos = (unsigned long)imp;
//
//    return (imppos < startpos) || (imppos > endpos);
//}

@end
