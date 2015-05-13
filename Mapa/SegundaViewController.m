//
//  SegundaViewController.m
//  Mapa
//
//  Created by Rodrigo DAngelo Silva Machado on 5/13/15.
//  Copyright (c) 2015 Rodrigo DAngelo Silva Machado. All rights reserved.
//

#import "SegundaViewController.h"

@interface SegundaViewController ()

@end

@implementation SegundaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.label1.hidden = YES;
    self.label2.hidden = YES;
    self.label3.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)filme1:(id)sender
{
    
    self.label1.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        self.label1.hidden = NO;
        self.label1.alpha = 1;
    } completion:^(BOOL finalizado) {
        [UIView animateWithDuration:1 delay:3 options:0 animations:^{
            self.label1.alpha = 0;
        } completion:^(BOOL finalizado) {
            self.label1.hidden = YES;
        }];
    }];
    
    
}

- (IBAction)filme2:(id)sender
{
    self.label2.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        self.label2.hidden = NO;
        self.label2.alpha = 1;
    } completion:^(BOOL finalizado) {
        [UIView animateWithDuration:1 delay:3 options:0 animations:^{
            self.label2.alpha = 0;
        } completion:^(BOOL finalizado) {
            self.label2.hidden = YES;
        }];
    }];
    
}

- (IBAction)filme3:(id)sender
{
    self.label3.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        self.label3.hidden = NO;
        self.label3.alpha = 1;
    } completion:^(BOOL finalizado) {
        [UIView animateWithDuration:1 delay:3 options:0 animations:^{
            self.label3.alpha = 0;
        } completion:^(BOOL finalizado) {
            self.label3.hidden = YES;
        }];
    }];
    
}
@end
