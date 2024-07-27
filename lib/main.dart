import 'package:ecommerce/pages/login.dart';
import 'package:ecommerce/pages/product_page.dart';
import 'package:ecommerce/pages/signup.dart';
import 'package:ecommerce/provider/auth_provider.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/provider/user_provider.dart';
import 'package:ecommerce/services/remote_config.dart';
import 'package:ecommerce/util/adaptive_spacing.dart';
import 'package:ecommerce/util/constants.dart';
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
    AdaptiveSpacing.init(context);
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
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: ColorConstants.systemScaffoldColor
        ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => SignupScreen(),
          '/login': (BuildContext context) => LoginPage(),
          '/product':(BuildContext context) => const ProductPage(),
        },
      ),
    );
  }
}
