//
//  VideosCell.m
//  Player
//
//  Created by admin on 16/5/25.
//  Copyright © 2016年 WYX. All rights reserved.
//

#import "VideosCell.h"
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度
@implementation VideosCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, Main_Screen_Width, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor purpleColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        
        _picImageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+5, Main_Screen_Width - 30, 160)];
        [self.contentView addSubview:_picImageVIew];
        
        
        _playBtn = [[UIButton alloc]initWithFrame:CGRectMake(_picImageVIew.frame.size.width/2 - 30, _picImageVIew.frame.size.height/2 - 30, 60, 60)];
        [_playBtn setImage:[UIImage imageNamed:@"video_cell_videoIcon@2x"] forState:UIControlStateNormal];
        [_picImageVIew addSubview:_playBtn];
        
    }
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
