//
//  ViewController.m
//  BlocksExamples
//
//  Created by Ersun Alkan on 25/02/14.
//  Copyright (c) 2014 Ersun Alkan. All rights reserved.
//

#import "ViewController.h"

typedef void (^simpleBlock)();
typedef int (^addParameters)(int num1,int num2);
typedef void  (^useLocalVar)();

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTest;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    [self testBlocks];
}


-(void)testBlocks
{
    NSLog(@"enter");
    
    // simple Block
    simpleBlock test=^(void)
    {
        NSLog(@"test");
    };
    test();
    
    // with parameters
    addParameters add= ^(int number1, int number2)
    {
        return number1+number2;
    };
    NSLog(@" with parameters %d",add(4,3));
    
    
    // use local variable
    __block NSNumber *number=@30;
    useLocalVar use=^(void)
    {
        NSLog(@" use local variable %@",number);
        number=@0;
        
    };
    use();
    
    
    //use method as a parameter
    [self setBlock:^int(int num1, int num2) {
        NSLog(@"%@",@2);
        NSLog(@"use method as a parameter %d",(num1+num2)*[number integerValue]);
        return num1+num1;
    }];
    
    
    // use weak self
    __weak ViewController* weakSelf=self;
   void(^getScreenSize)() = ^(ViewController* weak) {
       NSLog(@"use weak self - label height: %f",[weak.lblTest bounds].size.height);
       
};
    getScreenSize(weakSelf);
    
}
- (IBAction)act10:(id)sender {
    self.lblTest.text=@"10";
    
}
- (IBAction)act11:(id)sender {
    self.lblTest.text=@"11";
}

-(void)setBlock: (addParameters) block
{
    NSLog(@"%@",@1);
    block(4,7);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
