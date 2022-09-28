import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_cubit/home_cubit.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/screens/layout_screen.dart';
import 'package:shop_app/themes.dart';

import 'screens/authentication_screens/login_screen.dart';
import 'screens/authentication_screens/register_screen.dart';
import 'screens/onBoarding/onBoarding.dart';
import 'screens/product_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();

  if (CacheHelper.getData('onState') != null ) {
    onState = CacheHelper.getData('onState');
  }
  if (CacheHelper.getData('alToken') != null ) {
    alToken = CacheHelper.getData('alToken');
  }

  runApp(MyApp(token: alToken,onState: onState,));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.token, required this.onState,
  }) : super(key: key);
  final String token;
  final String onState;


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: primaryClr,
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark)),
          primarySwatch: Colors.blue,
        ),
        initialRoute: onState == 'empty' ? '/on' :token == 'empty' ? '/login' : '/layout',
        routes: {
          '/on': (context) => const OnBoardingScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/layout': (context) => const LayoutScreen(),
          'ProDetails': (context) => const ProductDetailsScreen()
        },
      ),
    );
  }
}
