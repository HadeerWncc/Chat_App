import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future loginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
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

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      var auth = FirebaseAuth.instance;
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(RegisterFailure(errorMsg: "The password provided is too weak!"));
      } else if (ex.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errorMsg: "The account already exists for that email!"));
      } else if (ex.code == 'invalid-email') {
        emit(RegisterFailure(errorMsg: "Invalid email!"));
      }
    } catch (ex) {
      emit(RegisterFailure(errorMsg: "there was an error!"));
    }
  }
}
