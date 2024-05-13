import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast extends StatefulWidget {
  const ShowToast({super.key,});

  @override
  State<ShowToast> createState() => _ShowToastState();
}

class _ShowToastState extends State<ShowToast> {
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context); // Initialize fToast here

    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Toast Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showToast,
          child: const Text('Show Toast'),
        ),
      ),
    );
  }

  void _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(width: 12.0),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );

    // Custom Toast Position
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      positionedToastBuilder: (context, child) {
        return Positioned(
          top: 16.0,
          left: 16.0,
          child: child,
        );
      },
    );
  }
}
