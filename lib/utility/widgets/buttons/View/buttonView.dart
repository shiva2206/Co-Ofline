import 'package:co_ofline/utility/constant/color.dart';
import 'package:flutter/material.dart';




Widget CustomElevatedButton(
    {required String title, required IconData icon, required onClick, required ButtonStyle style}) {
  return Container(
    width: 220,
    child: ElevatedButton(
      onPressed: onClick,
      style:
      ButtonStyle(backgroundColor: MaterialStateProperty.all(kWhite)),
      child: Row(
        children: [
          Icon(
            icon,
            color: kGrey,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(color: kGrey),
          )
        ],
      ),
    ),
  );
}