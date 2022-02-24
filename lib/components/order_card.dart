import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';

class OrderSummaryCard extends StatelessWidget {
  var isveg, dishname, price, ordercount, pricepluscount, calories;
  Function(num)? onChangedorder;
  OrderSummaryCard(
      {Key? key,
      this.isveg,
      this.dishname,
      this.onChangedorder,
      this.price,
      this.ordercount,
      this.pricepluscount,
      this.calories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  isveg == 1
                      ? SvgPicture.asset('assets/veg.svg',
                          height: 20, width: 20)
                      : SvgPicture.asset('assets/nonveg.svg',
                          height: 20, width: 20),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 150,
                      height: 50,
                      child: Text(
                        dishname.toString(),
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'INR ' + pricepluscount.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    calories.toString() + 'Calories',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
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
                    value: ordercount,
                    textStyle:
                        const TextStyle(fontSize: 16, color: Colors.white),
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
                    onChanged: onChangedorder),
              ),
              SizedBox(
                width: 25,
              ),
              Text('INR ' + price.toString()),
            ],
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
