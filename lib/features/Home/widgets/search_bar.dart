import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
    this.hintText = "What are you looking for...",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none),
      ),
      onChanged: onChanged,
    );
  }
}
