import 'package:flutter/material.dart';

import 'event_card_body.dart';

class EventsWidget extends StatefulWidget {
  const EventsWidget({super.key});

  @override
  State<EventsWidget> createState() => _EventsWidgetState();
}

class _EventsWidgetState extends State<EventsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: double.infinity,
      child: ListView.builder(


        itemBuilder: (context, index) {
        return const EventCardBody();
      },),
    );
  }
}
