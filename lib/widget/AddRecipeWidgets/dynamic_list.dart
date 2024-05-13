import 'package:flutter/material.dart';

class DynamicListWidget extends StatelessWidget {
  final List<String> items;
  final TextEditingController controller;
  final String hintText;
  final String label;
  final Function(String) onItemAdded;
  final Function(int) onItemRemoved;

  const DynamicListWidget({
    Key? key,
    required this.items,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.onItemAdded,
    required this.onItemRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontFamily: 'RalewayVariableFont', fontWeight: FontWeight.w700),
        ),
        ...items.asMap().entries.map((entry) {
          int idx = entry.key;
          String item = entry.value;
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onItemRemoved(idx),
            ),
          );
        }).toList(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: hintText,
                  hintStyle: const TextStyle(
                      fontFamily: 'RalewayVariableFont',
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  onItemAdded(controller.text);
                  controller.clear();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
