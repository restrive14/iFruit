# iFruit

一个基于 Flutter 开发的移动端项目，灵感来源于 GTA V 中“线上模式”里的手机界面体验。项目通过仿真式界面、列表导航、设置中心和主题切换等功能，打造出一个类似真实游戏内手机菜单的交互原型。

## 项目简介

本项目旨在复刻 GTA V 中手机交互的视觉风格与操作逻辑，主要包括：

- 模拟手机首页导航
- 邮件、消息、好友、任务、加入、设置等功能入口
- 类似游戏内“手机菜单”的列表式交互
- 自定义设置中心与详情页
- 主题切换功能
- 设置项持久化存储，支持下次打开时恢复上一次选择

整体界面偏轻量交互型应用，适合学习 Flutter、状态管理、路由、主题配置和本地存储的综合项目。

## 功能特性

### 1. GTA V 风格手机界面
- 采用类似游戏内手机 UI 的视觉布局
- 页面入口包括：
  - 首页
  - 邮件
  - 消息
  - 好友
  - 加入
  - 任务
  - 设置
  - 其他常见功能模块

### 2. 设置中心与细节配置
- 设置页可展示不同类目
- 点击具体设置项后进入详情页
- 每个设置项包含多个子选项
- 可选择当前偏好并保存

### 3. 主题切换
- 支持多套色彩主题切换
- 主题名称、色板数据和应用主题状态由 Provider 管理
- 切换后可即时更新页面视觉效果

### 4. 本地存储
- 使用 SharedPreferences 保存用户选中的设置索引
- 进入详情页时会读取本地值
- 若本地不存在，则默认使用索引 0
- 这样可以保留用户上一次的设置状态

### 5. 状态管理
- 使用 Provider 进行全局状态管理
- 分别处理：
  - 全局设置状态
  - 主题状态
  - 页面交互状态

## 技术栈

- Flutter
- Dart
- Provider
- SharedPreferences
- Flutter ScreenUtil
- Material Design

### 关键依赖

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  flutter_screenutil: ^5.9.3
  shared_preferences: ^2.5.5
  image_picker: ^1.2.3
```

## 项目结构

```text
lib/
  main.dart
  constants/
  models/
  pages/
    home/
    setting/
    email/
    message/
    task/
    join/
    friend/
  providers/
    global.dart
    theme.dart
  routes/
  utils/
  widgets/
assets/
  data/
  icons/
  audios/
```

## 主题切换实现说明

本项目的主题逻辑主要包含两部分：

1. 主题配置定义
   - 在 `utils/theme.dart` 中定义主题色板和主题构建方法
   - 例如蓝色、红色、粉色、橙色、绿色、紫色、灰色等

2. 状态管理
   - `ThemeProvider` 负责维护当前选中的主题索引
   - 调用 `setThemeIndex()` 和 `setThemeByName()` 切换主题

3. 持久化保存
   - `ThemeService` 使用 SharedPreferences 保存主题索引
   - 下次启动时会自动恢复上一个主题配置

## 设置项持久化说明

设置页面相关的配置会保存在 `GlobalProvider` 中，并同步写入本地存储：

- 背景
- 邀请声音
- 铃声
- Snapmatic
- 主题
- 振动

保存的数据为选中项的索引值，例如：

- 默认值：`0`
- 用户保存：`2`
- 下次进入设置详情页时会自动选中第 3 项

## 运行方式

### 1. 安装依赖

```bash
flutter pub get
```

### 2. 启动项目

```bash
flutter run
```

## 开发目标

这个项目适合用于以下场景：

- 学习 Flutter 组件与页面开发
- 熟悉 Provider 状态管理
- 了解本地存储和主题切换
- 模拟游戏风格 UI 设计
- 练习路由、列表页和详情页结构设计

## 备注

这是一个偏“仿真 UI / 交互原型”的项目，重点在于界面还原和前端交互逻辑的实现，而不是完整的商业级功能闭环。它对 Flutter 初学者和想提升 UI 实战能力的开发者都很适合。

## 许可证

本项目仅用于学习与演示用途。
