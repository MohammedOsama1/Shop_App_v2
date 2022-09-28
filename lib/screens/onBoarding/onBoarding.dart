import 'package:flutter/material.dart';
import 'package:shop_app/helpers/cache_helper.dart';
import 'package:shop_app/themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onBoarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> dataList = [
    OnBoardingModel(
        'On Boarding 1',
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ',
        'assets/on1.jpg'),
    OnBoardingModel(
        'On Boarding 2',
        'when an unknown printer took a galley of type and scrambled it to make a type specimen book., ',
        'assets/on2.jpg'),
    OnBoardingModel(
        'On Boarding 3',
        'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s ',
        'assets/on3.png'),
  ];

  PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: controller,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, index) =>
                    buildOn(dataList[index]),
                itemCount: 3,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: primaryClr,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryClr,
        onPressed: () {
          if (index == 2) {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            CacheHelper.addData('onState', 'passed');
          } else {
            controller.nextPage(
                duration: const Duration(milliseconds: 666),
                curve: Curves.fastLinearToSlowEaseIn);
          }
        },
        child: const Icon(Icons.arrow_forward_rounded),
      ),
    );
  }

  Column buildOn(OnBoardingModel dataList) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Image.asset(dataList.imgUrl),
      const SizedBox(
        height: 10,
      ),
      Text(
        dataList.title,
        style: primaryStyle,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        dataList.txt,
        style: primaryStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    ]);
  }
}
