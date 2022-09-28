import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_cubit/home_states.dart';

import '../bloc/home_cubit/home_cubit.dart';
import '../themes.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          if (cubit.categoryData == null) {
            cubit.getCategoryData();
          }
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.7,
                  mainAxisSpacing: 10,
                ),
                itemCount: cubit.categoryData!.data!.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, '3',arguments: category[index]);
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            child: Image.network(
                              '${cubit.categoryData!.data!.data![index].image}',
                              fit: BoxFit.cover,
                              width: 200,
                              height: 200,
                            )),
                        Positioned(
                          top: 84,
                          child: Container(
                              color: Colors.black,
                              child: Text(
                                '${cubit.categoryData!.data!.data![index].name}',
                                style: primaryStyle.copyWith(
                                    color: Colors.white, fontSize: 17),
                              )),
                        )
                      ],
                    ),
                  );
                },
              ));
        });
  }
}
