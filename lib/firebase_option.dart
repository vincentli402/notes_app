import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDvi8KjykZyNkTDI8bALWzHrpICTxXnBA0",
          authDomain: "team-3-notesbook-app.firebaseapp.com",
          projectId: "team-3-notesbook-app",
          storageBucket: "team-3-notesbook-app.appspot.com",
          messagingSenderId: "968874696260",
          appId: "1:968874696260:web:5f62b5f257909057fc6611",
          measurementId: "G-MZD4C7WYT7"),
    );
  }
}
