import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if(event is LoginEvent){
         emit(LoginLoading());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } on FirebaseException catch (ex) {
      if (ex.code == "invalid-email") {
        emit(LoginFailure(errorMsg: "invalid email!"));
      } else if (ex.code == 'invalid-credential') {
        emit(LoginFailure(errorMsg: "email or password is incorrect!"));
      }
    } catch (e) {
      emit(LoginFailure(errorMsg: "there is an error"));
    }
      }
    });
  }
}
