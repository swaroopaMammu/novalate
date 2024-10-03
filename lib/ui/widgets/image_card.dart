import 'package:flutter/material.dart';

class BorderedImageCard extends StatelessWidget {
  const BorderedImageCard({super.key,required this.imgUrl,required this.width, required this.height});
  final String imgUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          border: Border.all(
            color: Colors.black,
            width: 4,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],),
        child:  Image.network(imgUrl,fit: BoxFit.cover));
  }
}
