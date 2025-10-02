import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'core/config/firebase_env.dart';

Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: FirebaseEnv.apiKey,
      appId: FirebaseEnv.appId,
      messagingSenderId: FirebaseEnv.messagingSenderId,
      projectId: FirebaseEnv.projectId,
      authDomain: FirebaseEnv.authDomain,
      storageBucket: FirebaseEnv.storageBucket,
      measurementId: FirebaseEnv.measurementId,
      ),  
    );
  
  runApp(const MyApp());
}
