
import 'package:flutter/material.dart';
class ElevatedButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String? buttonLabel;
  final double? width;
  const ElevatedButtonWidget({super.key,this.onPressed,this.buttonLabel,this.width});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            minimumSize:Size(width??double.infinity,50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        onPressed: onPressed,
        child:Text(buttonLabel??'',style:const TextStyle(color: Colors.white,fontSize: 20) ,) );
  }
}
