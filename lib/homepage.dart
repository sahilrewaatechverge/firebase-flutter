import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/bloc/authentication_bloc.dart';
import 'package:firebase_flutter/bloc/authentication_event.dart';
import 'package:firebase_flutter/bloc/authentication_state.dart';
import 'package:firebase_flutter/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: BlocListener<AuthenticationBloc,AuthenticationState>(
        listener: (context, state){
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignInPage()), (route) => false);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(user!.email.toString()),
              ElevatedButton(onPressed: (){
                context.read<AuthenticationBloc>().add(SignOut());
              }, child: const Text("SignOut"))
              
            ],
          ),
        ),
      ),
    );
  }
}
