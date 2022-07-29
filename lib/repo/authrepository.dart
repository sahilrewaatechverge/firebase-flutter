import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> verifyWithPhone(
      {required String phone, required BuildContext context}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: "+91$phone",
          verificationCompleted: (credential) async {
            await _firebaseAuth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            if (e.code == 'invalid-phone-number') {
              throw Exception('The provided phone number is not valid.');
            }
          },
          codeSent: (verificationID, resendToken) async {
            final otpController = TextEditingController();
            showDialog(
              barrierDismissible: false,
                context: context,
                builder: (dialogContext) {
                  return Card(
                    elevation: 15,
                    margin: const EdgeInsets.all(20),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: MediaQuery.of(dialogContext).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Enter OTP Code",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            controller: otpController,
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
                            width: MediaQuery.of(dialogContext).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                String smsCode = otpController.text;
                                final credential = PhoneAuthProvider.credential(
                                    verificationId: verificationID,
                                    smsCode: smsCode);
                                _firebaseAuth.signInWithCredential(credential);
                                otpController.dispose();
                              },
                              child: const Text(
                                "Submit",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });

          },
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (verificationIdTime) {});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'week-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
