import 'package:book_app/provider/card_notifier.dart';
import 'package:book_app/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cardProducts = ref.watch(cardNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: cardProducts.map((product) {
              return Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Image.asset(product.image , width: 50,height: 50,),
                    SizedBox(width: 20),
                    Text(product.name),
                    SizedBox(width: 20),
                    Text(product.price.toString()),

                    TextButton(
                        onPressed: () {
                          ref.read(cardNotifierProvider.notifier).removeFromCart(product);
                        },
                        child: Icon(Icons.remove_rounded))
                  ],
                ),
              );
            }).toList(),
          ),
      ),
    );
  }
}
