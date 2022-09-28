import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/home_cubit/home_cubit.dart';
import 'package:shop_app/bloc/home_cubit/home_states.dart';

import '../themes.dart';
import '../widgets/default_product_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        if (cubit.categoryData == null && cubit.homeData == null) {
          cubit.getCategoryData();
          cubit.getHomeData(alToken);
        }

        return ConditionalBuilder(
          fallback: (_) => const Center(child: CircularProgressIndicator()),
          condition: cubit.homeData != null && cubit.categoryData != null,
          builder: (context) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildCarouselSlider(cubit, context),
                const SizedBox(
                  height: 10,
                ),
                buildCateSlider(cubit),
                const SizedBox(
                  height: 10,
                ),
                buildListProduct(context, cubit),
              ]
              // Image.network()
              ,
            ),
          ),
        );
      },
    );
  }

  Container buildCarouselSlider(HomeCubit cubit, context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3.5,
      child: CarouselSlider(
          items: cubit.homeData?.data?.banners
              ?.map((e) => Image.network('${e.image}'))
              .toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          )),
    );
  }

  Padding buildCateSlider(HomeCubit cubit) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext ctx, index) => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  image: DecorationImage(
                      image: NetworkImage(
                          '${cubit.categoryData!.data!.data![index].image}'),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                width: 100,
                color: Colors.black.withOpacity(.5),
                child: Text(
                  '${cubit.categoryData!.data!.data![index].name}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: primaryStyle.copyWith(height: 1.2, fontSize: 18),
                ),
              ),
            ],
          ),
          itemCount: cubit.categoryData!.data!.data!.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 5,
            );
          },
        ),
      ),
    );
  }

  GridView buildListProduct(BuildContext context, HomeCubit cubit) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.height / 2.4,
            childAspectRatio: .9,
            mainAxisSpacing: 5,
            crossAxisSpacing: 6),
        itemCount: cubit.homeData?.data?.products!.length,
        itemBuilder: (context, index) {
          return ProductStyle(
            element: cubit.homeData?.data?.products![index],
            )
          ;
        });
  }
}
