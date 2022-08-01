import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repo/authrepository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  AuthenticationBloc({required this.authRepository}) : super(UnAuthenticated()) {

    on<SingInRequest>((event, emit) async {
      emit(Loading());
      try{
        await authRepository.signIn(email: event.email, password: event.password);
        emit(Authenticated());
      }
      catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }    });

    on<VerifyWithPhone>((event,emit) async {
      emit(Loading());
      try{
        emit(Loading());
        await authRepository.verifyWithPhone(verificationId: event.phone,smsCode: event.smsCode);
        emit(Authenticated());
      }catch (e){
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });



    on<SingUpRequest>((event, emit) async {
      emit(Loading());
      try{
        await authRepository.signUp(email: event.email, password: event.password);
        emit(Authenticated());
      }
      catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }    });

    on<GoogleSignInRequested>((event, emit) async{
      emit(Loading());
      try{
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      }catch(e){
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

      on<SignOut>((event, emit) async{
        emit(Loading());
        await authRepository.signOut();
        emit(UnAuthenticated());
      });
  }
}

