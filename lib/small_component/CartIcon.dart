import 'package:book_app/provider/card_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Carticon extends ConsumerWidget {
  const Carticon({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {

    final inCart = ref.watch(cardNotifierProvider).length;
    return Container(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          const Icon(Icons.shopping_bag_rounded , size: 30,),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: Colors.red[800],
              shape: BoxShape.circle
            ),
            alignment: Alignment.center,
            child: Text(inCart.toString()),
          )
        ],
      ),
    );
  }
}
