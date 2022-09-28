
import 'package:flutter/material.dart';

import '../models/home_model.dart';
import '../themes.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Products model = ModalRoute.of(context)!.settings.arguments as Products;

    return Scaffold(
      appBar: AppBar(
        title:  Text(model.name!,style: primaryStyle,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder:(context,index)=>
                              Image.network(
                                model.images![index],
                                fit: BoxFit.cover,
                              ),itemCount: model.images!.length,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Positioned(
                  top: 260,
                  left: 10,
                  child: Row(
                    children: [
                      Text(
                        ' Price  ',
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: primaryStyle.copyWith(fontSize: 18),
                      ),
                      Text(
                        model.price!.toString(),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: primaryStyle.copyWith(fontSize: 18),
                      ),
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.red,
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                      model.description!,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: primaryStyle.copyWith(fontSize: 18),
                    )),
              ],
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
