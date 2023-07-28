import 'package:flutter/material.dart';
import 'package:mticketbar/constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key, 
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
    Text(title,style: Theme.of(context).textTheme.subtitle1,
    ),
    ],
    ),
    const SizedBox(height: defaultPadding,),
      ],
    );
  }
}





