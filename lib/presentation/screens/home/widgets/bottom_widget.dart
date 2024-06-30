import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    super.key,
    required this.icon1,
    required this.icon2,
    required this.title1,
    required this.title2,
    required this.subTitle1,
    required this.subTitle2,
  });

  final String icon1;
  final String icon2;
  final String title1;
  final String title2;
  final String subTitle1;
  final String subTitle2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              icon1,
              scale: 12,
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subTitle1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Image.asset(
              icon2,
              scale: 12,
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subTitle2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
