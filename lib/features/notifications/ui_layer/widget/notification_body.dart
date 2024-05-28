import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:second_task_todo_listapp/core/text_styles/text_styles.dart';

class NotificationBanner extends StatefulWidget {
  final String message;
  final String body;
  final Duration duration;

  const NotificationBanner(
      {super.key,
      required this.message,
      this.duration = const Duration(seconds: 10),
      required this.body});

  @override
  _NotificationBannerState createState() => _NotificationBannerState();
}

class _NotificationBannerState extends State<NotificationBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();

    Future.delayed(widget.duration, () {
      _controller.reverse().then((_) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        borderOnForeground: true,
        borderRadius: BorderRadius.all(Radius.circular(19.r)),
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            title: Text(widget.message,
                style: Styles.semiBlod(fontSize: 15, color: Colors.black)),
            subtitle: Text(
              widget.body,
              style: Styles.normal(fontSize: 13, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
