//
//  MBTitleView.h
//  循环滚动视图
//
//  Created by Lrs on 13-10-22.
//  Copyright (c) 2013年 Lrs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@protocol MBTitleViewDelegate;
@interface MBTitleView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    NSInteger num;
}
@property (nonatomic, retain) NSMutableArray *imageArray;
@property(nonatomic,unsafe_unretained)id<MBTitleViewDelegate>delegate;
-(void)addTitleViewImages;
@end

@protocol MBTitleViewDelegate <NSObject>
@optional
-(void)titleImageDidSelect:(UIImageView*)v;
@end