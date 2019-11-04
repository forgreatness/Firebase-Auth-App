# firebase_auth_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## About
Firebase Auth App is a mobile application that works like a TODO app. It lets the user manage their tasks with their own account. The specific purpose of the app is to allow the user to create an account using their email and password, or be authenticate using a federate identity like Facebook or Google.

## How to Use
1. Refer to Flutter for installment
2. Follow the steps under Firebase to set up your project
### Setting Up Firebase
1. Obtain a Firebase account
2. Create a Firebase project
3. Create both an ios and android application under that Firebase project
4. Follow the instructions given by Firebase to setup the ios and android application (our application must have google-service.json for android and GoogleService-Info.plist for ios)
5. Enable google and facebook under the authentication of your firebase project.

## Layout
### Login Page
- The entry point of the application. This page allows the user to sign in or be authenticated using facebook or google
### Register Page
- This page allows the user to create a new account using an email and password
### Home Page
- The home page will display the current tasks that has yet to be completed

