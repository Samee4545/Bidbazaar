import 'package:flutter/material.dart';

Widget productQuantityHandlerView(context, IconData icon, bool increase) {
  return Container(
    height: 28,
    width: 28,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(12), right: Radius.circular(12)),
      border: Border.all(
        color: increase ? Colors.orange : Colors.black.withOpacity(.9),
        width: 1,
      ),
    ),
    child: Center(
      child: Icon(
        icon,
        color: increase ? Colors.orange : Colors.black.withOpacity(.9),
      ),
    ),
  );
}
