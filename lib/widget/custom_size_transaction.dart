
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';

class CustomSizeTransaction extends StatefulWidget {

  final Widget? child;
  final bool open;

  CustomSizeTransaction({this.child, this.open = false});

  @override
  CustomSizeTransactionState createState() => CustomSizeTransactionState();
}

class CustomSizeTransactionState extends State<CustomSizeTransaction> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimation.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: AppAnimation.curve,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.open) {
        _controller.forward();
      }
    });
  }

  @override
  void didUpdateWidget(covariant CustomSizeTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.open) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      child: widget.child,
    );
  }
}
