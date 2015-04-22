//
//  LoginViewController.m
//  Obras-Programas
//
//  Created by Pedro Contreras on 06/04/15.
//  Copyright (c) 2015 Edicomex. All rights reserved.
//

#import "LoginViewController.h"
#import "AFOAuth2Manager.h"
#import "Constants.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usuarioTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property AFOAuth2Manager *OAuth2Manager;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *baseURL = [NSURL URLWithString:kAppURL];
    self.OAuth2Manager =
    [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
                                    clientID:kClientID
                                    secret:kClientSecret];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)loginPressed:(id)sender {
    
    
    self.OAuth2Manager.useHTTPBasicAuthentication = NO;
    
    
    [self.OAuth2Manager authenticateUsingOAuthWithURLString:@"/o/token/"
                                                   username:[_usuarioTextField text]
                                                   password:[_passwordTextField text]
                                                    scope:@"read write"
                                                    success:^(AFOAuthCredential *credential) {
                                                        NSLog(@"Token: %@", credential.accessToken);
                                                        [AFOAuthCredential storeCredential:credential
                                                                            withIdentifier:kStoreCredentialIdentifier];
                                                        [self performSegueWithIdentifier:@"showViews" sender:sender];
                                                        
                                                    }
                                                    failure:^(NSError *error) {
                                                        NSLog(@"Error: %@", error);
                                                        [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                                    message:@"Los datos de Login Son Incorrectos"
                                                                                   delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                                                    }];
    
    
}

@end
