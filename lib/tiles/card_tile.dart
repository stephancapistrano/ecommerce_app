import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project4lojavirtual/datas/cart_product.dart';
import 'package:project4lojavirtual/datas/product_data.dart';
import 'package:project4lojavirtual/models/cart_model.dart';

class CardTile extends StatelessWidget {

  final CartProduct cartProduct;
  CardTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    Widget _buildContent (){
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 8.0),
            width: 120.0,
            child: Image.network(cartProduct.productData.images[0], fit: BoxFit.cover,),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(cartProduct.productData.title, style: TextStyle(
                  fontSize: 17.0, fontWeight: FontWeight.w500
                )),
                Text("Tamanho ${cartProduct.size}", style: TextStyle(
                  fontSize: 15.0, fontWeight: FontWeight.w300
                )),
                Text("R\$ ${cartProduct.productData.price.toStringAsFixed(2)}", style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16.0, fontWeight: FontWeight.bold
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: Icon(Icons.remove), onPressed: cartProduct.quantity > 1 ? (){
                      CartModel.of(context).decProduct(cartProduct);
                    } : null),
                    Text(cartProduct.quantity.toString()),
                    IconButton(icon: Icon(Icons.add), onPressed: (){
                      CartModel.of(context).incProduct(cartProduct);
                    }),
                    FlatButton(child: Text("Remover",), textColor: Colors.grey[500], onPressed: (){
                      CartModel.of(context).removeCartItem(cartProduct);
                    })
                  ],
                )
              ],),
            )
          )
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection("products").document(cartProduct.category)
          .collection("itens").document(cartProduct.pid).get(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              cartProduct.productData = ProductData.fromDocument(snapshot.data);
              return _buildContent();
            } else {
              return Container(
                height: 70.0,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          },
        ) :
        _buildContent()
    );
  }
}