# Contribution

## Table of contents
- [Introduction](#introduction)
- [Setup](#setup)
- [Structure](#structure)
- [Design](#design)

# Introduction
This document is intended to assist both new and experienced programmers in contributing to this project. 

It provides information on how to setup the development environment, understand the app structure, and more.

# Setup
This section provides a step-by-step guide on how to setup the build environment and app. 

Although not required, it is recommended to use [Android Studio](https://developer.android.com/studio/) with the [Flutter plugin](https://plugins.jetbrains.com/plugin/9212-flutter).

### Steps
1. Install flutter and then setup an editor.
```
https://docs.flutter.dev/get-started/install
```

2. Clone this repository.
```
https://github.com/Deluxepter/maven
```

3. Get packages.
```
flutter pub get
```

4. Run `builder_runner`.
```
flutter packages pub run build_runner build
```

# Structure
In this section, you will learn about the app's structure and how to navigate through the codebase.

### Overview



# Design
In this section, you will learn about Maven's design philosophy and how to use the Maven Design Tool. 

### Philosophy 
A well-crafted design is an essential aspect of any app, as it shapes the user's first impression. To ensure a consistent look across all platforms, Maven uses a unified design language. However, this approach may sacrifice the native look and feel of each platform. To overcome this, Maven incorporates a combination of design systems such as Material, Cupertino, Fluent, and others, to provide the optimal user experience.

### Maven Design Tool 
Documentation is helpful, but interactive examples are even more effective. Whenever you're debugging the app, there is a floating icon on the right side of the screen. When clicked it will display information about things like color, padding, and text-style. This is helpful whenever your building a widget and are not sure what text-style to use or color.

