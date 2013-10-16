//
//  DefaultSandboxView.m
//  WeView 2
//
//  Copyright (c) 2013 Charles Matthew Chen. All rights reserved.
//
//  Distributed under the Apache License v2.0.
//  http://www.apache.org/licenses/LICENSE-2.0.html
//

#import "WeView.h"
#import "DefaultSandboxView.h"
#import "WeViewMacros.h"
#import "WeViewDemoConstants.h"
#import "DemoViewFactory.h"

typedef enum
{
    SANDBOX_MODE_DEFAULT,
    SANDBOX_MODE_IPHONE_4_PORTRAIT,
    SANDBOX_MODE_IPHONE_4_LANDSCAPE,
    SANDBOX_MODE_IPHONE_5_PORTRAIT,
    SANDBOX_MODE_IPHONE_5_LANDSCAPE,
} SandboxMode;

@interface DefaultSandboxView ()

@property (nonatomic) DemoModel *demoModel;
@property (nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) WeView *phoneContainer;

@end

#pragma mark -

@implementation DefaultSandboxView

- (id)init
{
    self = [super init];
    if (self)
    {
        self.opaque = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"subtlepatterns.com/graphy_modified/graphy_modified"]];

        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        [self addGestureRecognizer:self.panGestureRecognizer];
    }
    return self;
}

- (CGSize)rootViewSize
{
    CGSize rootViewSize = ((UIView *) self.subviews[0]).size;
    return CGSizeMin(self.size, rootViewSize);
}

- (CGSize)maxViewSize
{
    return self.size;
}

- (void)setControlsHidden:(BOOL)value
{
    for (int i=0; i < [self.subviews count]; i++)
    {
        UIView *subview = self.subviews[i];
        subview.hidden = i > 0 && value;
    }
}

- (void)createContents:(SandboxMode)mode
{
    if (mode == SANDBOX_MODE_DEFAULT)
    {
        UILabel *resizeInstructionsLabel = [DemoViewFactory createLabel:@"Drag in this window to resize"
                                                               fontSize:14.f
                                                              textColor:[DemoViewFactory colorWithRGBHex:0x888888]];
        [self addSubview:resizeInstructionsLabel
         withLayoutBlock:^(UIView *superview, UIView *subview) {
             WeViewAssert(subview);
             WeViewAssert(subview.superview);
             const int kHMargin = 20 + 5;
             const int kVMargin = 20 + 5;
             subview.right = subview.superview.width - kHMargin;
             subview.bottom = subview.superview.height - kVMargin;
         }];
        self.panGestureRecognizer.enabled = YES;
    }
    else
    {
        self.panGestureRecognizer.enabled = NO;
    }

    WeView *modePanel = [[WeView alloc] init];

    [[[modePanel addSubviewsWithVerticalLayout:@[
       [DemoViewFactory createFlatUIButton:@"Snap to desired size"
                                 textColor:[UIColor colorWithWhite:1.f alpha:1.f]
                               buttonColor:[UIColor colorWithWhite:0.5f alpha:1.f]
                                    target:self
                                  selector:@selector(snapToDesiredSize:)],
       [DemoViewFactory createFlatUIButton:@"iPhone 4 (Portrait)"
                                 textColor:[UIColor colorWithWhite:1.f alpha:1.f]
                               buttonColor:[UIColor colorWithWhite:0.5f alpha:1.f]
                                    target:self
                                  selector:@selector(snapToIPhone4Portrait:)],
       [DemoViewFactory createFlatUIButton:@"iPhone 4 (Landscape)"
                                 textColor:[UIColor colorWithWhite:1.f alpha:1.f]
                               buttonColor:[UIColor colorWithWhite:0.5f alpha:1.f]
                                    target:self
                                  selector:@selector(snapToIPhone4Landscape:)],
       [DemoViewFactory createFlatUIButton:@"iPhone 5 (Portrait)"
                                 textColor:[UIColor colorWithWhite:1.f alpha:1.f]
                               buttonColor:[UIColor colorWithWhite:0.5f alpha:1.f]
                                    target:self
                                  selector:@selector(snapToIPhone5Portrait:)],
       [DemoViewFactory createFlatUIButton:@"iPhone 5 (Landscape)"
                                 textColor:[UIColor colorWithWhite:1.f alpha:1.f]
                               buttonColor:[UIColor colorWithWhite:0.5f alpha:1.f]
                                    target:self
                                  selector:@selector(snapToIPhone5Landscape:)],
       ]]
      setSpacing:10]
     setHAlign:H_ALIGN_LEFT];

    [[[[self addSubviewWithCustomLayout:modePanel]
       setMargin:20]
      setHAlign:H_ALIGN_LEFT]
     setVAlign:V_ALIGN_BOTTOM];
}

- (void)snapToDesiredSize:(id)sender
{
    [self displayDemoModel:self.demoModel
                      mode:SANDBOX_MODE_DEFAULT];
}

