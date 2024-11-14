import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';

class AdditiveCard extends StatelessWidget {
  final String additiveNumber;
  final String name;

  const AdditiveCard({
    Key? key,
    required this.additiveNumber,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: AppColors.secondaryAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.info,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Text(
            additiveNumber,
            style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Roboto'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              maxLines: 1,
              name,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'Roboto',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
