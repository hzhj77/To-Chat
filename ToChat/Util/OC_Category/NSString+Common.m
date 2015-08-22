//
//  NSString+Common.m
//  Step-it-up
//
//  Created by syfll on 7/28/15.
//  Copyright © 2015 JFT0M. All rights reserved.
//

#import "NSString+Common.h"

#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Common)
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        /** 
         Calculates and returns the bounding rect for the receiver drawn using the given options and display characteristics, within the specified rectangle in the current graphics context.
         // 在现在的graphics context 中用一个规定的 rectangle，并根据给定的选项和想要展示的文字，计算然后返回 bounding rect 让receiver能够去画
         
        To correctly draw and size multi-line text, pass NSStringDrawingUsesLineFragmentOrigin in the options parameter.
         // 想要正确地画并且规定一个多行文本的大小，请使用NSStringDrawingUsesLineFragmentOrigin作为参数
         
        This method returns fractional sizes (in the size component of the returned CGRect); to use a returned size to size views, you must raise its value to the nearest higher integer using the ceil function.
         //返回值CGRect的Size含有小数点，如果使用函数返回值CGRect的Size来定义View大小，必需使用“ceil”函数获取长宽（ceil：大于当前值的最小正数）。
         
        This method returns the actual bounds of the glyphs in the string. Some of the glyphs (spaces, for example) are allowed to overlap the layout constraints specified by the size passed in, so in some cases the width value of the size component of the returned CGRect can exceed the width value of the size parameter.
         */
        
        //下面这段文字来源http://www.it165.net/pro/html/201508/48923.html
//    boundingRectWithSize: 方法只是取得字符串的size, 如果字符串中包含\n\r这样的字符，也只会把它当成字符来计算。但放到UITextView中来解析时，会把它变成回车换行符，那么在显示时就会多出一行的高度出来。
//        
//        而且，使用stringWithFormat才会忽略 ，使用@“”形式不会。
//        
//        矬点的做法，大体的实际高度 = boundingRectWithSize计算出来的高度 + \n\r出现的次数 * 单行文本的高度
        resultSize = [self boundingRectWithSize:size
                                        options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                     attributes:@{NSFontAttributeName: font}
                                        context:nil].size;
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        //        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
        //
        //        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //        [paragraphStyle setLineSpacing:2.0];
        //
        //        [attributedStr addAttribute:NSParagraphStyleAttributeName
        //                              value:paragraphStyle
        //                              range:NSMakeRange(0, [self length])];
        //        resultSize = [attributedStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
#endif
    }
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    //    if ([self containsEmoji]) {
    //        resultSize.height += 10;
    //    }
    return resultSize;
}
- (NSString *)trimWhitespace
{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}
- (NSURL *)urlImageWithCodePathResize:(CGFloat)width{
    return [self urlImageWithCodePathResize:width crop:NO];
}
- (NSURL *)urlImageWithCodePathResize:(CGFloat)width crop:(BOOL)needCrop{
    NSString *urlStr;
    BOOL canCrop = NO;
    if (!self || self.length <= 0) {
        return nil;
    }else{
        if (![self hasPrefix:@"http"]) {
            NSString *imageName = [self stringByMatching:@"/static/fruit_avatar/([a-zA-Z0-9\\-._]+)$" capture:1];
            if (imageName && imageName.length > 0) {
                urlStr = [NSString stringWithFormat:@"http://coding-net-avatar.qiniudn.com/%@?imageMogr2/auto-orient/thumbnail/!%.0fx%.0fr", imageName, width, width];
                canCrop = YES;
            }else{
                urlStr = [NSString stringWithFormat:@"%@%@", kNetPath_Code_Base, self];
            }
        }else{
            urlStr = self;
            if ([urlStr rangeOfString:@"qbox.me"].location != NSNotFound) {
                if ([urlStr rangeOfString:@".gif"].location != NSNotFound) {
                    if ([urlStr rangeOfString:@"?"].location != NSNotFound) {
                        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"/thumbnail/!%.0fx%.0fr/format/png", width, width]];
                    }else{
                        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?imageMogr2/auto-orient/thumbnail/!%.0fx%.0fr/format/png", width, width]];
                    }
                }else{
                    if ([urlStr rangeOfString:@"?"].location != NSNotFound) {
                        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"/thumbnail/!%.0fx%.0fr", width, width]];
                    }else{
                        urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"?imageMogr2/auto-orient/thumbnail/!%.0fx%.0fr", width, width]];
                    }
                }
                canCrop = YES;
            }else if ([urlStr rangeOfString:@"www.gravatar.com"].location != NSNotFound){
                urlStr = [urlStr stringByReplacingOccurrencesOfString:@"s=[0-9]*" withString:[NSString stringWithFormat:@"s=%.0f", width] options:NSRegularExpressionSearch range:NSMakeRange(0, [urlStr length])];
            }else if ([urlStr hasSuffix:@"/imagePreview"]){
                urlStr = [urlStr stringByAppendingFormat:@"?width=%.0f", width];
            }
        }
        if (needCrop && canCrop) {
            urlStr = [urlStr stringByAppendingFormat:@"/gravity/Center/crop/%.0fx%.0f", width, width];
        }
        return [NSURL URLWithString:urlStr];
    }
}

