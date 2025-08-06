import 'package:flutter/material.dart';

Widget icons(IconData icon) {
  return Builder(
    builder: (context) {
      return InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Icon(
            icon,
            size: 24,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      );
    },
  );
}
