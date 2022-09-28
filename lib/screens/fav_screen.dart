import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_cubit/home_cubit.dart';
import 'package:shop_app/bloc/home_cubit/home_states.dart';

import '../widgets/default_product_style.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener:(context, state) {},
      builder: (context, state) {
        return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.height / 2.4,
                childAspectRatio: .9,
                mainAxisSpacing: 5,
                crossAxisSpacing: 6),
            itemCount: HomeCubit.get(context).fav.length,
            itemBuilder: (context, index) {
              return ProductStyle(
                element: HomeCubit.get(context).fav[index],
              )
              ;
            });
      }
    );
  }
}
