import 'package:flutter/material.dart';

enum DialogType {
  error,
}

class Dialogs extends StatefulWidget {
  final DialogType type;
  final String message;

  const Dialogs({
    super.key,
    required this.type,
    required this.message,
  });

  @override
  State<Dialogs> createState() => _DialogsState();
}

class _DialogsState extends State<Dialogs> {
  @override
  Widget build(BuildContext context) {
    Widget dialogWidget;

    switch (widget.type) {
      case DialogType.error:
        dialogWidget = _buildErrorDialog();
        break;
      default:
        dialogWidget = Container();
    }

    return dialogWidget;
  }

  Widget _buildErrorDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.black, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.close, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              widget.message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
