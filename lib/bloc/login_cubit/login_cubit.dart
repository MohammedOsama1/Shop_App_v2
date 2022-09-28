
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/login_cubit/login_states.dart';
import 'package:shop_app/helpers/dio_helper.dart';

import '../../models/login_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  bool showPassword = false;

  static LoginCubit get(context) => BlocProvider.of(context);

  void hidePassword() {
    showPassword = !showPassword;
    emit(HidePasswordSucState());
  }

  LoginModel? data;

  Future userLogin(email, password) async {
    emit(LoginLoadingState());
    return await DioHelper.postData(
        'login', {'email': email, 'password': password}).then((value) {
      data = LoginModel.fromJson(value.data);
      emit(LoginSucState(data!.data!.token!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  Future userRegister(name, phone, email, password) async {
    emit(RegisterLoadingState());
    await DioHelper.postData('register', {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone
    }).then((value) {
      print(value.statusCode);
      emit(RegisterSucState());

    }).catchError((error) {
      emit(RegisterErrorState());
    });
  }

}
