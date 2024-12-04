import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product.dart';

class CardNotifier extends Notifier<Set<Product>> {

  @override
  Set<Product> build() {
    // TODO: implement build
    return {

    };
  }

  void addToCart (Product product) {
    if (!state.contains(product)) {
      state = {...state , product};
    }
  }

  void removeFromCart (Product product) {
    if(state.contains(product)) {
      state = state.where((p) {
        return p.id != product.id;
      }).toSet();
    }
  }
}

final cardNotifierProvider = NotifierProvider<CardNotifier,Set<Product>>(
    () {
      return CardNotifier();
    }
);