//
//  BjcaInterfaceView.h
//  bjcaHandwriteLib
//
//  Created by miaofan on 14-1-21.
//
//

#import <UIKit/UIKit.h>


@protocol OnSignListenerDelegate <NSObject>

- (void)onConfirm;
- (void)onCancel;
- (void)onDismiss;

@end

@interface BjcaInterfaceView : NSObject

@property (nonatomic, assign) id<OnSignListenerDelegate> delegate;

typedef NS_ENUM(NSInteger, BioType) {
    photo_signer_card_front,
    photo_signer_card_back,
};

typedef NS_ENUM(NSInteger, EvidenceBioType) {
    /** 签名人居民身份证正面 **/
    PHOTO_SIGNER_IDENTITY_CARD_FRONT,
    /** 签名人居民身份证背面 **/
    PHOTO_SIGNER_IDENTITY_CARD_BACK,
    /** 签名人复述录音 **/
    SOUND_SIGNER_RETELL,
    /** 签名人自定义录音 **/
    SOUND_SIGNER_OTHER,
};

typedef struct signImageInformation
{
    CGRect Signrect;
    CGSize SignImageSize;
    
}signImageinfo;

typedef struct signCameraInformation
{
    BOOL savePicData;/*是否将采集到的图片都保存到加密报文中*/
    BOOL takePicOnComfirmSig;/*是否在用户确认签名时调用前摄像头拍一张照片*/
    BOOL showPreviewUI;/*是否在用户签名时显示拍照预览界面*/
    BOOL evidence;
    BOOL attach;
    CGSize cameraImageSize;
    float quality;
    NSString *callbackKey;
    BOOL checkface;
    NSString *faceMessage;
}signCamreaInfo;

typedef struct signerInformation
{
    NSString *name;
    NSString *IdNumber;
    NSString *RuleType;
    NSString *Tid;
    NSString *kw;
    NSString *kwPos;
    NSString *kwOffset;
    NSString *kwIndex;
    NSString *xOffset;
    NSString *yOffset;
    NSString *Left;
    NSString *Top;
    NSString *Right;
    NSString *Bottom;
    NSString *Pageno;
    NSString *timePos;
    NSString *timeFormat;
    BOOL geo;
    signImageinfo imgeInfo;
    BOOL isTss;
    signCamreaInfo cameraInfo;
    BOOL isViewMyself;
    int scale;
    float strokeWidth;//签名笔粗细
    UIColor *strokeColor;//签名笔颜色
}signinfo;

typedef struct signerMutiInformation
{
    CGSize SignImageSize;
    NSString *commitment;
    NSString *name;
    NSString *IdNumber;
    NSString *RuleType;
    NSString *Tid;
    NSString *kw;
    NSString *kwPos;
    NSString *kwOffset;
    NSString *kwIndex;
    NSString *xOffset;
    NSString *yOffset;
    NSString *Left;
    NSString *Top;
    NSString *Right;
    NSString *Bottom;
    NSString *Pageno;
    NSString *timePos;
    NSString *timeFormat;
    float scale;
    float strokeWidth;
    UIColor *strokeColor;
    int lineMax;
    BOOL isEcho;
}signMutiInfo;

typedef struct cameraImageInformation
{
    CGSize cameraImageSize;
}cameraImageInfo;

typedef struct CameraInformation
{
    NSString *property;
    CGFloat  quality;
    cameraImageInfo imageSize;
    bool checkface;
    NSString *faceMessage;
    CGRect FrameRect;
    BOOL cancelExist;
}cameraInfo;

typedef struct CameraInformationEvidence
{
    int index;
    int evidenceId;
    BioType type;
    BOOL attach;
    BOOL geo;
}cameraInfoEvidence,recordInfoEvidence;

typedef NS_ENUM(NSInteger, EncType) {
    EncType_RSA,
    EncType_SM2
};

typedef struct formInformation
{
    NSString *WONo;
    NSString *FlowId;
    NSString *Channel;
    NSString *IsSync;
    NSString *IsUnit;
    EncType serverEncType;
}formInfo;

typedef struct Cachet
{
    NSString *RuleType;
    NSString *Tid;
    NSString *kw;
    NSString *kwPos;
    NSString *kwOffset;
    NSString *Left;
    NSString *Top;
    NSString *Right;
    NSString *Bottom;
    NSString *Pageno;
    NSString *IsTSS;
    NSString *AppName;
    UIImage *pngImage;
}CachetObj;

typedef struct recordInformation
{
    bool showUi;
    float DurTime;
    CGRect FrameRect;
}recordInfo;

typedef struct PdfCrdRule
{
    NSString *DocCrdTid;
    NSString *DocStyleTid;
}PdfRule;

- (BOOL)showInputDialog:(int) context_id callBack:(NSString *)message signerInfo:(signinfo)info;
- (UIView *)getDoodleView;//获取签名view
- (void)clearDrawing;//清除签名画布
- (void)confirm;//签名确认
- (void)cancel;//签名取消
- (void)dismiss;//销毁签名框
- (BOOL)isDrawn;//是否存在签名内容
- (BOOL)showtakePicture:(int) context_id callBack:(NSString *)message cameraInfo:(cameraInfo)info;
- (BOOL)showtakePictureEvidence:(int) context_id callBack:(NSString *)message cameraInfo:
(cameraInfo)info evidence:(cameraInfoEvidence)evidenceInfo;
- (UIView *)getPictureView;
- (UIImage *)getOrignalSignature;//获取缩放前的图片
- (BOOL)showMassInputDialog:(int) context_id callBack:(NSString *)message muti:(signMutiInfo)dataInfo;
- (UIView *)getMassSignView;
- (NSString *)getUploadDataGram;
- (bool)setTemplate:(NSString * )template_type mydata :(NSData *)data PdfRule:(PdfRule)RuleData;
- (BOOL)startMediaRecording:(int) context_id callBack:(NSString *)message recordInfo:(recordInfo)info;
- (BOOL)startMediaRecordingEvidence:(int) context_id callBack:(NSString *)message recordInfo:(recordInfo)info evidence:(recordInfoEvidence)evidenceInfo;
- (UIView *)getRecordView;
- (void)stopRecord;
- (BOOL)setSignInfo:(NSString *)Cid signer:(signinfo)info;
- (BOOL)setFormInfo:(formInfo)info;
- (BOOL)addChachetObj:(CachetObj)info;
- (void)reset;
- (BOOL)isReadyToUpload;
- (void)deleteSignInfo:(NSString *)Cid;
- (BOOL)addEvidence:(int)index ownIndex:(int)ownIndex contentData:(NSData *)data bioType:(EvidenceBioType)type orAttach:(BOOL)attach;
- (NSString *)getAPIVersion;
@end
