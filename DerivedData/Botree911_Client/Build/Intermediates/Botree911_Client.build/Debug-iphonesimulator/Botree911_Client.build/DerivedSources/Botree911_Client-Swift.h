// Generated by Apple Swift version 3.0.1 (swiftlang-800.0.58.6 clang-800.0.42.1)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
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
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
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
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import ObjectiveC;
@import Foundation;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC16Botree911_Client22AbstractViewController")
@interface AbstractViewController : UIViewController
- (void)viewDidLoad;
- (void)dismissIndicator;
- (void)hideNavigationController;
- (void)showNavigationController;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIWindow;
@class UIApplication;

SWIFT_CLASS("_TtC16Botree911_Client11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UINavigationController;

SWIFT_CLASS("_TtC16Botree911_Client9AppRouter")
@interface AppRouter : NSObject
@property (nonatomic, strong) UIWindow * _Nullable appWindow;
@property (nonatomic, strong) UIViewController * _Nullable container;
@property (nonatomic, strong) UINavigationController * _Nullable subContainerInTabbar;
+ (AppRouter * _Nonnull)sharedRouter;
- (void)segueInitiatedForViewController:(AbstractViewController * _Nonnull)viewController;
- (AbstractViewController * _Nonnull)getViewController:(NSString * _Nonnull)screenName;
- (UINavigationController * _Nonnull)getNavigationController;
- (void)showProjectScreen;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class TextFieldValidator;
@class UIButton;

SWIFT_CLASS("_TtC16Botree911_Client19LoginViewController")
@interface LoginViewController : AbstractViewController
@property (nonatomic, readonly, copy) NSDictionary<NSString *, id> * _Nonnull testResponse;
@property (nonatomic, strong) IBOutlet TextFieldValidator * _Null_unspecified txtUserEmail;
@property (nonatomic, strong) IBOutlet TextFieldValidator * _Null_unspecified txtPassword;
@property (nonatomic, strong) IBOutlet UIButton * _Null_unspecified btnLogin;
- (void)viewDidLoad;
- (IBAction)btnLoginOnclick:(id _Nonnull)sender;
- (void)configValidation;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITextField;
@class UITouch;
@class UIEvent;

@interface LoginViewController (SWIFT_EXTENSION(Botree911_Client)) <UITextFieldDelegate>
- (void)textFeildReturnUIConfig;
- (BOOL)textFieldShouldReturn:(UITextField * _Nonnull)textField;
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
@end


@interface LoginViewController (SWIFT_EXTENSION(Botree911_Client))
- (void)login;
- (void)userAuthorized;
@end

@class UILabel;

SWIFT_CLASS("_TtC16Botree911_Client15ProjectListCell")
@interface ProjectListCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel * _Null_unspecified lblProjectTitle;
@property (nonatomic, strong) IBOutlet UILabel * _Null_unspecified lblProjectDescription;
@property (nonatomic, strong) IBOutlet UILabel * _Null_unspecified lblTeamMember;
- (void)setProjectListData;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITableView;
@class UIStoryboardSegue;

SWIFT_CLASS("_TtC16Botree911_Client25ProjectListViewController")
@interface ProjectListViewController : AbstractViewController
@property (nonatomic, copy) NSIndexPath * _Nonnull selectProjectIndexPath;
@property (nonatomic, strong) IBOutlet UITableView * _Null_unspecified tblProjectList;
- (void)viewDidLoad;
- (void)getProjectList;
- (void)prepareForSegue:(UIStoryboardSegue * _Nonnull)segue sender:(id _Nullable)sender;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface ProjectListViewController (SWIFT_EXTENSION(Botree911_Client)) <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (CGFloat)tableView:(UITableView * _Nonnull)tableView heightForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end


SWIFT_CLASS("_TtC16Botree911_Client11ThemeButton")
@interface ThemeButton : UIButton
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame SWIFT_UNAVAILABLE;
@end

@class NSAttributedString;
@class UIFont;
@class UIColor;

SWIFT_CLASS("_TtC16Botree911_Client14ThemeTextField")
@interface ThemeTextField : UITextField
@property (nonatomic, readonly) double animationDuration;
@property (nonatomic, strong) UILabel * _Nonnull title;
@property (nonatomic, copy) NSString * _Nullable accessibilityLabel;
@property (nonatomic, copy) NSString * _Nullable placeholder;
@property (nonatomic, strong) NSAttributedString * _Nullable attributedPlaceholder;
@property (nonatomic, strong) UIFont * _Nonnull titleFont;
@property (nonatomic) CGFloat hintYPadding;
@property (nonatomic) CGFloat titleYPadding;
@property (nonatomic, strong) UIColor * _Nonnull titleTextColour;
@property (nonatomic, strong) UIColor * _Null_unspecified titleActiveTextColour;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (void)layoutSubviews;
- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;
- (CGRect)clearButtonRectForBounds:(CGRect)bounds;
@end


SWIFT_CLASS("_TtC16Botree911_Client14TicketListCell")
@interface TicketListCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel * _Null_unspecified lblTicketTitle;
@property (nonatomic, strong) IBOutlet UILabel * _Null_unspecified lblTicketDescription;
@property (nonatomic, strong) IBOutlet UILabel * _Null_unspecified lblTicketStatus;
- (void)setProjectListData;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC16Botree911_Client24TicketListViewController")
@interface TicketListViewController : AbstractViewController
@property (nonatomic, strong) IBOutlet UITableView * _Null_unspecified tblTicketList;
- (void)viewDidLoad;
- (void)getTicketList;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface TicketListViewController (SWIFT_EXTENSION(Botree911_Client)) <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (CGFloat)tableView:(UITableView * _Nonnull)tableView heightForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end


SWIFT_CLASS("_TtC16Botree911_Client4User")
@interface User : NSCoder
@property (nonatomic, copy) NSString * _Nullable firstName;
@property (nonatomic, copy) NSString * _Nullable lastName;
@property (nonatomic, copy) NSString * _Nullable email;
@property (nonatomic, copy) NSString * _Nullable accessToken;
- (nonnull instancetype)initWithCoder:(NSCoder * _Null_unspecified)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)encodeWithCoderWithACoder:(NSCoder * _Null_unspecified)aCoder;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC16Botree911_Client18UserDefaultStorage")
@interface UserDefaultStorage : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) UserDefaultStorage * _Nonnull sharedStorage;)
+ (UserDefaultStorage * _Nonnull)sharedStorage;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
- (BOOL)savePairWithKey:(NSString * _Nonnull)key data:(id _Nonnull)data;
- (id _Nullable)loadWithKey:(NSString * _Nonnull)key;
- (BOOL)removeWithKey:(NSString * _Nonnull)key;
- (BOOL)clear;
@end

#pragma clang diagnostic pop