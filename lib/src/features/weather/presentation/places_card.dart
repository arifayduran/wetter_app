import 'package:flutter/material.dart';

class PlacesCard extends StatefulWidget {
  const PlacesCard({super.key, required this.text});

  final String text;

  @override
  State<PlacesCard> createState() => _PlacesCardState();
}

class _PlacesCardState extends State<PlacesCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/wolken_card.jpeg"),
                fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            widget.text,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
