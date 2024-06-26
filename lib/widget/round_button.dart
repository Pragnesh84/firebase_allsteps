import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const RoundButton({super.key,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w200,fontSize: 12),),),
      ),
    );
  }
}
