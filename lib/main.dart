import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/bloc/authentication_bloc.dart';
import 'package:firebase_flutter/screens/home/homepage.dart';
import 'package:firebase_flutter/screens/phonelogin/phonelogin.dart';
import 'package:firebase_flutter/repo/authrepository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context,snapshot){
              if(snapshot.hasData) {
                return const HomePage();
              }
              return const PhoneLogin();
            },
          )
        ),
      ),
    );

  }
}
