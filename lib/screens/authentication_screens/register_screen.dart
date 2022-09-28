import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../bloc/login_cubit/login_cubit.dart';
import '../../bloc/login_cubit/login_states.dart';
import '../../themes.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_ttf.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(listener: (context, state) {

        if (state is RegisterSucState) {
          Navigator.pop(context);
          // showToast('Register Suc', Colors.green);

        }
        if(state is RegisterErrorState){
          // showToast(state.error, Colors.red);

        }
      }, builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is RegisterLoadingState,
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
                        Text('Register',
                            style: primaryStyle.copyWith(fontSize: 35)),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultTTF(
                            controller: nameController,
                            label: 'Enter Your Name',
                            prefixIcon:
                                const Icon(Icons.verified_user_outlined)),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultTTF(
                          controller: phoneController,
                          label: 'Enter Your Phone',
                          prefixIcon: const Icon(Icons.phone),
                        ),
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
                                LoginCubit.get(context).userRegister(
                                    nameController.text,
                                    phoneController.text,
                                    emailController.text,
                                    passwordController.text);
                              }
                            },
                            label: 'Register')
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
