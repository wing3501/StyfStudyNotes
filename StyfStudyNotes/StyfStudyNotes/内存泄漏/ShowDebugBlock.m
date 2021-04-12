//
//  ShowDebugBlock.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/12.
//

#import "ShowDebugBlock.h"
#import <objc/runtime.h>

//https://www.jianshu.com/p/8f02158649c5
/*
 * Copyright (c) 欧阳大哥2013. All rights reserved.
 * github地址：https://github.com/youngsoft
 */

void showBlockExtendedLayout(id block)
{
    static int32_t BLOCK_HAS_COPY_DISPOSE =  (1 << 25); // compiler
    static int32_t BLOCK_HAS_EXTENDED_LAYOUT  =  (1 << 31); // compiler
    
    struct Block_descriptor_1 {
        uintptr_t reserved;
        uintptr_t size;
    };

    struct Block_descriptor_2 {
        // requires BLOCK_HAS_COPY_DISPOSE
        void *copy;
        void *dispose;
    };

    struct Block_descriptor_3 {
        // requires BLOCK_HAS_SIGNATURE
        const char *signature;
        const char *layout;     // contents depend on BLOCK_HAS_EXTENDED_LAYOUT
    };
    
    struct Block_layout {
        void *isa;
        volatile int32_t flags; // contains ref count
        int32_t reserved;
        void *invoke;
        struct Block_descriptor_1 *descriptor;
        // imported variables
    };

    //将一个block对象转化为blockLayout结构体指针
    struct Block_layout *blockLayout = (__bridge struct Block_layout*)(block);
    //如果没有引用外部对象也就是没有扩展布局标志的话则直接返回。
    if (! (blockLayout->flags & BLOCK_HAS_EXTENDED_LAYOUT)) return;
    
    //得到描述信息，如果有BLOCK_HAS_COPY_DISPOSE则表示描述信息中有Block_descriptor_2中的内容，因此需要加上这部分信息的偏移。这里有BLOCK_HAS_COPY_DISPOSE的原因是因为当block持有了外部对象时，需要负责对外部对象的声明周期的管理，也就是当对block进行赋值拷贝以及销毁时都需要将引用的外部对象的引用计数进行添加或者减少处理。
    uint8_t *desc = (uint8_t *)blockLayout->descriptor;
    desc += sizeof(struct Block_descriptor_1);
    if (blockLayout->flags & BLOCK_HAS_COPY_DISPOSE) {
        desc += sizeof(struct Block_descriptor_2);
    }
    
    //最终转化为Block_descriptor_3中的结构指针。并且当布局值为0时表明没有引用外部对象。
    struct Block_descriptor_3 *desc3 = (struct Block_descriptor_3 *)desc;
    if (desc3->layout == 0)
        return;
    
    
    //所支持的外部对象的类型。
    static unsigned char BLOCK_LAYOUT_STRONG           = 3;    // N words strong pointers
    static unsigned char BLOCK_LAYOUT_BYREF            = 4;    // N words byref pointers
    static unsigned char BLOCK_LAYOUT_WEAK             = 5;    // N words weak pointers
    static unsigned char BLOCK_LAYOUT_UNRETAINED       = 6;    // N words unretained pointers
    
    const char *extlayoutstr = desc3->layout;
    //处理压缩布局描述的情况。
    if (extlayoutstr < (const char*)0x1000)
    {
        //当扩展布局的值小于0x1000时则是压缩的布局描述，这里分别取出xyz部分的内容进行重新编码。
        char compactEncoding[4] = {0};
        unsigned short xyz = (unsigned short)(extlayoutstr);
        unsigned char x = (xyz >> 8) & 0xF;
        unsigned char y = (xyz >> 4) & 0xF;
        unsigned char z = (xyz >> 0) & 0xF;
        
        int idx = 0;
        if (x != 0)
        {
            x--;
            compactEncoding[idx++] = (BLOCK_LAYOUT_STRONG<<4) | x;
        }
        if (y != 0)
        {
            y--;
            compactEncoding[idx++] = (BLOCK_LAYOUT_BYREF<<4) | y;
        }
        if (z != 0)
        {
            z--;
            compactEncoding[idx++] = (BLOCK_LAYOUT_WEAK<<4) | z;
        }
        compactEncoding[idx++] = 0;
        extlayoutstr = compactEncoding;
    }
    
    unsigned char *blockmemoryAddr = (__bridge void*)block;
    int refObjOffset = sizeof(struct Block_layout);  //得到外部引用对象的开始偏移位置。
    for (int i = 0; i < strlen(extlayoutstr); i++)
    {
        //取出字节中所表示的类型和数量。
        unsigned char PN = extlayoutstr[i];
        int P = (PN >> 4) & 0xF;   //P是高4位描述引用的类型。
        int N = (PN & 0xF) + 1;    //N是低4位描述对应类型的数量，这里要加1是因为格式的数量是从0个开始计算，也就是当N为0时其实是代表有1个此类型的数量。
        
       
        //这里只对类型为3，4，5，6四种类型进行处理。
        if (P >= BLOCK_LAYOUT_STRONG && P <= BLOCK_LAYOUT_UNRETAINED)
        {
            for (int j = 0; j < N; j++)
            {
                //因为引用外部的__block类型不是一个OC对象，因此这里跳过BLOCK_LAYOUT_BYREF,
                //当然如果你只想打印引用外部的BLOCK_LAYOUT_STRONG则可以修改具体的条件。
                if (P != BLOCK_LAYOUT_BYREF)
                {
                    //根据偏移得到引用外部对象的地址。并转化为OC对象。
                    void *refObjAddr = *(void**)(blockmemoryAddr + refObjOffset);
                    id refObj =  (__bridge id) refObjAddr;
                    //打印对象
                    NSLog(@"the refObj is:%@  type is:%d",refObj, P);
                }
                //因为布局中保存的是对象的指针，所以偏移要加上一个指针的大小继续获取下一个偏移。
                refObjOffset += sizeof(void*);
            }
        }
    }
}


//description方法的实现
NSString *block_description(id obj, SEL _cmd)
{
    showBlockExtendedLayout(obj);
    return @"";
}

void hookBlockDesc() {
    ////////////////////
    //针对NSBlock类型添加一个自定义的描述信息输出函数。
    Class blkcls = NSClassFromString(@"NSBlock");
    BOOL bok = class_addMethod(blkcls, @selector(description), (IMP)block_description, "@@:");
    if (bok) {
        
    }
}

