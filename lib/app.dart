import 'package:flutter/material.dart';
import 'package:my_app/core/routing/app_go_router.dart';
// import 'core/routing/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Clean Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      // initialRoute: '/',
      // onGenerateRoute: AppRouter.onGenerateRoute,
      routerConfig: AppGoRouter.router,
    );
  }
}
