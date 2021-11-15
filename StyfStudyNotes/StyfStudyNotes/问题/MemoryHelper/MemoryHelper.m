//
//  MemoryHelper.m
//  StyfStudyNotes
//
//  Created by styf on 2021/11/8.
//

#import "MemoryHelper.h"
#include <mach/mach.h>

@interface MemoryHelper ()

@end

@implementation MemoryHelper

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    NSLog(@"physicalMemory : %.1f MB",[NSProcessInfo processInfo].physicalMemory/1024.0/1024);
    NSLog(@"memoryPhysFootprint : %.1f MB",[self memoryPhysFootprint]/1024.0/1024);
    NSLog(@"memoryResidentSize : %.1f MB",[self memoryResidentSize]/1024.0/1024);
    NSLog(@"memoryVirtualSize : %.1f GB",[self memoryVirtualSize]/1024.0/1024/1024);
}

/*
* phys_footprint
*   Physical footprint: This is the sum of:
*     + (internal - alternate_accounting)
*     + (internal_compressed - alternate_accounting_compressed)
*     + iokit_mapped
*     + purgeable_nonvolatile
*     + purgeable_nonvolatile_compressed
*     + page_table
*
* internal
*   The task's anonymous memory, which on iOS is always resident.
*
* internal_compressed
*   Amount of this task's internal memory which is held by the compressor.
*   Such memory is no longer actually resident for the task [i.e., resident in its pmap],
*   and could be either decompressed back into memory, or paged out to storage, depending
*   on our implementation.
*
* iokit_mapped
*   IOKit mappings: The total size of all IOKit mappings in this task, regardless of
    clean/dirty or internal/external state].
*
* alternate_accounting
*   The number of internal dirty pages which are part of IOKit mappings. By definition, these pages
*   are counted in both internal *and* iokit_mapped, so we must subtract them from the total to avoid
*   double counting.
*/

//真正消耗的物理内存
- (int64_t)memoryPhysFootprint {
    int64_t memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernelReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if(kernelReturn == KERN_SUCCESS) {
        memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
//        NSLog(@"Memory in use (in bytes): %lld", memoryUsageInByte);
    } else {
        NSLog(@"Error with task_info(): %s", mach_error_string(kernelReturn));
    }
    return memoryUsageInByte;
}

//已经被映射到虚拟内存中的物理内存
- (int64_t)memoryResidentSize {
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(task_basic_info_data_t) / sizeof(natural_t);
    kern_return_t ret = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    if (ret != KERN_SUCCESS) {
        return 0;
    }
    return info.resident_size;
}



//获取App申请到的所有虚拟内存：
- (int64_t)memoryVirtualSize {
    struct task_basic_info info;
    mach_msg_type_number_t size = (sizeof(task_basic_info_data_t) / sizeof(natural_t));
    kern_return_t ret = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    if (ret != KERN_SUCCESS) {
        return 0;
    }
    return info.virtual_size;
}

@end
