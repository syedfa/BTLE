// Generated by Apple Swift version 1.2 (swiftlang-602.0.49.6 clang-602.0.49)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
#if __has_feature(nullability)
#  define SWIFT_NULLABILITY(X) X
#else
# if !defined(__nonnull)
#  define __nonnull
# endif
# if !defined(__nullable)
#  define __nullable
# endif
# if !defined(__null_unspecified)
#  define __null_unspecified
# endif
#  define SWIFT_NULLABILITY(X)
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import Foundation;
@import CoreData;
@import ObjectiveC;
@import AVFoundation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIEvent;
@class NSCoder;

SWIFT_CLASS("_TtC8SA_Swift22FullScreenBlockingView")
@interface FullScreenBlockingView : UIView
@property (nonatomic, copy) void (^ __nullable dismissClosure)(void);
+ (FullScreenBlockingView * __nonnull)blockerForViews:(NSArray * __nonnull)targets closure:(void (^ __nullable)(void))closure;
- (UIView * __nullable)hitTest:(CGPoint)point withEvent:(UIEvent * __nullable)event;
- (void)dismiss;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface NSData (SWIFT_EXTENSION(SA_Swift))
@property (nonatomic, readonly, copy) NSString * __nonnull hexString;
@end


@interface NSDate (SWIFT_EXTENSION(SA_Swift))
@end


@interface NSDate (SWIFT_EXTENSION(SA_Swift))
+ (NSString * __nonnull)ageString:(NSTimeInterval)age style:(NSDateFormatterStyle)style;
@end


@interface NSDate (SWIFT_EXTENSION(SA_Swift))
- (NSString * __nonnull)localTimeStringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;
@property (nonatomic, readonly) BOOL isToday;
@property (nonatomic, readonly) BOOL isTomorrow;
@property (nonatomic, readonly) BOOL isYesterday;
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSDate * __nonnull nextDay;
@property (nonatomic, readonly) NSDate * __nonnull previousDay;
@property (nonatomic, readonly) NSDate * __nonnull firstSecond;
@property (nonatomic, readonly) NSDate * __nonnull lastSecond;
@property (nonatomic, readonly) NSDate * __nonnull noon;
- (BOOL)isAfter:(NSDate * __nonnull)date;
- (BOOL)isBefore:(NSDate * __nonnull)date;
- (BOOL)isSameDayAs:(NSDate * __nonnull)other;
@end

@class NSURL;

@interface NSFileManager (SWIFT_EXTENSION(SA_Swift))
- (BOOL)fileExistsAtURL:(NSURL * __nonnull)url;
- (BOOL)directoryExistsAtURL:(NSURL * __nonnull)url;
@end

@class NSManagedObjectContext;

@interface NSManagedObject (SWIFT_EXTENSION(SA_Swift))
- (id __nullable)objectForKeyedSubscript:(NSString * __nonnull)key;
- (void)setObject:(id __nullable)newValue forKeyedSubscript:(NSString * __nonnull)key;
@property (nonatomic, readonly) NSManagedObjectContext * __nullable moc;
- (void)log;
@end

@class NSFetchRequest;
@class NSPredicate;
@class NSSortDescriptor;

@interface NSManagedObjectContext (SWIFT_EXTENSION(SA_Swift))
- (NSManagedObject * __nonnull)insertEntityNamed:(NSString * __nonnull)name;
- (BOOL)save;
- (void)saveToDisk;
- (NSFetchRequest * __nonnull)fetchRequest:(NSString * __nonnull)name;
- (NSArray * __nonnull)allRecords:(NSString * __nonnull)name predicate:(NSPredicate * __nullable)predicate;
- (NSManagedObject * __nullable)anyRecord:(NSString * __nonnull)name predicate:(NSPredicate * __nullable)predicate sortBy:(NSArray * __nonnull)sortBy;
@end

@class NSDictionary;

@interface NSNotification (SWIFT_EXTENSION(SA_Swift))
+ (void)postNotification:(NSString * __nonnull)name object:(id __nullable)object userInfo:(NSDictionary * __nullable)userInfo;
+ (void)postNotificationOnMainThread:(NSString * __nonnull)name object:(id __nullable)object userInfo:(NSDictionary * __nullable)userInfo;
@end


