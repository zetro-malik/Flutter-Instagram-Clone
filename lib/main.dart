import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_firebase/providers/user_provider.dart';
import 'package:insta_clone_firebase/responsive/mobile_screen_layout.dart';
import 'package:insta_clone_firebase/responsive/responsive_layout_screen.dart';
import 'package:insta_clone_firebase/responsive/web_screen_layout.dart';
import 'package:insta_clone_firebase/screens/login_screen.dart';
import 'package:insta_clone_firebase/screens/signup_screen.dart';
import 'package:insta_clone_firebase/utils/colors.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options:const FirebaseOptions(
            apiKey: 'AIzaSyD7uv1Kw1lMcI4p4VoSAGjbzItWu75_4QI',
            appId: '1:934974874408:web:0983357486bf23aa04e61d',
            messagingSenderId: '934974874408',
            projectId: 'insta-clone-firebase-a343e',
            storageBucket: 'insta-clone-firebase-a343e.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
        theme: ThemeData(
        
          useMaterial3: true
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
