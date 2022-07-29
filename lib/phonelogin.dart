import 'package:firebase_flutter/bloc/authentication_bloc.dart';
import 'package:firebase_flutter/bloc/authentication_event.dart';
import 'package:firebase_flutter/bloc/authentication_state.dart';
import 'package:firebase_flutter/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homepage.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Login')),
      body: SafeArea(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        }, builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UnAuthenticated) {
            return Container(
              padding: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
                shape: BoxShape.rectangle,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Enter Phone Number",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          authWithPhone(context);
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignInPage()));
                        },
                        child: const Text("Login with Email"))
                  ],
                ),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }


  void authWithPhone(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(VerifyWithPhone(phone: phoneController.text, context: context));
    }
  }
}
