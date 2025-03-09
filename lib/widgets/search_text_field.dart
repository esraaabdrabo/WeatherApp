import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (_) => onSearch(),
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: onSearch,
          child: const Icon(Icons.search),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        hintText: 'Search a city',
        label: const Text('Search'),
        border: const OutlineInputBorder(borderSide: BorderSide(width: 1)),
      ),
    );
  }
}
