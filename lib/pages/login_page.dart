import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snackbar.dart';
import 'package:chat_app/pages/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/cubites/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  // final String? email, passward;
  // GlobalKey<FormState> formKey = GlobalKey();
  static String id = "Login Page";
  // bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    bool isLoading = false;
    String? email, password;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          BlocProvider.of<ChatCubit>(context).getMsgs();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
        } else if (state is LoginFailure) {
          isLoading = false;
          ShowSnackbar.showSnackBar(context, state.errorMsg);
        }
      },
      builder: (BuildContext context, AuthState state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryKey,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    const Row(
                      children: [
                        Text(
                          'LogIn',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomFormInput(
                      onChange: (data) {
                        email = data;
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFormInput(
                      secure: true,
                      onChange: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(email: email!, password: password!),
                          );
                        }
                      },
                      text: 'Sign In',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xffcdf4f1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
