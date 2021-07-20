import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {

  bool isFav = false;
  AnimationController _controller;
  Animation _colourAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this
    );

    _colourAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
      .animate(_controller);

    //listener for _controller
    _controller.addListener(() {
      print(_controller.value);
      print(_colourAnimation.value);
    });

    // status listener
    _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isFav = true;
          });
        }
        if (status == AnimationStatus.dismissed) {
          setState(() {
            isFav = false;
          });
        }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colourAnimation.value,
            size: 30,
          ),
          onPressed: () {
            isFav ? _controller.reverse() : _controller.forward();
          },
        );
      }
    );
  }
}
