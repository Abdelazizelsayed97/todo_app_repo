import 'package:flutter/material.dart';

class DismissibleListItem extends StatelessWidget {
  const DismissibleListItem({
    super.key,
    required this.onDelete,
    required this.child,
  });

  final Widget child;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (direction) {
          onDelete();
        },
        child: child);
  }
}
