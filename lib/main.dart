import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messenger/datas/bloc/contact_bloc.dart';
import 'package:messenger/firebase_options.dart';
import 'package:messenger/screens/chat_screen.dart';
import 'package:messenger/screens/login_screen.dart';
import 'package:messenger/screens/signup_screen.dart';
import 'package:messenger/screens/wrapper.dart';
import 'package:messenger/service/authentication.dart';
import 'package:messenger/models/chat_screen_argments_model.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:messenger/service/navigation.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Navigation()),
        BlocProvider(create: (context) => ContactBloc()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/chat') {
            final args = settings.arguments as ChatScreenModel;
            return MaterialPageRoute(
              builder: (context) {
                return ChatScreen(
                  receiverEmail: args.email,
                  receiverUserId: args.userId,
                  receiveruserName: args.userName,
                );
              },
            );
          }
          return null;
        },
        routes: {
          '/': (context) => FlutterSplashScreen.fadeIn(
            childWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Messenger',
                  style: GoogleFonts.poppins(fontSize: 36.0, fontWeight: FontWeight.bold),
                ),
                Text(".", style: GoogleFonts.poppins(fontSize: 36.0, fontWeight: FontWeight.bold)),
              ],
            ),
            useImmersiveMode: true,
            nextScreen: Authentication.isLoggedIn() ? const HomeWraper() : LoginScreen(),
          ),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/home': (context) => const HomeWraper(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
