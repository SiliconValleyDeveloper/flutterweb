import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({Key? key}) : super(key: key);

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton>  with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _defaultTweenAnimation;
  late Animation<double> _containerScaleTweenAnimation;
  late Animation<double> _containerAlignTweenAnimation;
  late Animation<double> _containerBorderRadiusAnimation;
  late Animation<double> _iconAlignAnimation;
  late Animation<double> _cancelIconScaleAnimation;
   late Animation<double> _cancelIconRotateAnimation;

  late Animation<double> _curvedAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 375,
      ),
    );
    _curvedAnimation = CurvedAnimation(parent: _controller, curve: Curves.ease);
    _defaultTweenAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_curvedAnimation);
    _containerScaleTweenAnimation =
        Tween(begin: 59.0, end: 200.0).animate(_curvedAnimation);
    _containerAlignTweenAnimation =
        Tween(begin: 0.0, end: -1.0).animate(_curvedAnimation);
    _containerBorderRadiusAnimation =
        Tween(begin: 100.0, end: 15.0).animate(_curvedAnimation);
    _iconAlignAnimation =
        Tween(begin: 0.0, end: 1.51).animate(_curvedAnimation);
    _cancelIconScaleAnimation =
        Tween(begin: 0.0, end: 30.0).animate(_curvedAnimation);
    _cancelIconRotateAnimation =
        Tween(begin: 0.0, end: math.pi).animate(_curvedAnimation);
    super.initState();
  }

  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SizedBox(
          height: 270.0,
          width: 200.0,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _containerScaleTweenAnimation,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment(_containerAlignTweenAnimation.value,
                        _containerAlignTweenAnimation.value),
                    child: Container(
                      height: _containerScaleTweenAnimation.value,
                      width: _containerScaleTweenAnimation.value,
                      padding: const EdgeInsets.all(8.0),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(
                            _containerBorderRadiusAnimation.value),
                      ),
                      child: child,
                    ),
                  );
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ShareableLinks(
                        title: 'TikTok',
                        icon: 'assets/TikTok.png',
                        index: 1,
                        isOpened: isOpened,
                      ),
                      ShareableLinks(
                        title: 'Tinder',
                        icon: 'assets/Tinder.png',
                        index: 2,
                        isOpened: isOpened,
                      ),
                      ShareableLinks(
                        title: 'Discord',
                        icon: 'assets/Discord.png',
                        index: 3,
                        isOpened: isOpened,
                        onTap: () {
                          print('3');
                        },
                      ),
                      ShareableLinks(
                        title: 'Pinterest',
                        icon: 'assets/Pinterest.png',
                        index: 4,
                        isOpened: isOpened,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _defaultTweenAnimation,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment(_defaultTweenAnimation.value,
                        _defaultTweenAnimation.value),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (_controller.isDismissed) {
                            isOpened = true;
                            _controller.forward();
                          } else if (_controller.isCompleted) {
                            isOpened = false;
                            _controller.reverse();
                          }
                        });
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Opacity(
                              opacity: _defaultTweenAnimation.value,
                              child: Transform.rotate(
                                angle: _cancelIconRotateAnimation.value,
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.black87,
                                  size: _cancelIconScaleAnimation.value,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            alignment: Alignment(_iconAlignAnimation.value,
                                -_iconAlignAnimation.value),
                            clipBehavior: Clip.antiAlias,
                            child: SvgPicture.asset(
                              'assets/share.svg',
                              width: 25.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareableLinks extends StatefulWidget {
  final int index;
  final String title;
  final String icon;
  final bool isOpened;
  final Function? onTap;
  const ShareableLinks({
    Key? key,
    required this.index,
    required this.title,
    required this.icon,
    required this.isOpened,
    this.onTap,
  }) : super(key: key);

  @override
  State<ShareableLinks> createState() => _ShareableLinksState();
}

class _ShareableLinksState extends State<ShareableLinks>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 375,
      ),
    );
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isOpened) {
      Future.delayed(Duration(milliseconds: widget.index * 200), () {
        _controller.forward();
      });
    } else {
      _controller.reverse();
    }
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          alignment: Alignment.centerLeft,
          scale: _animation.value,
          child: Opacity(
            opacity: _animation.value,
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: (){
                  widget.onTap == null ? (){} : widget.onTap!();
                },
                child: Container(
                  height: 45.0,
                  padding: const EdgeInsets.all(8.0),
                  child: OverflowBox(
                    minWidth: 160.0,
                    maxWidth: 161.0,
                    maxHeight: 50.0,
                    minHeight: 49.0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance,
                          size: 30.0,
                          color: Colors.grey,
                          //fit: BoxFit.contain,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.title,
                          style: GoogleFonts.overpass(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}