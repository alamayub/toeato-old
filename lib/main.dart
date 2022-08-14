import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toeato/config/theme.dart';

import 'blocs/auth/auth_bloc.dart';
import 'firebase_options.dart';
import 'screens/wrapper.dart';
import 'services/auth/firebase_auth_provider.dart';
import 'services/user/firestore_auth_provider.dart';

void main() async {
  log('app started successfully!');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            provider: FirebaseAuthProvider(),
            userProvider: FirestoreAuthProvider(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Toeato',
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: const Wrapper(),
      ),
    );
  }
}
