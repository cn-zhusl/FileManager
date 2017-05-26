//
//  FilePathConfig.m
//  FileManager
//
//  Created by zhu_sl on 2017/5/26.
//  Copyright © 2017年 zhu_sl. All rights reserved.
//

#import "FilePathConfig.h"

static FilePathConfig * fConig;

@implementation FilePathConfig

+ (FilePathConfig *)share
{
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^ {
        
        fConig = [[self alloc] init];
    });
    
    return fConig;
}

+ (NSString *)fileHomePatch:(NSString *)nowPath withFileName:(NSString *)fileName{
    //[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    return [NSString stringWithFormat:@"%@/%@",nowPath,fileName];
}


@end
