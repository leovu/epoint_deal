import 'package:flutter/material.dart';

class CustomInfoItem extends StatelessWidget {

  final String icon;
  final String title;

  CustomInfoItem({
    this.icon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 8.0),
      margin: EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            height: 15.0,
            width: 15.0,
            child: Image.asset(icon),
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal),
              // maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}