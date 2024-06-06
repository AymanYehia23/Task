Overview
This Flutter project is a simple Task Management app that allows users to add, edit, and delete tasks even when offline. The app uses Firebase and Firestore as the backend and Bloc for state management. It supports both Android and desktop versions.

Prerequisites
Before setting up and running the project, ensure you have the following installed on your machine:

Flutter SDK (version 3.0.0 or later)
Dart SDK
Android Studio or Visual Studio Code (with Flutter and Dart plugins)
Firebase account and project setup

Project Dependencies
The project uses the following dependencies:
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

Setup Instructions
Step 1: Clone the Repository
Clone the repository to your local machine using the following command:
git clone https://github.com/AymanYehia23/task.git
cd task_management_app

Step 2: Install Flutter Dependencies
Run the following command to install the required Flutter dependencies:
flutter pub get

Step 3: Firebase Setup
Create a Firebase Project:

Go to the Firebase Console.
Click on "Add project" and follow the instructions to create a new Firebase project.
Add Firebase to Your Flutter App:

Click on the Android icon to add Firebase to your Android app. Follow the instructions to download the google-services.json file.
Place the google-services.json file in the android/app directory of your Flutter project.
Modify the android/build.gradle and android/app/build.gradle files according to Firebase setup instructions.
Enable Firestore:

In the Firebase Console, go to "Firestore Database" and click on "Create database".
Choose the appropriate settings and complete the setup.
Step 4: Configure Firebase in Flutter
Ensure you have added the Firebase dependencies in your pubspec.yaml file:
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

Step 5: Run the Application
Connect your device or start an emulator, and use the following command to run the application:
flutter run

Usage Instructions
Adding a Task
Open the app.
Tap the "Create Task" button.
Enter the task due date and save task.

Deleting a Task
Swipe the task you want to delete to the left or right.

Working Offline
The app allows you to add, edit, and delete tasks even when offline.
Changes made while offline will be synced with the Firebase backend once the connection is restored.

Finishing a Task
Tap on the task you want to finish.
Mark it as completed.


Building for Desktop
To build and run the desktop version of the app:
flutter build windows
flutter build linux
flutter build macos

Additional Notes
Make sure your Firebase Firestore rules are set to allow read and write operations for anonymous users if required for development.
Keep your Firebase configuration secure and do not expose sensitive information in the repository.
