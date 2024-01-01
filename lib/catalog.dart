import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/bloc/cart_bloc.dart';
import 'package:flutter_cart_bloc/cart.dart';
import 'package:flutter_cart_bloc/item.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  final List<Item> _itemList = itemList;

  @override
  Widget build(BuildContext context) {
    final _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Cart()));
              },
              icon: const Icon(Icons.archive)),
        ],
      ),
      body: BlocBuilder<CartBloc, List<Item>>(
        bloc: _cartBloc,
        builder: (BuildContext context, List state) {
          return Center(
            child: ListView(
              children: _itemList
                  .map(
                    (item) => _buildItem(item, state, _cartBloc),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(Item todo, List state, CartBloc cartBloc) {
    final isChecked = state.contains(todo);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(
          todo.title,
          style: const TextStyle(fontSize: 31),
        ),
        subtitle: Text('${todo.price}'),
        trailing: IconButton(
          icon: isChecked
              ? const Icon(
                  Icons.check,
                  color: Colors.red,
                )
              : const Icon(Icons.check),
          onPressed: () {
            setState(() {
              if (isChecked) {
                cartBloc.add(CartEvent(CartEventType.remove, todo));
              } else {
                cartBloc.add(CartEvent(CartEventType.add, todo));
              }
            });
          },
        ),
      ),
    );
  }
}
