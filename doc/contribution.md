# Contribution
This document is intended to assist both new and experienced programmers in contributing to this project.

It provides information on how to setup the development environment, understand the app structure, and more.

## Table of contents
- [Guidelines](#guidelines)
- [Getting Started](#getting-started)
- [Structure](#structure)
- [Design](#design)

## Guidelines
This section covers the guidelines for contributing to this project.

TODO: Add guidelines

## Getting Started
This section provides a step-by-step guide on how to setup the build environment and app. 

Although not required, it is recommended to use [Android Studio](https://developer.android.com/studio/) with the [Flutter plugin](https://plugins.jetbrains.com/plugin/9212-flutter).

#### Steps
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

## Structure
In this section, you will learn about the app's structure and how to navigate through the codebase.

**TODO**

## Design
This section covers the essentials of the app's design and how to use the design tool.

#### Philosophy 
A well-crafted design is an essential aspect of any app, as it shapes the user's first impression. To ensure a consistent look across all platforms, Maven uses a unique and unified design language. However, this approach may sacrifice the native look and feel of each platform. To overcome this, Maven incorporates a combination of design systems such as Material, Cupertino, Fluent, and others, to provide the best of all worlds.

#### MDT (Maven Design Tool) 
Documentation is helpful, but examples are even more effective. **Whenever you're debugging the app, there is a floating icon on the right side of the screen.** When clicked it will display information about things like color, padding, and text-style. This is helpful whenever you are building a widget and are not sure about the styling to use.

#### Theme
The app contains built-in themes, including light, dark, and several other options. For most users, this will suffice, but for those who want more control, there is a built-in theme editor.

It is essential to **only use the provided styles and colors** when building widgets. This is so that user made themes will seamlessly fit in.
If you feel that a style or color is missing, you should review the [MDT](#mdt-maven-design-tool) and reconsider your design. However, if you still feel that it is necessary, please open an issue. 


