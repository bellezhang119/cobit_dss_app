import 'package:cobit_dss_app/firebase_options.dart';
import 'package:cobit_dss_app/responsive/mobile_screen_layout.dart';
import 'package:cobit_dss_app/responsive/responsive_layout_screen.dart';
import 'package:cobit_dss_app/responsive/web_screen_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cobit_dss_app/pages/homepage.dart';
import 'package:cobit_dss_app/pages/landingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root build function
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COBIT DSS',
      theme: ThemeData.light(),
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Checking if the snapshot has any data or not
            if (snapshot.hasData) {
              // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

        
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return const LandingPage();
        },
        stream: null,
      ),
    );
  }
}
