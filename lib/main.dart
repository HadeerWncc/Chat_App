import 'package:chat_app/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/cubites/auth_cubit/auth_cubit.dart';
import 'package:chat_app/pages/cubites/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDuNOeLpoazo-rtyqikYgjFBQ37m2K9oPk",
        appId: "1:612090970015:web:c2820d428a02aa2a1507aa",
        messagingSenderId: "612090970015",
        projectId: "chat-app-6329a",
        storageBucket: "chat-app-6329a.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(create: (context) => AuthBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LoginPage.id,
        // home: const LoginPage(),/
      ),
    );
  }
}
