//
//  QuizViewController.m
//  QuizApp
//
//  Created by さき on 2015/12/15.
//  Copyright © 2015年 saki.yokota. All rights reserved.
//

#import "QuizViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QuizViewController (){
    
    //出題する問題数
    NSInteger totalProblems;
    //現在の進捗（出題済み問題数）を記録
    NSInteger currentProblem;
    //正答数
    NSInteger correctAnswers;
    
    //正答率
   NSInteger percentage;
    
    
    //条件を判別
    BOOL answer;

}
//音楽
@property (strong, nonatomic) AVAudioPlayer *player;


//@property (strong, nonatomic) AVAudioPlayer *batuPlayer;



@end


@implementation QuizViewController


- (void)playSoundMaru {

    
    NSError *error = nil;
    //音楽ファイルのファイルパス(音楽ファイルがデータ上どこにあるか)を作成
    // 再生する audio ファイルのパスを取得
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"right" ofType:@"mp3"];
    // パスから、再生するURLを作成する
    NSURL *url = [NSURL fileURLWithPath:path];
    // auido を再生するプレイヤーを作成する
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    // エラーが起きたとき
    if (error != nil) { //エラーがあった場合
        return;
    }
    [self.player play];

}

- (void)playSoundBatu {
    
    NSError *error = nil;
    //音楽ファイルのファイルパス(音楽ファイルがデータ上どこにあるか)を作成
    // 再生する audio ファイルのパスを取得
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"batu" ofType:@"mp3"];
    // パスから、再生するURLを作成する
    NSURL *url = [NSURL fileURLWithPath:path];
    // auido を再生するプレイヤーを作成する
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    // エラーが起きたとき
    if (error != nil) { //エラーがあった場合
        return;
    }
    [self.player play];
}




//「○」ボタンが押された場合
- (IBAction)answerIsTrue:(id)sender {
    //答えを確認
    if (answer == YES) {
    
         self.quiz.text = @"正解です";
        correctAnswers++;
        [self playSoundMaru];
        
    }else{
        
        self.quiz.text = @"不正解です";
        [self playSoundBatu];
        
    }

    //隠してあるNEXTボタンを表示させ、ボタンが押されたらnextProblemメソッドに飛ぶ
    //隠すのがYES
    self.nextButton.hidden = NO;

    //マルバツボタンは非表示
    self.answerIsFalse.hidden = YES;
    self.answerIsTrue.hidden = YES;

   
}

//「×」ボタンが押された場合
- (IBAction)answerIsFalse:(id)sender {
    //答えを確認
    if (answer == NO) {
    
    self.quiz.text = @"正解です";
    correctAnswers++;
    [self playSoundMaru];
        
    }else{
    
    self.quiz.text = @"不正解です";
    [self playSoundBatu];
    
    }
    
    //隠してあるNEXTボタンを表示させ、ボタンが押されたらnextProblemメソッドに飛ぶ
    self.nextButton.hidden = NO;
    
    //マルバツボタンは非表示
    self.answerIsFalse.hidden = YES;
    self.answerIsTrue.hidden = YES;


}

//次の問題提示 or 全問時終わっていたら結果表画面へ　IBActionにする　表示させたボタンを隠す
- (IBAction)nextProblem:(id)sender {
    

    currentProblem++;
    
    
    //これまで出題した問題が、提示問題数に達していない場合
    if (currentProblem <= totalProblems) {
        
    //nextButtonが押された時にマルバツボタンを表示
    self.answerIsFalse.hidden = NO;
    self.answerIsTrue.hidden = NO;
        
    //次の問題の問題文を提示

    [self loadProblemSet];

        
    //全問題解き終わった場合
    } else {
        
        
        //次の問題へ行くボタンを隠す
        self.nextButton.hidden = YES;
 
        //結果表示画面
        percentage = correctAnswers /(double)totalProblems*100;
       
        NSString *result =[NSString stringWithFormat:@"あなたの正答率は%ld％です。",percentage];
        self.quiz.text = result;
    }
}


//問題の読み込み
- (void)loadProblemSet {
    
    //次の問題へ行くボタンを隠す
    self.nextButton.hidden = YES;

    
    //文字列（*が必要）
    NSString *question = @"";
    
    
    switch (currentProblem) {
        case 1:
            question = @"M-1グランプリ2015で優勝したコンビはタイムマシーン３号である";
            answer = NO;
            break;
            
        case 2:
           question = @"キングオブコント2015で優勝したコンビはコロコロチキチキペッパーズである";
             answer = YES;
            break;
            
        case 3:
            question = @"THE MANZAI2011で棄権したコンビがいた";
             answer = YES;
            break;
            
        case 4:
            question = @"M-1グランプリ2005で吉本興業以外の事務所から出場したコンビは1組である";
            answer = NO;
            break;
            
        case 5:
            question = @"ハマカーンはFKD48のメンバーである";
            answer = NO;
            break;
    }

    self.quiz.text = question;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    

    //次の問題へ行くボタンを隠す
    self.nextButton.hidden = YES;

    
    //提示問題数を5問とする
    totalProblems = 5;
    
    //現在の問題番号と正答数を0にする
    currentProblem = 1;
    correctAnswers = 0;
    
    //クイズ問題を読み込み
    [self loadProblemSet];
    

}

@end
