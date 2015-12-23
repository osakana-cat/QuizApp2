//
//  QuizViewController.h
//  QuizApp
//
//  Created by さき on 2015/12/15.
//  Copyright © 2015年 saki.yokota. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController


//テキストビューのアウトレット
@property(nonatomic,weak) IBOutlet UITextView *quiz;


//次へボタン
@property(nonatomic,weak) IBOutlet UIButton *nextButton;


//マルバツボタン
@property(nonatomic,weak) IBOutlet UIButton *answerIsTrue;
@property(nonatomic,weak) IBOutlet UIButton *answerIsFalse;

//ボタン
- (IBAction)answerIsTrue:(id)sender;
- (IBAction)answerIsFalse:(id)sender;
- (IBAction)nextProblem:(id)sender;

@end
