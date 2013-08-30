//
//  UIView+WeView2.h
//  Unknown Project
//
//  Copyright (c) 2013 Charles Matthew Chen. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "WeView2Common.h"
#import "WeView2ViewInfo.h"

@interface UIView (WeView2) <NSCopying>

// See comments in WeView2ViewInfo.

/* CODEGEN MARKER: Start */

- (CGFloat)minWidth;
- (UIView *)setMinWidth:(CGFloat)value;
- (CGFloat)maxWidth;
- (UIView *)setMaxWidth:(CGFloat)value;
- (CGFloat)minHeight;
- (UIView *)setMinHeight:(CGFloat)value;
- (CGFloat)maxHeight;
- (UIView *)setMaxHeight:(CGFloat)value;

- (CGFloat)hStretchWeight;
- (UIView *)setHStretchWeight:(CGFloat)value;
- (CGFloat)vStretchWeight;
- (UIView *)setVStretchWeight:(CGFloat)value;
- (BOOL)ignoreNaturalSize;
- (UIView *)setIgnoreNaturalSize:(BOOL)value;

- (CGFloat)leftMargin;
- (UIView *)setLeftMargin:(CGFloat)value;
- (CGFloat)rightMargin;
- (UIView *)setRightMargin:(CGFloat)value;
- (CGFloat)topMargin;
- (UIView *)setTopMargin:(CGFloat)value;
- (CGFloat)bottomMargin;
- (UIView *)setBottomMargin:(CGFloat)value;

- (CGFloat)vSpacing;
- (UIView *)setVSpacing:(CGFloat)value;
- (CGFloat)hSpacing;
- (UIView *)setHSpacing:(CGFloat)value;

- (NSString *)debugName;
- (UIView *)setDebugName:(NSString *)value;
- (BOOL)debugLayout;
- (UIView *)setDebugLayout:(BOOL)value;

// Convenience accessor(s) for the minWidth and minHeight properties.
- (CGSize)minSize;
- (UIView *)setMinSize:(CGSize)value;

// Convenience accessor(s) for the maxWidth and maxHeight properties.
- (CGSize)maxSize;
- (UIView *)setMaxSize:(CGSize)value;

// Convenience accessor(s) for the minWidth and maxWidth properties.
- (UIView *)setFixedWidth:(CGFloat)value;

// Convenience accessor(s) for the minHeight and maxHeight properties.
- (UIView *)setFixedHeight:(CGFloat)value;

// Convenience accessor(s) for the minWidth, minHeight, maxWidth and maxHeight properties.
- (UIView *)setFixedSize:(CGSize)value;

// Convenience accessor(s) for the vStretchWeight and hStretchWeight properties.
- (UIView *)setStretchWeight:(CGFloat)value;

// Convenience accessor(s) for the leftMargin and rightMargin properties.
- (UIView *)setHMargin:(CGFloat)value;

// Convenience accessor(s) for the topMargin and bottomMargin properties.
- (UIView *)setVMargin:(CGFloat)value;

// Convenience accessor(s) for the leftMargin, rightMargin, topMargin and bottomMargin properties.
- (UIView *)setMargin:(CGFloat)value;

// Convenience accessor(s) for the hSpacing and vSpacing properties.
- (UIView *)setSpacing:(CGFloat)value;

/* CODEGEN MARKER: End */

// Describes the horizontal alignment of subviews within this view.
- (HAlign)hAlign;
- (UIView *)setHAlign:(HAlign)value;

// Describes the vertical alignment of subviews within this view.
- (VAlign)vAlign;
- (UIView *)setVAlign:(VAlign)value;

// Layout should stretch this subview to fit any available space.
- (UIView *)withStretch;

// Layout should stretch this subview to fit any available space, ignoring its natural size.
- (UIView *)withPureStretch;

#pragma mark - Convenience Accessors

- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;
- (CGFloat)x;
- (void)setX:(CGFloat)value;
- (CGFloat)y;
- (void)setY:(CGFloat)value;

// The width, height and size have the same effect on the bounds and frame.
- (CGSize)size;
- (void)setSize:(CGSize)size;
- (CGFloat)width;
- (void)setWidth:(CGFloat)value;
- (CGFloat)height;
- (void)setHeight:(CGFloat)value;

- (CGFloat)right;
- (void)setRight:(CGFloat)value;
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)value;

- (void)centerHorizontallyInSuperview;
- (void)centerVerticallyInSuperview;

- (NSString *)layoutDescription;

@end
