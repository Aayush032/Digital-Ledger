import 'package:flutter/material.dart';

class CrDbCard extends StatelessWidget {
  final Color cardColor;
  final String type;
  final String value;
  final IconData icon;
  const CrDbCard({
    super.key,
    required this.cardColor,
    required this.type,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 6,
        //shadowColor: Colors.black,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        color: cardColor.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:12.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(color: cardColor, fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                        color: cardColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Icon(icon, color: cardColor, size: 28,),
            ],
          ),
        ),
      ),
    );
  }
}
