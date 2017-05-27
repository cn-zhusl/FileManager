//
//  FilePathConfig.h
//  FileManager
//
//  Created by zhu_sl on 2017/5/26.
//  Copyright © 2017年 zhu_sl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilePathConfig : NSObject

@property (nonatomic,strong) NSString * fileHomePatch;

+ (FilePathConfig *)share;

+ (NSString *)fileHomePatch:(NSString *)nowPath withFileName:(NSString *)fileName;

@end
