//
//  FileDirectorViewContoller.m
//  FileManager
//
//  Created by zhu_sl on 2017/5/26.
//  Copyright © 2017年 zhu_sl. All rights reserved.
//

#import "FileDirectorViewContoller.h"

@interface FileDirectorViewContoller ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray * items;

@property (nonatomic, strong) NSString * aSubName;

@property (nonatomic, strong) NSString * nowPath;

@end

@implementation FileDirectorViewContoller

- (instancetype)init{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    return [storyBoard instantiateViewControllerWithIdentifier:@"FileDirectorViewContoller"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _thisFileName;
    
    UIBarButtonItem * barAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDirect)];

    UIBarButtonItem * barWIFI = [[UIBarButtonItem alloc]  initWithImage:[[UIImage imageNamed:@"WIFI"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(actionWIFI)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:barWIFI,barAdd, nil];
    _nowPath = [_perentPath stringByAppendingString:[NSString stringWithFormat:@"/%@",_thisFileName]];
    
    [FilePathConfig share].fileHomePatch =_nowPath;
    
    [self getThisPathContent];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [[AppDelegate appDelegate].httpServer stop];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    cell.textLabel.text = [_items objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath  animated:YES];
    
    //点击的文件夹
    NSString * path = [_nowPath stringByAppendingString:[NSString stringWithFormat:@"/%@",[_items objectAtIndex:indexPath.row]]];
    BOOL isDir;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        
        if (isDir) {
            
            FileDirectorViewContoller * subDirectCtr = [[FileDirectorViewContoller alloc] init];
            subDirectCtr.thisFileName = [_items objectAtIndex:indexPath.row];
            subDirectCtr.perentPath = _nowPath;
            [self.navigationController pushViewController:subDirectCtr animated:YES];

        }else{
            
            NSLog(@"点击的不是文件夹");
        }
    }
    
}

- (void)addDirect{
    
    
    UIAlertController * aleartCtr = [UIAlertController alertControllerWithTitle:@"输入文件名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [aleartCtr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    
    [aleartCtr addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField * textField = [aleartCtr.textFields objectAtIndex:0];
        
        [self createFile:textField.text];
    }]];
    
    [aleartCtr addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:aleartCtr animated:YES completion:nil];
}

- (void)createFile:(NSString *)name{
    NSError * error;
    if ([[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",_nowPath,name] withIntermediateDirectories:YES attributes:nil error:&error]) {
        
        [self getThisPathContent];
    }else{
        NSLog(@"创建文件%@失败",name);
    }

}

- (void)getThisPathContent{
    
    
    NSFileManager * fileManger  = [NSFileManager defaultManager];
    
    NSError * error;
    
    _items = [fileManger contentsOfDirectoryAtPath:_nowPath error:&error];

    [_tableView reloadData];
}

- (void)actionWIFI{
    
    [[AppDelegate appDelegate] startServer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
