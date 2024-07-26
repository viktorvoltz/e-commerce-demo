import 'package:ecommerce/pages/login.dart';
import 'package:ecommerce/pages/signup.dart';
import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/provider/user_provider.dart';
import 'package:ecommerce/services/remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RemoteConfigService remoteConfigService = await RemoteConfigService.init();
  runApp(
    MyApp(
      remoteConfigService: remoteConfigService,
    ),
  );
}

class MyApp extends StatelessWidget {
  final RemoteConfigService remoteConfigService;

  MyApp({required this.remoteConfigService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(remoteConfigService),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => SignupScreen(),
          '/login': (BuildContext context) => LoginPage(),
        },
      ),
    );
  }
}
