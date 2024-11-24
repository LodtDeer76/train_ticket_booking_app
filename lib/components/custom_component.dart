import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/location.dart';

Widget buildDropdownInput({
  required BuildContext context,
  required String label,
  required Location? value,
  required List<Location> items,
  required ValueChanged<Location?> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 18)),
      const SizedBox(height: 10),
      DropdownButtonFormField<Location>(
        value: value,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        items: items.map<DropdownMenuItem<Location>>((Location location) {
          return DropdownMenuItem<Location>(
            value: location,
            child: Text(location.name),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    ],
  );
}

Widget buildDateInput({
  required BuildContext context,
  required String label,
  required DateTime date,
  required bool isDeparture,
  required bool isEnabled,
  required Function(bool) selectDate,
}) {
  return Row(
    children: [
      Text(label, style: const TextStyle(fontSize: 18)),
      const SizedBox(width: 20),
      Expanded(
        child: InkWell(
          onTap: isEnabled ? () => selectDate(isDeparture) : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              DateFormat('yyyy-MM-dd').format(date),
              style: TextStyle(
                fontSize: 16,
                color: isEnabled ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
