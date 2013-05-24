//
//  giocoDollarViewController.h
//  Skifidollar
//
//  Created by Stardust on 24/05/13.
//  Copyright (c) 2013 Viviana Liuni. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dettaglioViewController.h"

@interface giocoDollarViewController : UIViewController<UITextFieldDelegate>{
    IBOutlet UILabel* N1;
    IBOutlet UILabel* N2;
    IBOutlet UILabel* N3;
    IBOutlet UIImageView* D1;
    IBOutlet UIImageView* D2;
    IBOutlet UIImageView* D3;
    IBOutlet UIButton *verifica;
    IBOutlet UITextField *soluzione;
    IBOutlet UIScrollView *scroll;
    NSMutableDictionary* startup;
    NSMutableArray *immagini;
    NSMutableArray *numeri;
    BOOL keyboardVisible;
}

@property(nonatomic,retain)IBOutlet UILabel* N1;
@property(nonatomic,retain)IBOutlet UILabel* N2;
@property(nonatomic,retain)IBOutlet UILabel* N3;
@property(nonatomic,retain)IBOutlet UIImageView* D1;
@property(nonatomic,retain)IBOutlet UIImageView* D2;
@property(nonatomic,retain)IBOutlet UIImageView* D3;
@property(nonatomic,retain)IBOutlet UIButton *verifica;
@property(nonatomic,retain)IBOutlet UITextField *soluzione;
@property(nonatomic,retain)IBOutlet UIScrollView *scroll;

- (void)shuffle:(NSMutableArray*)anArray;
-(void)nuovaPartita;
-(IBAction)daiSoluzione;
-(void)keyboardDidShow: (NSNotification*)notifica;
-(void)keyboardDidHide: (NSNotification*)notifica;
@end
