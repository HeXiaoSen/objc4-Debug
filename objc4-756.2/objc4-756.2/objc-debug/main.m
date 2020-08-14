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
#import "Object.h"

void testObjc_copyIvar_copyProperies(Class cls) {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(cls, &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar const ivar2 = ivars[i];
        //获取实例变量名
        const char *cname = ivar_getName(ivar2);
        NSString *ivarName = [NSString stringWithUTF8String:cname];
        NSLog(@"class_copyIvarList:%@", ivarName);
    }
    free(ivars);
    
    unsigned int pCount = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &pCount);
    for (unsigned int i = 0; i < pCount; i++) {
        objc_property_t const property = properties[i];
        //获取属性名
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        //获取属性值
        NSLog(@"class_copyProperties:%@", propertyName);
        
    }
    free(properties);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        HXSPerson *p = [HXSPerson alloc];
        
        Class cls = object_getClass(p);
        testObjc_copyIvar_copyProperies(cls);
        
        
        NSLog(@"Class Name:%@", cls);

    }
    return 0;
}

