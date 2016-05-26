//
//  XmAddPlansPresentationViewController.m
//  beBetterMySelf
//
//  Created by 肖敏 on 16/3/30.
//  Copyright © 2016年 xiaomin. All rights reserved.
//

#import "XmAddPlansPresentationViewController.h"
#define perspective 1.0/-600

@implementation XmAddPlansPresentationViewController



#pragma warn 父类重写的5个方法
/**
 * 容器里呈现VC时调用的 will & did
 */
-(void)presentationTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    //CATransform3D transform = CATransform3DIdentity;
    //transform.m34 = perspective;
    //transform = CATransform3DRotate(transform, angle , 0.0f, 1.0f, 0.0f);
    CATransform3D transform = CATransform3DMakeScale(0.95, 0.95, 1.0);   //这个是缩小，我想要的。参数是按比例整体缩小。
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        self.presentingViewController.view.layer.transform = transform;
        self.presentingViewController.view.alpha =  0.5;
    } completion:nil];
}


#pragma mark 返回容器VC时调用, will & did
-(void)dismissalTransitionWillBegin {
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    ///CATransform3D transform = CATransform3DIdentity;
    //transform.m34 = perspective;
    //transform = CATransform3DRotate(transform, angle , 0.0f, 1.0f, 0.0f);
    CATransform3D transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
        //[_dimmingView setAlpha:0.0];
        self.presentingViewController.view.layer.transform = transform;
        self.presentingViewController.view.alpha =  1.0;
    } completion:nil];
}

-(void)dismissalTransitionDidEnd:(BOOL)completed {
    //NSLog(@"dismissalTransitionDidEnd");
    //if (completed) {
        //TODO 添加按钮变的可点
    //}
}

#pragma mark - VC呈现在容器里的位置
-(CGRect)frameOfPresentedViewInContainerView {
    //调整presentedVC的大小位置
    CGRect frame = self.containerView.bounds;
    frame = CGRectInset(frame, 0, 50);
    return frame;
}
@end
