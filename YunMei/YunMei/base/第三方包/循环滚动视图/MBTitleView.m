//
//  MBTitleView.m
//  循环滚动视图
//
//  Created by Lrs on 13-10-22.
//  Copyright (c) 2013年 Lrs. All rights reserved.
//

#import "MBTitleView.h"

@implementation MBTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)addTitleViewImages
{
    [_imageArray insertObject:_imageArray[_imageArray.count-1] atIndex:0];
    [_imageArray addObject:_imageArray[1]];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    _scrollView.contentSize = CGSizeMake(_imageArray.count * self.frame.size.width, self.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.scrollsToTop = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView flashScrollIndicators];
    
    for (int i = 0 ; i < _imageArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*i, 0, self.frame.size.width, self.frame.size.height)];
        //imageView.image = _imageArray[i];
        
        //[imageView setImageWithURL:[NSURL URLWithString:@"http://imgnew.jiatx.com/news/2011_08/03/home/1312360607458_000.jpg"] placeholderImage:nil options:SDWebImageRetryFailed];
        
        [imageView setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:nil options:SDWebImageRetryFailed];
        
        imageView.tag = i +100;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureTapEvent:)];
        [imageView addGestureRecognizer:tap];
        [_scrollView addSubview:imageView];
    }
    
    
    _scrollView.contentOffset = CGPointMake(320, 0);
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width*(1-(_imageArray.count-2)*0.03), self.frame.size.height * 0.9, 0, 0)];
    _pageControl.numberOfPages = _imageArray.count-2;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.5f target:self selector:@selector(changePageNumber) userInfo:nil repeats:YES];
}

-(void)changePageNumber
{
    static int i = 0;
    if (i <=_imageArray.count -2 && i != _pageControl.currentPage)
    {
        i = _pageControl.currentPage+1;
    }
    else
    {
        if (i > _imageArray.count-2)
        {
            i = 0;
        }
        i++;
    }
    
    if (i == _imageArray.count -2)
    {
        [UIView animateWithDuration:1.25f animations:^{
            [_scrollView setContentOffset:CGPointMake((i+1)*320, 0)];
        } completion:^(BOOL finished) {
            [self scrollViewDidEndDecelerating:_scrollView];
        }];
    }
    else
    {
        [UIView animateWithDuration:1.25f animations:^{
            [_scrollView setContentOffset:CGPointMake((i+1)*320, 0)];
        }];
    }

}
#pragma tapEvent
-(void)gestureTapEvent:(UITapGestureRecognizer*)t
{
    UIImageView *view = (UIImageView*)t.view;
    if(_delegate && [_delegate respondsToSelector:@selector(titleImageDidSelect:)])
    {
        [_delegate titleImageDidSelect:view];
    }
}
#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageNum = scrollView.contentOffset.x / 320;
    if (pageNum <= 1)
    {
        _pageControl.currentPage = 0;
    }
    else if(pageNum >= _imageArray.count-2)
    {
        _pageControl.currentPage = _imageArray.count - 3;
    }
    else
    {
        _pageControl.currentPage = pageNum - 1;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger pageNum = scrollView.contentOffset.x / 320;
    if (pageNum < 1)
    {
        scrollView.contentOffset = CGPointMake((_imageArray.count-2) * 320, 0);
    }
    else if (pageNum > _imageArray.count-2)
    {
        scrollView.contentOffset = CGPointMake(320, 0);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
