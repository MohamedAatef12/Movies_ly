import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movies_ly/screens/pages/onboarding_screen.dart';
import 'package:movies_ly/screens/pages/splash_screen.dart';
import 'package:movies_ly/widgets/widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  routes();
  runApp(const MyApp(
    startWidget: SplashScreen(),
  ));
}

void routes() {
  widget_1 = const OnBoardingScreen();
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({
    super.key,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies ly',
      theme: ThemeData(
        primaryColor: HexColor('#0FA125'),
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      home: startWidget,
    );
  }
}
