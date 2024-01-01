import 'package:flutter/material.dart';
import 'package:flutter_cart_bloc/bloc/cart_bloc.dart';
import 'package:flutter_cart_bloc/cart.dart';
import 'package:flutter_cart_bloc/item.dart';
import 'package:flutter_cart_bloc/main.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder(
          stream: cartBloc.cartList,
          builder: (context, snapshot) {
            if (snapshot.data == null){
              throw Exception('error');
            }
            return ListView(
              children: cartBloc.itemList
                  .map(
                    (item) => _buildItem(item, snapshot.data!),
                  )
                  .toList(),
            );
          },
        ));
  }

  Widget _buildItem(Item todo, List<Item> state) {
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
            if (isChecked) {
              cartBloc.add(CartEvent(CartEventType.remove, todo));
            } else {
              cartBloc.add(CartEvent(CartEventType.add, todo));
            }
          },
        ),
      ),
    );
  }
}
