import 'package:flutter/material.dart';

class BoxedButton extends StatelessWidget {
  const BoxedButton({super.key,required,required this.onClick,required this.buttonText,required this.width,
  required this.height,required this.fillColor, required this.isButtonEnabled,required this.textColor,required this.padding});
  final void Function() onClick;
  final String buttonText;
  final double? height;
  final double? width;
  final Color? fillColor;
  final bool isButtonEnabled;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: padding,
          child: OutlinedButton(onPressed: (){
            onClick();
          },
              style: OutlinedButton.styleFrom(
                  backgroundColor: fillColor ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  )
              ),
              child: isButtonEnabled ? Text(buttonText,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)) : CircularProgressIndicator())
    ));
  }
}
