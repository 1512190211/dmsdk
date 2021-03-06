# TVSQRCode

## TVSQRCode <TVSQRCode/TVSQRCode.h>

### TVSQRCodeBusinessType 扫码业务类型枚举

| 名称 | 描述 |
| ------ | ------ |
| TVSQRCodeBusinessTypeDeviceBind | 设备绑定业务 |
| TVSQRCodeBusinessTypeJoinDeviceRelationShip | 加入设备亲友圈业务 |
| TVSQRCodeBusinessTypeUnknown | 未知类型 |

### TVSQRCodeStatus 二维码状态类型枚举

| 名称 | 类型 |
| ------ | ------ |
| TVSQRCodeStatusInit | 未扫描 |
| TVSQRCodeStatusScanned | 已扫描 |
| TVSQRCodeStatusScannedConfirmed | 扫描后已点确认 |
| TVSQRCodeStatusScannedCanceled | 扫描后点取消 |

### TVSQRCodeInfo 二维码信息实体类

#### 成员

| 名称 | 类型 | 描述 |
| ------ | ------ | ------ |
| status | TVSQRCodeStatus | 二维码状态 |
| accountInfo | TVSAccountinfo* | 账号信息 |
| userInfo | TVSUserInfo* | 用户信息 |

#### 方法

 无；

### TVSQRCode 二维码接口类

#### 成员

 无;

#### 方法

##### `+(void)queryQRScanResult:(NSString*)result handler:(void(^)(NSDictionary*))handler;`

  **描述**:

  通过二维码扫描结果，查询相关信息；
  如果是亲友圈业务，必须确保已登录！！

  **参数**:

| 名称 | 类型 | 描述 | 是否必填 |
| ------ | ------ | ------ | ------ |
| result | NSString* | 二维码扫描结果 | 是 |
| handler | void(^)(NSDictionary*) | 回调，NSDictionary* 参数为查询到的信息字典 | 是 |

  **返回**:

  无；

##### `+(TVSQRCodeBusinessType)queryBusinessTypeWithQRScanResult:(NSString*)result;`

  **描述**:

  通过二维码扫描结果，查询业务类型；

  **参数**:

| 名称 | 类型 | 描述 | 是否必填 |
| ------ | ------ | ------ | ------ |
| result | NSString* | 二维码扫描结果 | 是 |

  **返回**:

  二维码业务类型；

##### `-(instancetype)initWithBusinessType:(TVSQRCodeBusinessType)businessType productId:(NSString*)productId dsn:(NSString*)dsn;`

  **描述**:

  实例化；

  **参数**:

| 名称 | 类型 | 描述 | 是否必填 |
| ------ | ------ | ------ | ------ |
| businessType | TVSQRCodeBusinessType | 二维码业务类型 | 是 |
| productId | NSString* | 设备 productId | 是 |
| dsn | NSString* | 设备序列号 | 是 |

  **返回**:

  二维码接口类实例;

##### `-(void)getQRCodeInfoWithHandler:(void(^)(TVSQRCodeInfo*))handler;`

  **描述**:

  获取二维码信息

  **参数**:

| 名称 | 类型 | 描述 | 是否必填 |
| ------ | ------ | ------ | ------ |
| handler | void(^)(TVSQRCodeInfo*) | 回调，TVSQRCodeInfo* 即为二维码信息 | 是 |

  **返回**:

  无；

##### `-(void)setQRCodeStatus:(TVSQRCodeStatus)status handler:(void(^)(BOOL))handler;`

  **描述**:

  设置二维码状态；

  **参数**:

| 名称 | 类型 | 描述 | 是否必填 |
| ------ | ------ | ------ | ------ |
| status | TVSQRCodeStatus | 二维码状态 | 是 |
| handler | void(^)(BOOL) | 回调，BOOL 表示是否设置成功 | 是 |

  **返回**:

  无；