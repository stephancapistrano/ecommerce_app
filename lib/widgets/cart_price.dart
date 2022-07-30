import 'package:flutter/material.dart';
import 'package:project4lojavirtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Resumo do pedido", textAlign: TextAlign.start, style: TextStyle(fontWeight:  FontWeight.w500),),
                SizedBox(height: 12.0,)
              ],
            );
          }
        ),
      )
    );
  }
}