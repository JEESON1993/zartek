import 'package:flutter/material.dart';

Widget Button(text1, Function()? onPressed1, colore, logoimage, color1) {
  return MaterialButton(
    color: colore,
    padding: EdgeInsets.only(top: 10, bottom: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    onPressed: onPressed1,
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            margin: EdgeInsets.only(left: 20),
            child: CircleAvatar(
                backgroundColor: color1,
                child: Image.asset(
                  logoimage,
                  scale: 5,
                ))),
        SizedBox(
          width: 80,
        ),
        Container(
            margin: EdgeInsets.only(right: 20),
            child: Text(
              text1,
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
      ],
    ),
  );
}
