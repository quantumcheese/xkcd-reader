//
//  QCViewController.m
//  Xkcd Reader
//
//  Created by Richard Brown on 12/17/12.
//  Copyright (c) 2012 Quantumcheese Coding, LLC. All rights reserved.
//

#import "QCViewController.h"

@implementation QCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self goToLast:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)goToFirst:(id)sender
{
    [self parsePageAtURL:[NSURL URLWithString:@"http://xkcd.com/1/"]];
    previous = @"1";
}

- (IBAction)goToPrevious:(id)sender
{
    [self parsePageAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://xkcd.com/%@", previous]]];
}

- (IBAction)goToRandom:(id)sender
{
    [self parsePageAtURL:[NSURL URLWithString:@"http://dynamic.xkcd.com/random/comic/"]];
}

- (IBAction)goToNext:(id)sender
{
    [self parsePageAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://xkcd.com/%@", next]]];
}

- (IBAction)goToLast:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://xkcd.com/"];
    [self parsePageAtURL:url];
}

- (void)parsePageAtURL:(NSURL *)url
{
    // 1. grab the webpage at `url'
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    BOOL parsed = [parser parse];
    if (!parsed)
    {
        // display a UIAlert indicating failure
        [[[UIAlertView alloc] initWithTitle:@"Parse error"
                                    message:@"We were unable to load xkcd; please check your Internet connection and try again later."
                                   delegate:nil cancelButtonTitle:@"OK"
                          otherButtonTitles:nil]
         show];
    }
}

// MARK: -
// MARK: NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"a"])
    {
        // 2. parse out the previous and next urls; store them
        NSString *rel = [attributeDict valueForKey:@"rel"];
        if ([rel isEqualToString:@"prev"])
        {
            previous = [attributeDict valueForKey:@"href"];
        }
        else if ([rel isEqualToString:@"next"])
        {
            next = [attributeDict valueForKey:@"href"];
        }
    }
    else if (insideComicDiv && [elementName isEqualToString:@"img"])
    {
        // 3. parse out the URI for the comic's image; download it and render it in the comicView
        NSString *src = [attributeDict valueForKey:@"src"];
        NSURL *url = [NSURL URLWithString:src];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        [comicView setImage:[UIImage imageWithData:imageData]];

        // 4. parse out the comic's alt-text and display it in altText
        [altText setText:[attributeDict valueForKey:@"alt"]];

        insideComicDiv = NO;
    }
    else if ([elementName isEqualToString:@"div"]
             && [@"comic" isEqualToString:[attributeDict valueForKey:@"id"]])
    {
        insideComicDiv = YES;
    }
}

@end
