//
//  main.m
//  objc-debug
//
//  Created by Cooci on 2019/10/9.
//

#import <Foundation/Foundation.h>
#import "HXSPerson.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        HXSPerson *p = [HXSPerson alloc];
        p.name = @"Felix";
        p.age = 20;
        p.height = 180;
        p.c1 = 'a';
        p.c2 = 'b';
        
        NSLog(@"sizeof——%lu", sizeof([p class]));
        NSLog(@"class_getInstanceSize——%lu", class_getInstanceSize([p class]));
        NSLog(@"malloc_size——%lu", malloc_size((__bridge const void *)(p)));

    }
    return 0;
}
