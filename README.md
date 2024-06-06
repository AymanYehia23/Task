# Flutter Task Management App Setup and Usage Instructions

## Overview
This Flutter project is a simple Task Management app that allows users to add, edit, and delete tasks even when offline. The app uses Firebase and Firestore as the backend and Bloc for state management. It supports both Android and desktop versions.

## Prerequisites
Before setting up and running the project, ensure you have the following installed on your machine:
- Flutter SDK (version 3.0.0 or later)
- Dart SDK
- Android Studio or Visual Studio Code (with Flutter and Dart plugins)
- Firebase account and project setup
- Local server setup for Firestore (if needed)

## Project Dependencies
The project uses the following dependencies:
- `flutter_screenutil: ^5.9.3`
- `google_fonts: ^6.2.1`
- `flutter_svg: ^2.0.10+1`
- `intl: ^0.19.0`
- `flutter_bloc: ^8.1.5`
- `meta: ^1.12.0`
- `uuid: ^4.4.0`
- `firebase_core: ^3.0.0`
- `cloud_firestore: ^5.0.0`
- `connectivity_plus: ^6.0.3`
- `hive: ^2.2.3`
- `hive_flutter: ^1.1.0`

## Setup Instructions

### Step 1: Clone the Repository
Clone the repository to your local machine using the following command:
```bash
git clone https://github.com/yourusername/task_management_app.git
cd task_management_app
```

### Step 2: Install Flutter Dependencies
Run the following command to install the required Flutter dependencies:
```bash
flutter pub get
```

### Step 3: Firebase Setup
1. **Create a Firebase Project:**
   - Go to the [Firebase Console](https://console.firebase.google.com/).
   - Click on "Add project" and follow the instructions to create a new Firebase project.

2. **Add Firebase to Your Flutter App:**
   - Click on the Android icon to add Firebase to your Android app. Follow the instructions to download the `google-services.json` file.
   - Place the `google-services.json` file in the `android/app` directory of your Flutter project.
   - Modify the `android/build.gradle` and `android/app/build.gradle` files according to Firebase setup instructions.

3. **Enable Firestore:**
   - In the Firebase Console, go to "Firestore Database" and click on "Create database".
   - Choose the appropriate settings and complete the setup.

### Step 4: Configure Firebase in Flutter
Ensure you have added the Firebase dependencies in your `pubspec.yaml` file:
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_screenutil: ^5.9.3
  google_fonts: ^6.2.1
  flutter_svg: ^2.0.10+1
  intl: ^0.19.0
  flutter_bloc: ^8.1.5
  meta: ^1.12.0
  uuid: ^4.4.0
  firebase_core: ^3.0.0
  cloud_firestore: ^5.0.0
  connectivity_plus: ^6.0.3
  hive: ^2.2.3
  hive_flutter: ^1.1.0
```

Initialize Firebase in your `main.dart` file:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(MyApp());
}
```

### Step 5: Run the Application
Connect your device or start an emulator, and use the following command to run the application:
```bash
flutter run
```

## Usage Instructions

### Adding a Task
1. Open the app.
2. Tap the "Add Task" button.
3. Enter the task details and save.

### Editing a Task
1. Tap on the task you want to edit.
2. Modify the task details and save.

### Deleting a Task
1. Swipe the task you want to delete to the left or right.
2. Confirm the deletion.

### Working Offline
- The app allows you to add, edit, and delete tasks even when offline.
- Changes made while offline will be synced with the Firebase backend once the connection is restored.

### Finishing a Task
1. Tap on the task you want to finish.
2. Mark it as completed.

## Building for Desktop
To build and run the desktop version of the app:
```bash
flutter build windows
flutter build linux
flutter build macos
```
(Note: Ensure you have set up Flutter for desktop development as per the [official documentation](https://docs.flutter.dev/desktop).)

## Additional Notes
- Make sure your Firebase Firestore rules are set to allow read and write operations for anonymous users if required for development.
- Keep your Firebase configuration secure and do not expose sensitive information in the repository.

## Conclusion
You have now successfully set up and configured the Task Management app. You can start adding, editing, and deleting tasks, and enjoy the offline-first capability with automatic sync to Firebase. Happy coding!
