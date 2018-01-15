//
//  ImageModel.m
//  ThereIsEverything
//
//  Created by Sonia on 2017/11/15.
//  Copyright © 2017年 Mine. All rights reserved.
//

#import "ImageModel.h"

@interface ImageModel ()

@property (nonatomic, readwrite) CGFloat imageWidth;
@property (nonatomic, readwrite) CGFloat imageHeight;

@end


@implementation ImageModel

- (instancetype)initWithImageUrl:(NSString *)imageUrl imageContent:(NSString *)imageContent imageWidth:(CGFloat)imageWidth imageHeigh:(CGFloat)imageHeight
{
    self = [super init];
    if (self) {
        self.imageUrl = imageUrl;
        self.imageWidth = imageWidth;
        self.imageHeight = imageHeight;
        if (!imageContent) {
            self.imageContent = @"The aim of this event was to bring leading Chinese and global marathon medical officers and organizers to create a learning platform for race medicine and protocols, foster professional sports physicians network, and make proliferating race events safer in China.\nBeginning with Professor Lu Yi Ming’s (Chief Medical Officer at First Respond 第一反应®) welcome speech, Dr. Stuart Weiss (Chief Medical Director from New York City Marathon), Dr. Lars Brechtel (Chief Medical Director from Berlin Marathon) and Professor Hideharu Tanaka (Kokushikan University Graduate School EMS System), shared each country’s expertise on road race medical support and best practices.\nThe first Marathon Safety Summit was only a part of First Respond 第一反应®’s overall scheme to develop and offer the best safety solution for race events in this country.\nAccording to Chinese Athletic Association (CAA), State Council aims to increase sports industry to a value of 5 trillion yuan (equivalent to 800 billion US dollars) by the end of 2025. Fueled by this ambitious goal, a total of 134 marathons (equivalent to approximately 1.5 million runners) were held in 2015, which is ten times more than the number of marathons held in 2010. At the same time, the public’s concerns about safety issues in sports events emerged as 5 runners reported dead during races in 2015 alone.\nUnderstanding existing issues regarding marathon safety management system and amateur athletes’ low discern over own health conditions to complete 40-kilometer running challenge, First Respond第一反应® now serves as the leading in-race first aid service provider with the voluntary network, hardware, software, and telecommunication system combined. ";
        }
    }
    return self;
}

@end
