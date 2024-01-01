import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cart_bloc/item.dart';
import 'package:bloc/bloc.dart';

enum CartEventType { add, remove }

class CartEvent {
  final CartEventType type;
  final Item item;

  CartEvent(this.type, this.item);
}

class CartBloc extends Bloc<CartEvent, List<Item>> {
  CartBloc() : super([]);

  // @override
  // List<Item> get initialState => [];

  @override
  Stream<List<Item>> mapEventState(CartEvent event) async* {
    switch (event.type) {
      case CartEventType.add:
        state.add(event.item);
        break;
      case CartEventType.remove:
        state.remove(event.item);
        break;
    }
    yield state;
  }
}
