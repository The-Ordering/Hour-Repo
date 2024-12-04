import 'package:book_app/provider/card_notifier.dart';
import 'package:book_app/provider/products_provider.dart';
import 'package:book_app/small_component/CartIcon.dart';
import 'package:book_app/view/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final allProducts = ref.watch(productsProvider);
    final cardProducts = ref.watch(cardNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage(),));
              },
              child: const Carticon())
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: allProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 , childAspectRatio: 0.7),
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(10),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(24)
              ),
              child: Column(
                children: [
                  Image.asset(allProducts[index].image , height: 100,),
                  Text(allProducts[index].name),
                  Text("${allProducts[index].price}\$"),
                  if (cardProducts.contains(allProducts[index]))
                  TextButton(onPressed: () {
                    ref.read(cardNotifierProvider.notifier).removeFromCart(allProducts[index]);
                  }, child: const Text("Remove")),
                  if (!cardProducts.contains(allProducts[index]))
                  TextButton(onPressed: () {
                    ref.read(cardNotifierProvider.notifier).addToCart(allProducts[index]);
                  }, child: const Text("Add"))
                ],
              ),
            ),
        ),
      )
    );
  }
}
