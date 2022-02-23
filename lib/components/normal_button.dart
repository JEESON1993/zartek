import 'package:flutter/material.dart';

Widget ButtonNormal(
  text1,
  Function()? onPressed1,
  colore,
) {
  return MaterialButton(
    color: colore,
    padding: EdgeInsets.only(left: 120, right: 120, top: 12, bottom: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    onPressed: onPressed1,
    child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Text(
          text1,
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
  );
}
