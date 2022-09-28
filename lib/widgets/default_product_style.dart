import 'package:flutter/material.dart';
import 'package:shop_app/bloc/home_cubit/home_cubit.dart';

import '../models/home_model.dart';
import '../themes.dart';

class ProductStyle extends StatelessWidget {
   ProductStyle(
      {Key? key, this.element,this.onTap})
      : super(key: key);

  final Products? element ;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, 'ProDetails',arguments: element);
      },
      child: Column(
        children: [
          Image.network(
            '${element!.image}',
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height / 5,
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            '${element!.name}',
            style: primaryStyle.copyWith(fontSize: 20, height: 1),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '\$ ${element!.price}',
                  style: primaryStyle.copyWith(
                      fontSize: 16, height: 1, color: Colors.blueAccent),
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    HomeCubit.get(context).addToFav(element);
                  },
                  child: CircleAvatar(
                      backgroundColor: HomeCubit.get(context).fav.contains(element) ? Colors.blueAccent : Colors.grey,
                      child: const Icon(Icons.favorite_border)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
