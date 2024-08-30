import 'package:flutter/material.dart';

void showDescriptionAlert(BuildContext context, Color color, text) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: color.withOpacity(0.8),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Heutige Wetteraussicht",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          content: SizedBox(
            width: 90,
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
