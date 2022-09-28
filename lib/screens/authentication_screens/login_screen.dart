import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/login_cubit/login_cubit.dart';
import 'package:shop_app/bloc/login_cubit/login_states.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/themes.dart';
import 'package:shop_app/widgets/default_button.dart';
import 'package:shop_app/widgets/default_ttf.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {
        if (state is LoginSucState) {
          CacheHelper.addData('alToken', state.token).then((value) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/layout', (route) => false);
          });
        }
      }, builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is LoginLoadingState,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        Text('LOGIN',
                            style: primaryStyle.copyWith(fontSize: 35)),
                        Text('Login Now TO Browse Our Hot Offers',
                            style: primaryStyle.copyWith(
                                fontSize: 22, color: Colors.grey)),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultTTF(
                            controller: emailController,
                            label: 'Enter Your Email',
                            prefixIcon: const Icon(Icons.email_outlined)),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultTTF(
                          controller: passwordController,
                          label: 'Enter Your Password',
                          obscureText: LoginCubit.get(context).showPassword,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              LoginCubit.get(context).hidePassword();
                            },
                            icon: LoginCubit.get(context).showPassword
                                ? const Icon(Icons.visibility_outlined)
                                : const Icon(Icons.visibility_off_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultButton(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    emailController.text,
                                    passwordController.text);
                              }
                            },
                            label: 'Login'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                                style: primaryStyle.copyWith(
                                    fontSize: 22, color: Colors.black54)),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(' Register Now',
                                  style: primaryStyle.copyWith(
                                      fontSize: 22, color: Colors.blueAccent)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
