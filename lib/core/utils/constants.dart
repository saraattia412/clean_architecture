import 'package:clean_architecture/core/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constants{

  static void showMessageDialog({
    required BuildContext context,
    required String msg
}){
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            msg,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                  style: TextButton.styleFrom(
                   textStyle: const TextStyle(
                     fontSize: 14,
                     fontWeight: FontWeight.bold,

                   ),
                  ),
                child: const Text('OK',),
                )
          ],
        ));
  }

  static void showToast({
    required String msg,
     Color? color,
}){
    Fluttertoast.showToast(
        msg: msg,
      backgroundColor: color ?? AppColors.primary,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      fontSize: 15,
      gravity: ToastGravity.BOTTOM
    );
  }


}