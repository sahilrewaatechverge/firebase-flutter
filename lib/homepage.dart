import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/bloc/authentication_bloc.dart';
import 'package:firebase_flutter/bloc/authentication_event.dart';
import 'package:firebase_flutter/bloc/authentication_state.dart';
import 'package:firebase_flutter/phonelogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final  user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const PhoneLogin()),
              (route) => false);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              user.phoneNumber !=  null ? Text(user.phoneNumber.toString()) : Text(user.email.toString()),
              const SizedBox(height: 12,),
              user.photoURL != null ? Image.network(user.photoURL.toString()): Container(),
              const SizedBox(height: 12,),
              user.displayName != null ? Text(user.displayName.toString()): Container(),
              const SizedBox(height: 12,),
              ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(SignOut());
                  },
                  child: const Text("SignOut"))
            ],
          ),
        ),
      ),
    );
  }
}
