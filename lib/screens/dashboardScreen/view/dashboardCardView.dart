import 'package:flutter/material.dart';
import 'package:co_ofline/utility/constant/color.dart';


class Dashboard_card extends StatefulWidget {
  const Dashboard_card(
      {super.key,
        required this.mqh,
        required this.mqw,
        required this.title,
        required this.number});

  final double mqh;
  final double mqw;
  final String title;
  final dynamic number;

  @override
  State<Dashboard_card> createState() => _Dashboard_cardState();
}

class _Dashboard_cardState extends State<Dashboard_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.mqh * 417 / 2340,
      width: widget.mqw * 970 / 1080,
      decoration: BoxDecoration(
          color: kGrey.withOpacity(0.025),
          borderRadius: BorderRadius.circular(13)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
            EdgeInsets.only(left: widget.mqw * 92 / 1080, top: widget.mqh * 60 / 2340),
            child: Text(
              widget.title,
              style: const TextStyle(
                  fontWeight: FontWeight.w800, color: kBlue, fontSize: 20.4),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: widget.mqw * 700 / 1080,
                bottom: widget.mqh * 10 / 2340,
                top: widget.mqh * 120 / 2340,
                right: widget.mqw * 70 / 2340),
            child: SizedBox(
              height: widget.mqh * 100 / 2340,
              width: widget.mqw * 300 / 1080,
              child: Center(
                child: Text(
                  '${widget.number}',
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, color: kBlue, fontSize: 18.5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}