import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'core/config/config_env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: ConfigEnv.apiKey,
      appId: ConfigEnv.appId,
      messagingSenderId: ConfigEnv.messagingSenderId,
      projectId: ConfigEnv.projectId,
      authDomain: ConfigEnv.authDomain,
      storageBucket: ConfigEnv.storageBucket,
      measurementId: ConfigEnv.measurementId,
      ),  
    );
  
  runApp(
    ProviderScope(
        child: const MyApp(),
      )
    );
}
