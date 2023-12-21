# Maven
### Track Progress. Reach Goals. Unleash Potential.
<p>
    <img src="https://github.com/deluxepter/maven/blob/master/metadata/en-US/images/phoneScreenshots/1.png?raw=true" width="200" />
    <img src="https://github.com/deluxepter/maven/blob/master/metadata/en-US/images/phoneScreenshots/2.png?raw=true" width="200" />
</p>


## Table of Contents
- [Installation](#installation)
- [Features](#features)
- [Usage](#usage)
- [Contributing](#contributing)
- [Support](#support)
- [License](#license)


## Installation
<p>
    <a href='https://play.google.com/store'>
        <img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' height='75'/>
    </a>
    <a href='https://f-droid.org/en/'>
        <img alt='Get it on F-Droid' src='https://gitlab.com/fdroid/artwork/-/raw/master/badge/get-it-on-en-us.svg' height='75'/>
    </a>
</p>

#### Optional: Build from source
1. Install [Flutter](https://docs.flutter.dev/get-started/install) and then setup an [editor](https://developer.android.com/studio).

2. Clone this repository.
```
git clone https://github.com/deluxepter/maven
```

3. Get packages.
```
flutter pub get
```

4. Generate database.
```
flutter packages pub run build_runner build
```

5. Generate localizations.

```
flutter pub run intl_utils:generate
```

6. Run the app.

```
flutter run
```

7. Run tests.

```
flutter test --coverage
```

8. Generate coverage report.

```
genhtml coverage/lcov.info -o coverage/html
```

## Features

- [x] Sample List
- [x] Track workouts
- [x] Track body measurements
- [x] Track nutritional intake
- [x] Track progress
- [x] Track goals

## Usage
If you’ve used other workout apps in the past, the Maven experience should feel familiar and intuitive. However, for those who are new to
the world of tracking their workouts, we’ve developed a comprehensive usage guide to help get you up to speed. 

[Usage Guide](/docs/usage.md)


## Contributing
Whether you want to report a bug or add a new feature, contributions are welcome and greatly appreciated. For more detailed information on how to contribute, please refer to our [Contributing Guide.](/docs/contributing.md)


## Support
If you encounter any issues or have questions, please [open an issue.](https://github.com/deluxepter/maven/issues)


## License
This project is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html) - see the [LICENSE](LICENSE)
file for details.