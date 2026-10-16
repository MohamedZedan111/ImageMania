import 'package:flutter/material.dart';

class SingleCardWidget extends StatelessWidget {
  const SingleCardWidget({
    ///SingleCardWidget or new
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });

  final String imagePath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  fit: BoxFit.cover,
                  imagePath,
                  height: 140,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(color: Colors.black87, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
