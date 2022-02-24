import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartech_machine_test/authentication.dart';
import 'package:zartech_machine_test/components/cart_card2.dart';
import 'package:zartech_machine_test/components/category_card.dart';
import 'package:zartech_machine_test/constants/appconstants.dart';
import 'package:zartech_machine_test/provider/cart_provider.dart';
import 'package:zartech_machine_test/provider/product_provider.dart';
import 'package:zartech_machine_test/screens/order_summary_page.dart';
import 'package:zartech_machine_test/screens/user_authentication_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  var store;

  List productlist = [];

  var _tabController;

  int indexvalue = 0;

  List categoryList = [];

  num valuespinner = 0;
  var qty;
  @override
  void initState() {
    // TODO: implement initState
    fetchProducts();

    super.initState();
  }

  Future fetchProducts() async {
    try {
      final Uri url = Uri.https(
        baseUrl,
        apiUrl + "5dfccffc310000efc8d2c1ad",
      );
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      var res = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        store = jsonDecode(response.body);
        setState(() {
          productlist = store[0]['table_menu_list'];
        });

        print(categoryList);
      }
    } catch (e) {
      print(e);
    }
  }

  //TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final getmodel = Provider.of<CartProvider>(context, listen: false);

    var item;
    void addtocart(
        {dishname,
        dishprice,
        description,
        calory,
        isveg,
        dishimage,
        isaddon,
        qty}) {
      item = {
        'dishname': dishname,
        'dishprice': dishprice,
        'description': description,
        'calory': calory,
        'isveg': isveg,
        'dishimage': dishimage,
        'isaddon': isaddon,
        'qty': qty
      };

      getmodel.addItem(item: item);
      print(getmodel.cart);
    }

    void deleteItem(
        {dishname,
        dishprice,
        description,
        calory,
        isveg,
        dishimage,
        isaddon,
        qty}) {
      item = {
        'dishname': dishname,
        'dishprice': dishprice,
        'description': description,
        'calory': calory,
        'isveg': isveg,
        'dishimage': dishimage,
        'isaddon': isaddon,
        'qty': qty
      };

      getmodel.deleteItemCart(item);
      print(getmodel.cart);
    }

    void showMessage(String message) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(message),
              actions: [
                TextButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }

    return DefaultTabController(
        length: productlist.length,
        child: Scaffold(
          //resizeToAvoidBottomInset: true,
          key: _key,
          drawer: SafeArea(
            child: Drawer(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                user != null ? user!.photoURL!.toString() : ''),
                            radius: 30,
                          ),
                          Text(user != null
                              ? user!.displayName!.toString()
                              : ''),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Text('ID :'),
                                Text(user != null ? user!.uid.toString() : ''),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Logout')
                        ],
                      ),
                      onTap: () async {
                        FirebaseService service = new FirebaseService();
                        try {
                          await service.signOutFromGoogle();
                          //print(result);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                          print('ok');
                        } catch (e) {
                          if (e is FirebaseAuthException) {
                            showMessage(e.message!);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () => _key.currentState!.openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.grey[800],
                  )),
              actions: [
                Stack(
                  children: [
                    Consumer<CartProvider>(builder: (context, data, child) {
                      return Container(
                        margin: EdgeInsets.only(right: 10, top: 4),
                        child: IconButton(
                            onPressed: () {
                              if (data.cart.length != 0)
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CartSummaryPage()));
                            },
                            icon: Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: Colors.grey[800],
                            )),
                      );
                    }),
                    Consumer<CartProvider>(builder: (context, data, child) {
                      return Positioned(
                          top: 4,
                          right: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 10,
                            child: Text(data.cart.length.toString()),
                          ));
                    })
                  ],
                )
              ],
              bottom: TabBar(
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Color(0xffed1a4f), width: 2)),
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                controller: _tabController,
                labelColor: Color(0xffed1a4f),
                labelStyle:
                    TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: productlist.map((menulist1) {
                  return Tab(
                    text: menulist1["menu_category"].toString(),
                  );
                }).toList(),
              )),
          body: productlist.isNotEmpty
              ? TabBarView(
                  controller: _tabController,
                  children: productlist.map((menulist) {
                    setState(() {
                      categoryList = menulist['category_dishes'];
                    });
                    return SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: categoryList.map((menulist1) {
                            return Consumer<CartProvider>(
                                builder: (context, data, child) {
                              qty = data.cart.firstWhere(
                                  (element) =>
                                      element["dishname"] ==
                                      menulist1['dish_name'], orElse: () {
                                return null;
                              });
                              return CartCard(
                                dishname: menulist1['dish_name'],
                                dishprice: menulist1['dish_price'],
                                description: menulist1['dish_description'],
                                calory: menulist1['dish_calories'],
                                isveg: menulist1['dish_Type'],
                                dishimage: menulist1['dish_image'],
                                isaddon: menulist1['addonCat'],
                                spinnervalue: qty == null ? 0 : qty["qty"],
                                onChanged1: (val) {
                                  // print(menulist1);

                                  if (val == 0) {
                                    deleteItem(
                                        dishname: menulist1['dish_name'],
                                        dishprice: menulist1['dish_price'],
                                        description:
                                            menulist1['dish_description'],
                                        calory: menulist1['dish_calories'],
                                        dishimage: menulist1['dish_image'],
                                        isveg: menulist1['dish_Type'],
                                        //isaddon: menulist1['addonCat'],
                                        qty: val);
                                  } else {
                                    addtocart(
                                        dishname: menulist1['dish_name'],
                                        dishprice: menulist1['dish_price'],
                                        description:
                                            menulist1['dish_description'],
                                        calory: menulist1['dish_calories'],
                                        dishimage: menulist1['dish_image'],
                                        isveg: menulist1['dish_Type'],
                                        //isaddon: menulist1['addonCat'],
                                        qty: val);
                                  }
                                  //print(getmodel.cart);
                                },
                              );
                            });
                            // CategoryCard(
                            //   dishname: menulist1['dish_name'],
                            //   dishprice: menulist1['dish_price'],
                            //   description: menulist1['dish_description'],
                            //   calory: menulist1['dish_calories'],
                            //   isveg: menulist1['dish_Type'],
                            //   dishimage: menulist1['dish_image'],
                            //   isaddon: menulist1['addonCat'],
                            //   spinnervalue: getmodel.qty == null
                            //       ? 0
                            //       : getmodel.qty['qty'],
                            //   onChanged1: (val) {
                            //     // print(menulist1);
                            //     qty = val;
                            //     if (val == 0) {
                            //       deleteItem(
                            //           dishname: menulist1['dish_name'],
                            //           dishprice: menulist1['dish_price'],
                            //           description:
                            //               menulist1['dish_description'],
                            //           calory: menulist1['dish_calories'],
                            //           dishimage: menulist1['dish_image'],
                            //           isveg: menulist1['dish_Type'],
                            //           //isaddon: menulist1['addonCat'],
                            //           qty: val);
                            //     } else {
                            //       addtocart(
                            //           dishname: menulist1['dish_name'],
                            //           dishprice: menulist1['dish_price'],
                            //           description:
                            //               menulist1['dish_description'],
                            //           calory: menulist1['dish_calories'],
                            //           dishimage: menulist1['dish_image'],
                            //           isveg: menulist1['dish_Type'],
                            //           //isaddon: menulist1['addonCat'],
                            //           qty: val);
                            //     }
                            //     //print(getmodel.cart);
                            //   },
                            // );
                          }).toList()),
                    );
                  }).toList(),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Color(0xffed1a4f),
                    strokeWidth: 1.2,
                  ),
                ),
        ));
  }
}
