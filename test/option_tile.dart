import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String option;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(option,
            style: TextStyle(
                fontSize: 15,
                color: isSelected ? Colors.white : Colors.black)),
      ),
    );
  }
}
