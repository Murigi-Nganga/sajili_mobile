import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.cardText,
    required this.onTap,
    required this.cardIcon,
  });

  final String cardText;
  final void Function()? onTap;
  final IconData cardIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal[600],
      elevation: 5,
      shadowColor: Theme.of(context).colorScheme.secondary,
      child: SizedBox(
        height: 90,
        width: 110,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cardText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Icon(
                cardIcon,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}