@interface NSObject (SWIFT_EXTENSION(SA_Swift))
- (void)addAsObserver:(NSString * __nonnull)name selector:(NSString * __nonnull)selector object:(id __nullable)object;
- (void)removeAsObserver;
@end


@interface NSOperationQueue (SWIFT_EXTENSION(SA_Swift))
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithSerial:(BOOL)serial;
@end


@interface NSProgress (SWIFT_EXTENSION(SA_Swift))
@property (nonatomic) BOOL isDisplayedProgress;
@end


@interface NSUserDefaults (SWIFT_EXTENSION(SA_Swift))
+ (id __nullable)keyedObject:(NSString * __nonnull)key;
+ (NSString * __nullable)keyedString:(NSString * __nonnull)key;
+ (NSData * __nullable)keyedData:(NSString * __nonnull)key;
+ (void)setKeyedInt:(NSInteger)value forKey:(NSString * __nonnull)key;
+ (void)setKeyedDouble:(double)value forKey:(NSString * __nonnull)key;
+ (void)setKeyedFloat:(float)value forKey:(NSString * __nonnull)key;
+ (void)setKeyedBool:(BOOL)value forKey:(NSString * __nonnull)key;
+ (void)setKeyedObject:(id __nonnull)object forKey:(NSString * __nonnull)key;
+ (void)setKeyedString:(NSString * __nonnull)string forKey:(NSString * __nonnull)key;
+ (void)setKeyedData:(NSData * __nonnull)data forKey:(NSString * __nonnull)key;
@end


SWIFT_PROTOCOL("_TtP8SA_Swift19ProgressDisplayable_")
@protocol ProgressDisplayable
@property (nonatomic) double fractionCompleted;
@property (nonatomic) BOOL indeterminate;
- (void)progressDisplayBegan;
- (void)progressDisplayCompleted;
@end

@protocol ProgressDisplayableView;
@class UILabel;
@class UIButton;
@class UIColor;

SWIFT_CLASS("_TtC8SA_Swift15ProgressDisplay")
@interface ProgressDisplay : UIView <ProgressDisplayable>
@property (nonatomic, copy) NSString * __nonnull title;
@property (nonatomic, copy) NSString * __nonnull detailText;
@property (nonatomic) id <ProgressDisplayableView> __nullable determinateView;
@property (nonatomic) id <ProgressDisplayableView> __nullable indeterminateView;
@property (nonatomic) UILabel * __null_unspecified titleLabel;
@property (nonatomic) UILabel * __null_unspecified detailLabel;
@property (nonatomic) UIButton * __nullable button;
@property (nonatomic) UIColor * __nonnull textColor;
@property (nonatomic) BOOL closeWhenComplete;
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@property (nonatomic) double fractionCompleted;
@property (nonatomic) BOOL indeterminate;
- (ProgressDisplay * __nonnull)closeWithAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
- (void)progressDisplayBegan;
- (void)progressDisplayCompleted;
- (ProgressDisplay * __nonnull)showWithAnimated:(BOOL)animated;
- (ProgressDisplay * __nonnull)hideWithAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
- (void)layoutSubviews;
@end



SWIFT_PROTOCOL("_TtP8SA_Swift23ProgressDisplayableView_")
@protocol ProgressDisplayableView
@property (nonatomic) double fractionCompleted;
@property (nonatomic, readonly) UIView * __nonnull view;
@property (nonatomic, readonly) BOOL isIndeterminateDisplay;
@end


SWIFT_CLASS("_TtC8SA_Swift8SA_Sound")
@interface SA_Sound : NSObject
- (SWIFT_NULLABILITY(nullable) instancetype)initWithUrl:(NSURL * __nullable)url preload:(BOOL)preload OBJC_DESIGNATED_INITIALIZER;
- (void)play;
- (void)pause;
@property (nonatomic, readonly) BOOL isPlaying;
@end

@class AVAudioPlayer;

SWIFT_CLASS("_TtC8SA_Swift11SoundPlayer")
@interface SoundPlayer : NSObject <AVAudioPlayerDelegate>
- (SWIFT_NULLABILITY(nonnull) instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer * __null_unspecified)player successfully:(BOOL)flag;
@end


