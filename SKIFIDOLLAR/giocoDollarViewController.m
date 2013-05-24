//
//  giocoDollarViewController.m
//  Skifidollar
//
//  Created by Stardust on 24/05/13.
//  Copyright (c) 2013 Viviana Liuni. All rights reserved.
//

#import "giocoDollarViewController.h"

@interface giocoDollarViewController ()

@end

@implementation giocoDollarViewController
@synthesize N1,N2,N3,D1,D2,D3,verifica,soluzione,scroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)shuffle:(NSMutableArray*)anArray
{
    
    NSMutableArray* numeriEstratti = [[NSMutableArray alloc] initWithCapacity:3];
    for (NSUInteger i = 0; i < 3; ++i) {
        NSNumber* ospitoInteger;
        do {
            int n = arc4random_uniform([[startup objectForKey:@"foto"] count]) ;
            
            ospitoInteger = [NSNumber numberWithInt:n];
            
        }
        while ([numeriEstratti containsObject:ospitoInteger]);
        [numeriEstratti addObject:ospitoInteger];
        [anArray addObject:[[startup objectForKey:@"foto"] objectAtIndex:[ospitoInteger intValue]]];
        
    }
    [numeriEstratti release];
    
    
    for (NSUInteger i = 0; i < anArray.count; ++i) {
        
        int nElements = anArray.count - i;
        
        int n = (arc4random() % nElements) + i;
        
        [anArray exchangeObjectAtIndex:i withObjectAtIndex:n];
        
    }
    
}

-(void)nuovaPartita{
    
    
    immagini=[[NSMutableArray alloc] initWithObjects: nil];
    numeri=[[NSMutableArray alloc] initWithObjects: nil];
    [self shuffle:immagini];
    
    NSMutableArray* numeriEstratti = [[NSMutableArray alloc] initWithCapacity:3];
    for (NSUInteger i = 0; i < 3; ++i) {
        NSNumber* ospitoInteger;
        do {
            int n = arc4random_uniform(9) ;
            
            ospitoInteger = [NSNumber numberWithInt:n];
            
        }
        while ([numeriEstratti containsObject:ospitoInteger]);
        [numeriEstratti addObject:ospitoInteger];
        [numeri addObject:ospitoInteger];
        
    }
    [numeriEstratti release];
    /*
    
    for (NSUInteger i = 0; i < numeri.count; ++i) {
        
        int nElements = numeri.count - i;
        
        int n = (arc4random() % nElements) + i;
        
        [numeri exchangeObjectAtIndex:i withObjectAtIndex:n];
        
    }*/
   soluzione.text=@"0";
    N1.text=[NSString stringWithFormat:@"%@",[numeri objectAtIndex:0]];
    N2.text=[NSString stringWithFormat:@"%@",[numeri objectAtIndex:1]];
    N3.text=[NSString stringWithFormat:@"%@",[numeri objectAtIndex:2]];
    
    D1.image=[UIImage imageNamed:[immagini objectAtIndex:0]];
    D2.image=[UIImage imageNamed:[immagini objectAtIndex:1]];
    D3.image=[UIImage imageNamed:[immagini objectAtIndex:2]];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

-(void)keyboardDidShow: (NSNotification*)notifica
{
	if (keyboardVisible) {
		return;
	}
	NSDictionary*gestnotifica=[notifica userInfo];
	NSValue* temp1=[gestnotifica objectForKey:UIKeyboardFrameBeginUserInfoKey];
	CGSize gradezzatastiera =[temp1 CGRectValue].size;
    
        CGRect frame1= self.view.frame;
        frame1.size.height-= gradezzatastiera.height-50;
        scroll.frame=frame1;
    
	keyboardVisible=YES;
}
-(void)keyboardDidHide: (NSNotification*)notifica
{
	if (!keyboardVisible) {
		return;
	}
	
        scroll.frame=self.view.frame;
    
	keyboardVisible=NO;
}


-(IBAction)daiSoluzione{
    
    double risultato=0;
    risultato=[N1.text doubleValue]*[[NSString stringWithFormat:@"%@",[[immagini objectAtIndex:0] stringByReplacingOccurrencesOfString:@".jpg" withString:@""]]doubleValue]+[N2.text doubleValue]*[[NSString stringWithFormat:@"%@",[[immagini objectAtIndex:1] stringByReplacingOccurrencesOfString:@".jpg" withString:@""]]doubleValue]+[N3.text doubleValue]*[[NSString stringWithFormat:@"%@",[[immagini objectAtIndex:2] stringByReplacingOccurrencesOfString:@".jpg" withString:@""]]doubleValue];
    NSLog(@"%f,%f",risultato,[soluzione.text doubleValue]);
    
    dettaglioViewController *detailView=[self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    //dettaglioViewController *detailView=[[[dettaglioViewController alloc]init]autorelease];
    //[detailView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    if (risultato==[soluzione.text doubleValue]) {
        [detailView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [self presentModalViewController:detailView animated:YES];
        detailView.titolo.text=@"";
        [detailView.logo setImage:[UIImage imageNamed:@"MessaggioOK.png"]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            
            [self nuovaPartita];
        });
               
        
        
    }else{
        [detailView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [self presentModalViewController:detailView animated:YES];
        detailView.titolo.text=@"";
        [detailView.logo setImage:[UIImage imageNamed:@"MessaggioKO.png"]];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *strFilePath = [ [NSBundle mainBundle] pathForResource:@"dollars" ofType:@"plist" ] ;
    startup= [[NSMutableDictionary alloc] initWithContentsOfFile:strFilePath];
    [self nuovaPartita];
    scroll.frame=self.view.frame;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
	keyboardVisible=NO;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [super dealloc];
    [N1 release];
    [N2 release];
    [N3 release];
    [D1 release];
    [D2 release];
    [D3 release];
    [soluzione release];
    [verifica release];
    [scroll release];
}
@end
