import 'package:flutter/material.dart';
import 'package:flutter_cart_bloc/bloc/cart_bloc.dart';
import 'package:flutter_cart_bloc/bloc/cart_provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartBloc cartBloc = CartProvider.of(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: StreamBuilder(
          stream: cartBloc.cartList,
          builder: (context, snapshot) {
            int sum = 0;
            if (snapshot.data!.isNotEmpty) {
              sum = snapshot.data!.map((item) => item.price).reduce((acc, e) => acc + e);
            }
            return Center(
              child: Text(
                '합계 : $sum',
                style: const TextStyle(fontSize: 30),
              ),
            );
          },
        ));
  }
}
