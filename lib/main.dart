import 'package:flutter/material.dart';
import 'package:idea_note/data/db_class_info.dart';
import 'package:idea_note/features/main_screen/main_screen.dart';
import 'package:idea_note/features/post_screen/edit_screen.dart';
import 'package:idea_note/features/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyNote());
}

class MyNote extends StatelessWidget {
  const MyNote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Archive Note',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Colors.deepPurpleAccent,
        useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        EditScreen.routeName: (context) => EditScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/edit") {
          // 1. 기록 값을 넘기지 못한다면 "POST"
          // 2. 기록 값을 넘길 수 있다면 "EDIT"
          final IdeaInfo? ideaInfo = settings.arguments as IdeaInfo?;
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return EditScreen(
                ideaInfo: ideaInfo,
              );
            },
          );
        }
      },
    );
  }
}