- (NSString*) sha1Str
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSRange)rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet{
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (location = 0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return NSMakeRange(location, length - location);
}
- (NSRange)rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet{
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (length = [self length]; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    return NSMakeRange(location, length - location);
}
- (NSURL *)urlImageWithCodePathResizeToView:(UIView *)view{
    return [self urlImageWithCodePathResize:2*CGRectGetWidth(view.frame)];
}
- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    return [self substringWithRange:[self rangeByTrimmingLeftCharactersInSet:characterSet]];
}

- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    return [self substringWithRange:[self rangeByTrimmingRightCharactersInSet:characterSet]];
}


- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}



- (BOOL)isEmpty
{
    return [[self trimWhitespace] isEqualToString:@""];
}

//是否包含语音解析的图标
- (BOOL)hasListenChar{
    BOOL hasListenChar = NO;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (length = [self length]; length > 0; length--) {
        if (charBuffer[length -1] == 65532) {//'\U0000fffc'
            hasListenChar = YES;
            break;
        }
    }
    return hasListenChar;
}



//转换拼音
- (NSString *)transformToPinyin {
    if (self.length <= 0) {
        return self;
    }
    NSString *tempString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)tempString, NULL, kCFStringTransformToLatin, false);
    tempString = (NSMutableString *)[tempString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [tempString uppercaseString];
}

#pragma mark emotion_monkey
+ (NSDictionary *)emotion_monkey_dict {
    static NSDictionary *_emotion_monkey_dict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _emotion_monkey_dict = @{
                                 @"coding_emoji_01": @"哈哈",
                                 @"coding_emoji_02": @"吐",
                                 @"coding_emoji_03": @"压力山大",
                                 @"coding_emoji_04": @"忧伤",
                                 @"coding_emoji_05": @"坏人",
                                 @"coding_emoji_06": @"酷",
                                 @"coding_emoji_07": @"哼",
                                 @"coding_emoji_08": @"你咬我啊",
                                 @"coding_emoji_09": @"内急",
                                 @"coding_emoji_10": @"32个赞",
                                 @"coding_emoji_11": @"加油",
                                 @"coding_emoji_12": @"闭嘴",
                                 @"coding_emoji_13": @"wow",
                                 @"coding_emoji_14": @"泪流成河",
                                 @"coding_emoji_15": @"NO!",
                                 @"coding_emoji_16": @"疑问",
                                 @"coding_emoji_17": @"耶",
                                 @"coding_emoji_18": @"生日快乐",
                                 @"coding_emoji_19": @"求包养",
                                 @"coding_emoji_20": @"吹泡泡",
                                 @"coding_emoji_21": @"睡觉",
                                 @"coding_emoji_22": @"惊讶",
                                 @"coding_emoji_23": @"Hi",
                                 @"coding_emoji_24": @"打发点咯",
                                 @"coding_emoji_25": @"呵呵",
                                 @"coding_emoji_26": @"喷血",
                                 @"coding_emoji_27": @"Bug",
                                 @"coding_emoji_28": @"听音乐",
                                 @"coding_emoji_29": @"垒码",
                                 @"coding_emoji_30": @"我打你哦",
                                 @"coding_emoji_31": @"顶足球",
                                 @"coding_emoji_32": @"放毒气",
                                 @"coding_emoji_33": @"表白",
                                 @"coding_emoji_34": @"抓瓢虫",
                                 @"coding_emoji_35": @"下班",
                                 @"coding_emoji_36": @"冒泡",
                                 @"coding_emoji_38": @"2015",
                                 @"coding_emoji_39": @"拜年",
                                 @"coding_emoji_40": @"发红包",
                                 @"coding_emoji_41": @"放鞭炮",
                                 @"coding_emoji_42": @"求红包",
                                 @"coding_emoji_43": @"新年快乐"
                                 };
    });
    return _emotion_monkey_dict;
}
- (NSString *)emotionMonkeyName{
    return [NSString emotion_monkey_dict][self];
}

@end
