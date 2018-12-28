//
//  FSCollectionViewLayout.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/23.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCollectionViewLayout.h"

@interface FSCollectionViewLayout ()
{
    CGFloat _viewHeight;
    CGFloat _itemHeight;
}

@end

@implementation FSCollectionViewLayout

- (instancetype)init
{
    if (self = [super init])
    {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    if (self.visibleCount < 1)
    {
        self.visibleCount = 5;
    }
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        _viewHeight = CGRectGetHeight(self.collectionView.frame);
        _itemHeight = self.itemSize.height;

        CGFloat edgeInset = (_viewHeight - _itemHeight) * 0.5;
        self.collectionView.contentInset = UIEdgeInsetsMake(edgeInset, 0, edgeInset, 0);
    }
    else
    {
        _viewHeight = CGRectGetWidth(self.collectionView.frame);
        _itemHeight = self.itemSize.width;

        CGFloat edgeInset = (_viewHeight - _itemHeight) * 0.5;
        self.collectionView.contentInset = UIEdgeInsetsMake(0, edgeInset, 0, edgeInset);
    }
    
}

- (CGSize)collectionViewContentSize
{
    NSUInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    CGSize contentSize = CGSizeZero;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        contentSize = CGSizeMake(self.collectionView.frame.size.width, cellCount * _itemHeight);
    }
    else
    {
        contentSize = CGSizeMake(cellCount * _itemHeight, self.collectionView.frame.size.height);
    }
    
    return contentSize;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat centerY = 0;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        centerY = self.collectionView.contentOffset.y + _viewHeight * 0.5;
    }
    else
    {
        centerY = self.collectionView.contentOffset.x + _viewHeight * 0.5;
    }
    
    NSInteger index = centerY / _itemHeight;
    NSInteger count = (self.visibleCount - 1) * 0.5;
    NSInteger minIndex = MAX(0, (index - count));
    NSInteger maxIndex = MIN((cellCount - 1), (index + count));
    
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:3];

    for (NSUInteger i = minIndex; i <= maxIndex; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        UICollectionViewLayoutAttributes *layoutAttr = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [tmpArray addObject:layoutAttr];
    }
    
    return tmpArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    layoutAttributes.size = self.itemSize;
    
    CGFloat centerY = 0;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        centerY = self.collectionView.contentOffset.y + _viewHeight * 0.5;
    }
    else
    {
        centerY = self.collectionView.contentOffset.x + _viewHeight * 0.5;
    }
    
    CGFloat attributeY = _itemHeight * indexPath.row + _itemHeight * 0.5;
    layoutAttributes.zIndex = -ABS(attributeY - centerY);
    
    
    CGFloat delta = centerY - attributeY;
    CGFloat ratio = -delta / (_itemHeight * 2);
    CGFloat scale = 1 - ABS(delta) / (_itemHeight * 6.0) * cos(ratio * M_PI_4);
    layoutAttributes.transform = CGAffineTransformMakeScale(scale, scale);
    
    
    CGFloat tmp = attributeY;
    layoutAttributes.transform = CGAffineTransformRotate(layoutAttributes.transform, -ratio * M_PI_4);
    tmp += sin(ratio * M_PI_2) * _itemHeight * 0.5;
    
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        layoutAttributes.center = CGPointMake(CGRectGetWidth(self.collectionView.frame) * 0.5, tmp);
    }
    else
    {
        layoutAttributes.center = CGPointMake(tmp, CGRectGetHeight(self.collectionView.frame) * 0.5);
    }
    
    return layoutAttributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat base = 0;

    if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        base = proposedContentOffset.y;
    }
    else
    {
        base = proposedContentOffset.x;
    }

    CGFloat index = roundf((base + _viewHeight * 0.5 - _itemHeight * 0.5) / _itemHeight);

    CGFloat offset = _itemHeight * index + _itemHeight * 0.5 - _viewHeight * 0.5;

    NSLog(@"base = %f, offset = %f", base, offset);
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical)
    {
        proposedContentOffset.y = offset;
    }
    else
    {
        proposedContentOffset.x = offset;
    }
    
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    BOOL flag = CGRectEqualToRect(newBounds, self.collectionView.bounds);
    
//    NSString *string = flag ? @"YES" : @"NO";
    
//    NSLog(@"%@, %@", string, NSStringFromCGRect(newBounds));
    
    return !flag;
}

@end
