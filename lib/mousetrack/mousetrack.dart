import 'package:flutter/cupertino.dart';
import 'dart:html' as html;

import 'package:flutter/material.dart';


class MouseTrack extends StatefulWidget {
  const MouseTrack({Key? key}) : super(key: key);

  @override
  State<MouseTrack> createState() => _MouseTrackState();
}

class _MouseTrackState extends State<MouseTrack> {
  double dx = 0.0;
  double dy = 0.0;

  bool isOut = true;
  @override
  void initState() {
    html.document.documentElement!.addEventListener('mouseleave', (event) {
      setState(() {
        isOut = true;
      });
    });
    html.document.documentElement!.addEventListener('mouseenter', (event) {
      setState(() {
        isOut = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MouseRegion(
          onHover: (event) {
            setState(() {
              dx = event.localPosition.dx;
              dy = event.localPosition.dy;
            });
          },
          child: GestureDetector(
            onTap: (){
              print('object');
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          top: dy,
          left: dx,
          curve: Curves.easeOut,
          child: AnimatedContainer(

            duration: const Duration(milliseconds: 400),
            height: isOut ? 0.0 : 9.0,
            width: isOut ? 0.0 : 9.0,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20.0),
            ),

          ),
        ),
      ],
    );
  }
}
