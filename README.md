# iFruit

一个基于 Flutter 的 GTA 风格手机桌面/功能菜单应用。项目通过首页九宫格、列表页、详情页、设置中心、主题与背景配置，以及本地数据持久化，模拟了游戏中“手机 UI + 交互菜单”的体验。

## 项目简介

本项目以“游戏内手机界面”作为交互灵感，整体实现了：

- 首页九宫格入口导航
- 邮件 / 短信 / 好友 / 任务 / 加入 / 设置等功能页
- 列表页与详情页的交互结构
- 设置中心与多类配置项
- 主题切换、字体调整、背景选择与持久化保存
- 底部操作栏统一交互模式

这个项目适合学习 Flutter 中的页面组织、路由、Provider 状态管理、列表渲染和本地存储实现。

## 当前功能概览

### 1. 首页功能导航
首页采用九宫格布局，入口包括：

- 电子邮件
- 短信
- 联系人
- 快速加入
- 差事清单
- 设置
- Snapmatic
- 网络
- 保镖事务所

点击对应图标可以进入对应页面，部分页面也会显示未读数徽章。

### 2. 列表页 + 详情页交互
项目中多个模块都采用“列表页 + 详情页”的结构：

- 邮件列表 -> 邮件详情
- 消息列表 -> 消息详情
- 任务列表 -> 任务详情
- 俱乐部列表 -> 俱乐部详情
- 加入模块 -> 二级详情页
- 设置模块 -> 设置详情页

通过路由参数传递 ID，详情页再根据 ID 获取对应数据并展示。

### 3. 设置中心
设置页提供多个配置分组：

- 背景设置
- 邀请声音
- 铃声
- Snapmatic
- 主题
- 振动
- 字体大小
- 重置所有

每个分类都会进入详情页进行选项选择，点击底部确认按钮后保存到本地。

### 4. 背景切换
现有功能支持：

- 设置页选择背景
- 把 `backgroundIndex` 保存到 `SettingsProvider`
- 首页通过 `context.watch<SettingsProvider>().backgroundIndex` 监听当前选择
- 首页背景使用外部图片资源覆盖显示，切换后同步更新

支持的背景资源位于 `assets/background/` 目录。

### 5. 主题与字体
项目支持：

- 多套主题色：蓝色、绿色、灰色、橙色、粉色、紫色、红色
- 字体大小：小 / 默认 / 大
- 主题数据通过 Provider 管理
- 选中值会缓存到 SharedPreferences

### 6. 本地数据存储
本项目使用 `SharedPreferences` 和 `sqflite` 结合保存数据：

- 用户设置项索引
- 多个列表型数据（邮件、消息、任务、俱乐部等）
- 重置后恢复默认状态

## 技术栈

- Flutter
- Dart
- Provider
- SharedPreferences
- SQLite (Sqflite)
- Flutter ScreenUtil
- Image Picker
- FlutterToast

## 项目结构

```text
lib/
  main.dart
  core/
    db/
    model/
    router/
    setting/
    utils/
    widgets/
  features/
    home/
    email/
    message/
    friend/
    join/
    task/
    club/
    setting/
assets/
  audios/
  data/
  icons/
  background/
```

## 路由说明

主路由配置在 `lib/core/router/index.dart` 中，支持如下页面：

- `/home`（应用入口）
- `/email`、`/emailDetail`
- `/message`、`/messageDetail`
- `/friend`、`/calling`
- `/join`、`/joinDetail`、`/secondDetail`
- `/task`、`/taskDetail`
- `/club`、`/clubDetail`
- `/setting`、`/settingDetail`

页面参数通过 `PageParamsArgs` / `SettingPageParamsArgs` 传递。

## 配置与状态管理说明

### SettingsProvider
`SettingsProvider` 负责维护以下配置：

- `backgroundIndex`
- `inviteSoundIndex`
- `ringtoneIndex`
- `snapmaticIndex`
- `themeIndex`
- `vibrationIndex`
- `fontIndex`

配置项被写入本地存储，并在应用启动时恢复。

### 首页背景
首页当前背景由 `HomeBackground` 组件负责，读取当前 `backgroundIndex` 后使用 `Image.asset` 显示对应图片：

- `assets/background/lansexiejiao.jpg`
- `assets/background/lansesuipian.jpg`
- `assets/background/lvsefangge.jpg`
- `assets/background/chengse8wei.jpg`
- 等多个背景资源

## 运行方式

### 1. 安装依赖

```bash
flutter pub get
```

### 2. 启动应用

```bash
flutter run
```

如果你希望在模拟器或真实设备上指定平台，可使用：

```bash
flutter run -d android
flutter run -d ios
```

## 开发说明

这个项目更偏向“仿真型手机 UI / 交互原型”，重点在于：

- 界面复刻
- 列表交互
- 路由与参数传递
- 数据展示和状态同步
- 本地持久化与设置保存

适合用于 Flutter 入门学习、UI 交互练习，以及状态管理与路由结构的实战项目。

## 备注

当前项目已经具备较完整的页面结构和功能闭环，部分内容仍属于交互原型范畴，而不是完整商业产品的全功能实现。

## 许可证

本项目仅用于学习、演示和个人开发实践。