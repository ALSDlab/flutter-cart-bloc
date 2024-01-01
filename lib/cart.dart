import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/bloc/cart_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder(
        bloc: BlocProvider.of<CartBloc>(context),
        builder: (BuildContext context, List state) {
          var sum = 0;
          if (state.isNotEmpty) {
            sum = state.map((item) => item.price).reduce((acc, e) => acc + e);
          }
          return Center(
            child: Text(
              '합계 : $sum',
              style: const TextStyle(fontSize: 30),
            ),
          );
        },
      ),
    );
  }
}