@interface UIActivityIndicatorView (SWIFT_EXTENSION(SA_Swift)) <ProgressDisplayableView>
@property (nonatomic) double fractionCompleted;
@property (nonatomic, readonly) UIView * __nonnull view;
@property (nonatomic, readonly) BOOL isIndeterminateDisplay;
+ (UIActivityIndicatorView * __nonnull)progressDisplay;
@end

@class NSError;

@interface UIAlertController (SWIFT_EXTENSION(SA_Swift))
+ (UIAlertController * __nonnull)showAlert:(NSError * __nonnull)error title:(NSString * __nullable)title;
+ (UIAlertController * __nonnull)showAlertWithTitle:(NSString * __nullable)title message:(NSString * __nullable)message buttons:(NSArray * __nonnull)buttons block:(void (^ __nonnull)(NSInteger))block;
+ (void)showNextPendingController;
- (void)present;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)cancelWithAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
+ (NSInteger)numberOfPendingAlerts;
@end

@class NSAttributedString;

@interface UIBezierPath (SWIFT_EXTENSION(SA_Swift))
- (void)appendString:(NSAttributedString * __nonnull)string atPoint:(CGPoint)pt withTransform:(CGAffineTransform)withTransform;
@end


@interface UIColor (SWIFT_EXTENSION(SA_Swift))
- (SWIFT_NULLABILITY(nonnull) instancetype)initWithHex:(NSString * __nonnull)hex;
@end


@interface UIDevice (SWIFT_EXTENSION(SA_Swift))
@property (nonatomic, readonly) BOOL isIPad;
@end


@interface UIFont (SWIFT_EXTENSION(SA_Swift))
- (CGSize)sizeOfString:(NSString * __nonnull)string constrainedToWidth:(CGFloat)width;
@end


@interface UIImage (SWIFT_EXTENSION(SA_Swift))
- (UIImage * __nonnull)tintedImage:(UIColor * __nonnull)tint;
- (UIImage * __nonnull)resizedImage:(CGSize)size trimmed:(BOOL)trimmed;
@end


@interface UILabel (SWIFT_EXTENSION(SA_Swift))
@property (nonatomic, readonly) UIFont * __nonnull actualFontInUse;
@end


@interface UIProgressView (SWIFT_EXTENSION(SA_Swift)) <ProgressDisplayableView>
@property (nonatomic) double fractionCompleted;
@property (nonatomic, readonly) UIView * __nonnull view;
@property (nonatomic, readonly) BOOL isIndeterminateDisplay;
+ (UIProgressView * __nonnull)progressDisplay;
@end


@interface UITextField (SWIFT_EXTENSION(SA_Swift))
@end

@class UIViewController;
@class UITableViewCell;

@interface UIView (SWIFT_EXTENSION(SA_Swift))
@property (nonatomic, readonly) CGPoint contentCenter;
- (void)resignFirstResponderForAllSubviews;
- (UIView * __nonnull)blockingViewWithTappedClosure:(void (^ __nullable)(void))closure;
@property (nonatomic, readonly) UIViewController * __nullable viewController;
@property (nonatomic, readonly) UITableViewCell * __nullable tableViewCell;
- (NSString * __nonnull)hierarchyWithPrefix:(NSString * __nullable)prefix;
- (BOOL)isAncestor:(UIView * __nullable)view;
@end


@interface UIViewController (SWIFT_EXTENSION(SA_Swift)) <UITextFieldDelegate>
@end

@class UINavigationController;

@interface UIViewController (SWIFT_EXTENSION(SA_Swift))
+ (UIViewController * __nonnull)controller;
- (UINavigationController * __nonnull)navigationWrappedControllerWithHideNavigationBar:(BOOL)hideNavigationBar;
+ (UIViewController * __nullable)frontmostController;
- (void)setTabOrder:(NSArray * __nonnull)order withEndOfOrderClosure:(void (^ __nullable)(UIViewController * __nonnull))closure;
@property (nonatomic, readonly, copy) NSArray * __nonnull tabOrder;
- (BOOL)textFieldShouldReturn:(UITextField * __nonnull)textField;
- (BOOL)textField:(UITextField * __nonnull)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString * __nonnull)string;
@end


@interface UIWindow (SWIFT_EXTENSION(SA_Swift))
+ (UIWindow * __nullable)rootWindow;
@end

#pragma clang diagnostic pop
