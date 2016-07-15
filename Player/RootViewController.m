//
//  RootViewController.m
//  Player
//
//  Created by admin on 16/5/25.
//  Copyright © 2016年 WYX. All rights reserved.
//

#import "RootViewController.h"
#import "MoviePlayerViewController.h"
#import "VideosModel.h"
#import "VideosCell.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIImageView+AFNetworking.h"
#define kUrlString @"http://api.sina.cn/sinago/list.json?channel=video_video"
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RootViewController
{
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray=[[NSMutableArray alloc]init];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(15, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];

    [self requestData];
}

- (void)requestData
{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    [manager GET:kUrlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data1=responseObject[@"data"];
        NSArray *list=data1[@"list"];
        for (NSDictionary *perDic in list) {
            VideosModel *model=[[VideosModel alloc]init];
            model.titleString=perDic[@"title"];
            model.kPicString = perDic[@"kpic"];
            model.playUrl = [perDic[@"video_info"] objectForKey:@"url"];
            
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideosModel *model=_dataArray[indexPath.row];
    MoviePlayerViewController *movie = [[MoviePlayerViewController alloc]init];
    movie.playURL = model.playUrl;
    [self presentViewController:movie animated:YES completion:^{
        
        
    }];
    
}
#pragma mark -tableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideosCell *videosCell=[tableView dequeueReusableCellWithIdentifier:@"VideosCell"];
    if (videosCell==nil) {
        videosCell = [[VideosCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideosCell"];
    }
    VideosModel *model=_dataArray[indexPath.row];
    [videosCell.picImageVIew setImageWithURL:[NSURL URLWithString:model.kPicString]placeholderImage:[UIImage imageNamed:@"video_cell_playIcon@2x"]];
    [videosCell.titleLabel setText:[NSString stringWithFormat:@"%@",model.titleString]];
    return videosCell;
}



@end
