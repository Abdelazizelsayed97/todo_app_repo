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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        confirmDismiss: (direction) async {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm"),
                content:
                    const Text("Are you sure you want to delete this item?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("CANCEL"),
                  ),
                  TextButton(
                    onPressed: () {
                      onDelete();
                      Navigator.of(context).pop();
                    },
                    child: const Text("DELETE"),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) {
          onDelete();
        },
        child: child);
  }
}
