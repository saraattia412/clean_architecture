import 'package:clean_architecture/features/random/domain/entities/quote.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class QuoteContent extends StatelessWidget {
  final Quote quote;
  const QuoteContent({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.all(20),
      padding: const EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child:   Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
           quote.content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.symmetric(vertical: 15),
            child:  Text(
              quote.author,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
