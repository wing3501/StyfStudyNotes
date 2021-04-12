//
//  LeaksDemo.m
//  StyfStudyNotes
//
//  Created by styf on 2021/4/12.
//

#import "LeaksDemo.h"
#import "LeaksObj.h"
#import "ShowDebugBlock.h"
@interface LeaksDemo ()
/// <#name#>
@property (nonatomic, strong) LeaksObj *leaksObj1;
/// <#name#>
@property (nonatomic, strong) LeaksObj *leaksObj2;
@end

@implementation LeaksDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    hookBlockDesc();
    
    LeaksObj *leaksObj1 = [LeaksObj new];
    LeaksObj *leaksObj2 = [LeaksObj new];
    id vc = self;
    int a = 1;
    
    leaksObj1.block1 = ^{
        NSLog(@"------>%@ %@ %d",leaksObj2,vc,a);
    };
    
    leaksObj2.block1 = ^{
        NSLog(@"------>%@",leaksObj1);
    };
    
    //Scheme - Malloc Stack Logging
    //Debug Memory Graph
    //dis -s *(void**)(0x600002f51110+16)
    
    //po [0x1119fe370 debugDescription]
    
    //hookBlockDesc
    //po [0x1119fe370 description]
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _leaksObj1.block1();
}

- (void)dealloc {
    NSLog(@"%s dealloc",__func__);
}

@end
