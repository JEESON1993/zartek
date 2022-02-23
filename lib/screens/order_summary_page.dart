import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartech_machine_test/components/button.dart';
import 'package:zartech_machine_test/components/category_card.dart';
import 'package:zartech_machine_test/components/normal_button.dart';
import 'package:zartech_machine_test/components/order_card.dart';
import 'package:zartech_machine_test/provider/cart_provider.dart';
import 'package:zartech_machine_test/screens/home_screen.dart';

class CartSummaryPage extends StatefulWidget {
  const CartSummaryPage({Key? key}) : super(key: key);

  @override
  _CartSummaryPageState createState() => _CartSummaryPageState();
}

var itemtotal;

class _CartSummaryPageState extends State<CartSummaryPage> {
  bool isLoading = false;

  showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            'Order Summary',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        body: Consumer<CartProvider>(builder: (context, data, child) {
          var itemtotal = data.cart
              .map((item) => item["qty"])
              .fold(0, (prev, amount) => amount + prev);
          double grandtotal = data.cart
              .map((item) => item['dishprice'] * item['qty'])
              .fold(0, (prev, amount) => amount + prev);
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.green,
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              itemtotal.toString() + ' Dishes',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              ' - ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              data.cart.length.toString() + ' Items',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.cart.length,
                          itemBuilder: (BuildContext context, index) {
                            return OrderSummaryCard(
                              dishname: data.cart[index]['dishname'],
                              price: data.cart[index]['dishprice'],
                              ordercount: data.cart[index]['qty'],
                              pricepluscount: data.cart[index]['dishprice'] *
                                  data.cart[index]['qty'],
                              calories: data.cart[index]['calory'],
                              isveg: data.cart[index]['isveg'],
                              onChangedorder: null,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Items Total',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                            Text(
                              grandtotal.floorToDouble().toString() + '/-',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Divider(
                          thickness: 1.2,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ButtonNormal('Place Order', () {
                    // Timer(Duration(seconds: 20),
                    //     showMessage('Order successfully placed'));
                    data.cart.clear();
                    showMessage('Order successfully placed');
                  }, Colors.green),
                )
              ],
            ),
          );
        }));
  }
}
