import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_cubit/home_cubit.dart';
import 'package:shop_app/bloc/home_cubit/home_states.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/themes.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'Shop App',
                style: primaryStyle,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                      CacheHelper.deleteDate('alToken');
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ))
              ],
            ),
            backgroundColor: Colors.white,
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.blueAccent,
              onTap: (index) {
                cubit.changeNav(index);
              },
              items: cubit.bottoms,
            ),
          );
        });
  }
}
