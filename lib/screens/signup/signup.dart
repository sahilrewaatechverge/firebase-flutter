import 'package:firebase_flutter/screens/login/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/authentication_bloc.dart';
import '../../bloc/authentication_event.dart';
import '../../bloc/authentication_state.dart';
import '../home/homepage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("SignUp"), automaticallyImplyLeading: false),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UnAuthenticated) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          label: const Text("Email")),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextField(
                      obscureText: true,
                      controller: password,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          label: const Text("Password")),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          authenticateWithEmailAndPassword(context);
                        },
                        child: const Text("SignUp"),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text("Already have Account?"),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignInPage()));
                      },
                      child: const Text("SignIn"),
                    ),
                    const Text("Or"),
                    IconButton(
                      icon: Image.asset("assets/google.png"),
                      onPressed: () {
                        authenticateWithGoogle(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  void authenticateWithEmailAndPassword(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthenticationBloc>(context)
          .add(SingUpRequest(email: email.text, password: password.text));
    }
  }

  void authenticateWithGoogle(context) {
    BlocProvider.of<AuthenticationBloc>(context).add(GoogleSignInRequested());
  }
}
