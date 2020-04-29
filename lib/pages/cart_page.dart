import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provide/cart.dart';
import 'cart_widget/cart_item.dart';
import 'cart_widget/cart_bottom.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Consumer<CartProvider>(
                  builder: (context, cartInfo, child) {
                    return ListView.builder(
                      itemCount: cartInfo.cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(item: cartInfo.cartList[index]);
                      }
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                )
              ],
            );
          }else {
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvider>(context, listen: false).getCartInfo();
    return 'end';
  }
}