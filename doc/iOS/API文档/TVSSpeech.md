# TVSSpeech

## 语音设置 <TVSSpeech/TVSSpeech.h>

### TVSAISpeechItem 音色配置类

#### 成员

| 名称 | 类型 | 描述 |
| ------ | ------ | ------ |
| speechId | NSString* | 音色 id |
| speechName | NSString* | 音色名称 |
| speechEnum | NSString* | AISpeechType 枚举值 |
| isDefaultOption | NSString* | 是否默认音色 |

#### 方法

  无；

### TVSSpeech 类

#### 成员

  无；

#### 方法

##### `+(instancetype)shared;`

  **描述**：

  获取 TVSSpeech 类实例对象；

  **参数**：

  无；

  **返回**：

  TVSSpeech 类实例；

##### `-(void)getBotAISpeechOptionWithProductId:(NSString*)productId handler:(void(^)(NSArray<TVSAISpeechItem*>*))handler;`

  **描述**：

  获取 bot 音色配置；

  **参数**：

| 名称 | 类型 | 描述 | 是否必填 |
| ------ | ------ | ------ | ------ |
| productId | NSString* | 设备 productId | 是 |
| handler | void(^)(NSArray<TVSAISpeechItem*>*) | 回调，返回配置列表 | 是 |

  **返回**：

  无；

##### `-(void)getDeviceAISpeechWithProductId:(NSString*)productId dsn:(NSString*)dsn handler:(void(^)(TVSAISpeechItem*))handler;`

  **描述**：

  获取设备音色配置；
  必须登录后调用！

  **参数**：

| 名称 | 类型 | 描述 | 是否必填 |
| ------ | ------ | ------ | ------ |
| productId | NSString* | 设备 productId | 是 |
| dsn | NSString* | 设备序列号 | 是 |
| handler | void(^)(TVSAISpeechItem*) | 回调，返回音色配置 | 是 |

  **返回**：

  无；

##### `-(void)setDeviceAISpeechId:(NSString*)speechID productId:(NSString*)productId dsn:(NSString*)dsn handler:(void(^)(BOOL))handler;`
  **描述**：

  设置设备音色；
  必须登录后调用！

  **参数**：

| 名称 | 类型 | 描述 | 是否必填 |
| ------ | ------ | ------ | ------ |
| speechID |  NSString* | 音色 id | 是 |
| productId | NSString* | 设备 productId | 是 |
| dsn | NSString* | 设备序列号 | 是 |
| handler | void(^)(BOOL) | 回调，返回是否设置成功 | 是 |

  **返回**：

  无；
