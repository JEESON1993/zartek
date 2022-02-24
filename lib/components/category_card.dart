import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:provider/provider.dart';
import 'package:zartech_machine_test/provider/cart_provider.dart';

class CategoryCard extends StatelessWidget {
  var isveg,
      dishname,
      dishprice,
      calory,
      description,
      dishimage,
      isaddon,
      spinnervalue;
  Function(num)? onChanged1;
  CategoryCard(
      {Key? key,
      this.isveg,
      this.dishname,
      this.dishprice,
      this.calory,
      this.description,
      this.dishimage,
      this.isaddon,
      this.onChanged1,
      this.spinnervalue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    isveg == 1
                        ? SvgPicture.asset('assets/veg.svg',
                            height: 20, width: 20)
                        : SvgPicture.asset('assets/nonveg.svg',
                            height: 20, width: 20),
                    SizedBox(
                      height: 85,
                    )
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dishname.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text('INR ' + dishprice.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 130,
                        ),
                        Text(calory.toString() + ' Calories',
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                    Container(
                        width: 300,
                        height: 40,
                        child: Text(
                          description.toString(),
                          overflow: TextOverflow.clip,
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        )),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: TouchSpin(
                          min: 0,
                          max: 50,
                          step: 1,
                          value: 0,
                          textStyle: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          iconSize: 15.0,
                          addIcon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          subtractIcon: const Icon(
                            Icons.minimize,
                            color: Colors.white,
                          ),
                          iconActiveColor: Colors.green,
                          iconDisabledColor: Colors.grey,
                          iconPadding: const EdgeInsets.all(3),
                          onChanged: onChanged1),
                    ),
                    isaddon.isNotEmpty
                        ? Text(
                            'Customizations Available',
                            style: TextStyle(color: Colors.red),
                          )
                        : Text('')
                  ],
                ),
                SizedBox(
                  width: 1,
                ),
                Column(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.2, color: Colors.grey)),
                      child: Image.network(dishimage),
                    ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
