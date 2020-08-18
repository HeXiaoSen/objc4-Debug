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


/**
 获取类的成员变量和属性

 @param cls 类
 */
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


/**
 获取类的对象方法名

 @param cls 类
 */
void testObjc_copyMethodList(Class cls) {
    unsigned int count = 0;
    Method *methods = class_copyMethodList(cls, &count);
    for (unsigned int i=0; i < count; i++) {
        Method const method = methods[i];
        //获取方法名
        NSString *key = NSStringFromSelector(method_getName(method));
        
        NSLog(@"Method, name: %@", key);
    }
    free(methods);
}


/**
 获取元类的实例方法
 类对象的类方法，在元类的方法列表里面。
 @param cls 类
 */
void testInstanceMethod_classToMetaclass(Class cls) {
    const char *className = class_getName(cls);
    Class metaClass = objc_getMetaClass(className);
    
    Method method1 = class_getInstanceMethod(cls, @selector(walk));
    Method method2 = class_getInstanceMethod(metaClass, @selector(fly));
    
    Method method3 = class_getInstanceMethod(cls, @selector(walk));
    Method method4 = class_getInstanceMethod(metaClass, @selector(fly));
    
    NSLog(@"%p-%p-%p-%p",method1,method2,method3,method4);
    NSLog(@"%s",__func__);
}



/**
 获取元类的类方法

 @param cls 类
 */
void testClassMethod_classToMetaclass(Class cls) {
    const char *className = class_getName(cls);
    Class metaClass = objc_getMetaClass(className);
    
    Method method1 = class_getClassMethod(cls, @selector(walk));
    Method method2 = class_getClassMethod(metaClass, @selector(fly));
    
    Method method3 = class_getClassMethod(cls, @selector(walk));
    Method method4 = class_getClassMethod(metaClass, @selector(fly));
    
    NSLog(@"%p-%p-%p-%p",method1,method2,method3,method4);
    NSLog(@"%s",__func__);
}


/**
 获取元类方法的实现。

 @param cls 类
 */
void testIMP_classToMetaclass(Class cls) {
    const char *className = class_getName(cls);
    Class metaClass = objc_getMetaClass(className);
    
    IMP imp1 = class_getMethodImplementation(cls, @selector(walk));
    IMP imp2 = class_getMethodImplementation(metaClass, @selector(fly));
    
    IMP imp3 = class_getMethodImplementation(cls, @selector(walk));
    IMP imp4 = class_getMethodImplementation(metaClass, @selector(fly));
    
    NSLog(@"%p-%p-%p-%p",imp1,imp2,imp3,imp4);
    NSLog(@"%s",__func__);
}



@interface HXSFather : NSObject
- (void)walk;
+ (void)run;
@end

@implementation HXSFather
- (void)walk { NSLog(@"%s", __func__); }
+ (void)run {NSLog(@"%s", __func__);}
@end


@interface HXSSon : HXSFather
- (void)jump;
+ (void)swim;
@end

@implementation HXSSon

- (void)jump { NSLog(@"%s", __func__); }
+ (void)swim {NSLog(@"%s", __func__);}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        HXSPerson *p = [HXSPerson alloc];
        
        Class cls = object_getClass(p);
        
        [p doFirst];
        [p doSecend];
        [p doThird];
        
//        testObjc_copyIvar_copyProperies(cls);
//        testObjc_copyMethodList(cls);
//        testInstanceMethod_classToMetaclass(cls);
//        testClassMethod_classToMetaclass(cls);
//        testIMP_classToMetaclass(cls);
//        NSLog(@"Class Name:%@", cls);
        
        HXSSon *son = [HXSSon new];
        objc_msgSend(son, sel_registerName("jump"));//发送实例方法
        objc_msgSend(objc_getClass("HXSSon"), sel_registerName("swim"));//发送类方法
        

    }
    return 0;
}

