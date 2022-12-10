import 'package:clean_architecture/core/utils/app_colors.dart';
import 'package:clean_architecture/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';

class ErrorDesign extends StatelessWidget {
  final VoidCallback? onPressed ;
  const ErrorDesign({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: AppColors.primary,
            size: 150,
          ),
        ),
        Container(
          margin: const EdgeInsetsDirectional.symmetric(vertical: 12),
          child: const Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          'Please Try Again',
          style: TextStyle(
            color: AppColors.hint,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 55,
          width : context.width * .55,
          margin: const EdgeInsetsDirectional.symmetric(vertical: 15),
          child: ElevatedButton(
            onPressed: (){
              if(onPressed != null){
                onPressed!;
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )
            ),
            child:  const Text(
            'Reload Screen',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),
          ),),
        )
      ],
    );
  }
}