- (void)snapToIPhone4Portrait:(id)sender
{
    [self displayDemoModel:self.demoModel
                      mode:SANDBOX_MODE_IPHONE_4_PORTRAIT];
}

- (void)snapToIPhone4Landscape:(id)sender
{
    [self displayDemoModel:self.demoModel
                      mode:SANDBOX_MODE_IPHONE_4_LANDSCAPE];
}

- (void)snapToIPhone5Portrait:(id)sender
{
    [self displayDemoModel:self.demoModel
                      mode:SANDBOX_MODE_IPHONE_5_PORTRAIT];
}

- (void)snapToIPhone5Landscape:(id)sender
{
    [self displayDemoModel:self.demoModel
                      mode:SANDBOX_MODE_IPHONE_5_LANDSCAPE];
}

- (void)handlePan:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan ||
        sender.state == UIGestureRecognizerStateChanged ||
        sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint rootViewCenter = [self convertPoint:self.center
                                           fromView:self.superview];
        CGPoint gesturePoint = [sender locationInView:self];
        CGPoint distance = CGPointAbs(CGPointSubtract(rootViewCenter, gesturePoint));

        // Do not layout the phoneContainer.
        [self.phoneContainer removeFromSuperview];
        [self addSubview:self.phoneContainer];

        self.demoModel.rootView.size = CGSizeRound(CGSizeMake(distance.x * 2.f,
                                                              distance.y * 2.f));
        [self.demoModel.rootView centerHorizontallyInSuperview];
        [self.demoModel.rootView centerVerticallyInSuperview];
    }
}

- (void)displayDemoModel:(DemoModel *)demoModel
{
    self.demoModel = demoModel;
    self.demoModel.selection = self.demoModel.rootView;
    [self displayDemoModel:demoModel
                      mode:(demoModel.useIPhoneSandboxByDefault
                            ? SANDBOX_MODE_IPHONE_4_PORTRAIT
                            : SANDBOX_MODE_DEFAULT)];
}

- (void)showDemoModelInIPhone:(DemoModel *)demoModel
                    imageName:(NSString *)imageName
                 screenBounds:(CGRect)screenBounds
{
    WeView *phoneScreen = [[WeView alloc] init];
    phoneScreen.backgroundColor = [UIColor whiteColor];
    phoneScreen.opaque = YES;

    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    WeViewAssert(phoneImageView.image);
    self.phoneContainer = [[WeView alloc] init];
    [[self.phoneContainer addSubviewWithCustomLayout:phoneImageView]
     setCropSubviewOverflow:NO];
    self.phoneContainer.fixedSize = phoneImageView.image.size;
    [[self.phoneContainer addSubview:phoneScreen
               withLayoutBlock:^(UIView *superview, UIView *subview) {
                   WeViewAssert(subview);
                   WeViewAssert(subview.superview);
                   subview.frame = screenBounds;
                   [subview setNeedsLayout];
               }]
     setCropSubviewOverflow:NO];

    //    phoneContainer.debugLayout = YES;

    [phoneScreen addSubviewWithCustomLayout:self.demoModel.rootView];

    [self addSubviewWithCustomLayout:self.phoneContainer];
}

- (void)displayDemoModel:(DemoModel *)demoModel
                    mode:(SandboxMode)mode
{
    [self removeAllSubviews];
    [self resetAllLayoutProperties];
    WeViewAssert([self.subviews count] == 0);

    switch (mode)
    {
        case SANDBOX_MODE_DEFAULT:
        {
            [demoModel.rootView removeFromSuperview];
            [self addSubviewWithCustomLayout:demoModel.rootView];
            break;
        }
        case SANDBOX_MODE_IPHONE_4_PORTRAIT:
            [self showDemoModelInIPhone:demoModel
                              imageName:@"Images/iphone_4_portrait"
                           screenBounds:CGRectMake(32, 133, 320, 480)];
            break;
        case SANDBOX_MODE_IPHONE_4_LANDSCAPE:
            [self showDemoModelInIPhone:demoModel
                              imageName:@"Images/iphone_4_landscape"
                           screenBounds:CGRectMake(133, 29, 480, 320)];
            break;
        case SANDBOX_MODE_IPHONE_5_PORTRAIT:
            [self showDemoModelInIPhone:demoModel
                              imageName:@"Images/iphone_5_portrait"
                           screenBounds:CGRectMake(34, 119, 320, 568)];
            break;
        case SANDBOX_MODE_IPHONE_5_LANDSCAPE:
            [self showDemoModelInIPhone:demoModel
                              imageName:@"Images/iphone_5_landscape"
                           screenBounds:CGRectMake(119, 29, 568, 320)];
            break;
        default:
            WeViewAssert(0);
            break;
    }

    [self createContents:mode];
}

@end
