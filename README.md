
# jogzilla

jogzilla is a run-tracker application developed with Flutter. 

## Getting Started

  

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

  

### Prerequisites

  * The latest version of Flutter and Dart installed on your local machine.
  * A Mapbox account with a valid API key
  * Some patience



**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/pr4aveen/jogzilla.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Go to project root and create a new file `api_key.dart`. In that file, add the following line

```dart
const API_KEY = "YOUR_API_KEY_HERE";
```


**For Android devices**

Add Mapbox access token configuration in the application manifest  `/android/app/src/main/AndroidManifest.xml`:
```xml
<manifest ...
  <application ...
    <meta-data android:name="com.example.jogzilla" android:value="YOUR_TOKEN_HERE" />
```

**For iOS devices**

Add Mapbox access token configuration to the application Info.plist  `/ios/Runner/Info.plist`:
```xml
<key>io.flutter.embedded_views_preview</key>
<true/>
<key>MGLMapboxAccessToken</key>
<string>YOUR_TOKEN_HERE</string>
```

## Authors

  

*  **Balasubramaniam Praveen** -  [pr4aveen](https://github.com/pr4aveen)
* **Zhang Xin Yue** - [xyzhangg](https://github.com/xyzhangg)
 

## License


jogzilla is released under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
