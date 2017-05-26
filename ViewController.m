//
//  ViewController.m
//  FileManager
//
//  Created by zhu_sl on 2017/5/25.
//  Copyright © 2017年 zhu_sl. All rights reserved.
//

#import "ViewController.h"
#import "FileDirectorViewContoller.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [FilePathConfig share].fileHomePatch = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/HomeFile"];
}


- (IBAction)readDirector:(id)sender {
    
    FileDirectorViewContoller * directViewCtr = [[FileDirectorViewContoller alloc] init];
    directViewCtr.thisFileName = @"HomeFile";
    directViewCtr.perentPath   = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents"]];
    [self.navigationController pushViewController:directViewCtr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
