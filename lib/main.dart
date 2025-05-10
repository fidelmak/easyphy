import 'package:easyphy/phyProvider/formulars_provider.dart';
import 'package:easyphy/phyProvider/laws_provider.dart';
import 'package:easyphy/phyProvider/unit_quiz_provider.dart';
import 'package:easyphy/phyProvider/units_provider.dart';
import 'package:easyphy/solutions/phy.dart';
import 'package:easyphy/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhysicsProvider()..loadUnits()),
        //
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => QuizState()),
        ChangeNotifierProvider(
            create: (_) => PhysicsLawProvider()..loadFormulas()),
        ChangeNotifierProvider(
            create: (_) => PhysicsFormulaProvider()..loadFormulas()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          Size(375, 812), // Adjust based on your design (default iPhone X)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        );
      },
    );
  }
}
