import 'package:flutter/material.dart';

import '../constants/colors.dart';


class InputTextBox extends StatelessWidget {
  final FocusNode? focus;
  final TextEditingController? controller;
  final String? hinttext;
  final String? labeltext;
  final Color? color;
  final Icon? icon;
  final bool select;
  final TextInputType? type;

   const InputTextBox({
    super.key,
    this.focus,
    this.controller,
    this.type,
    this.labeltext,
    required this.select,
    this.hinttext,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focus,
      controller: controller,
      onChanged: (value) {},
      onSubmitted: (val){},
      keyboardType: type,
      textCapitalization: hinttext =="First Name" ?TextCapitalization.sentences:
      hinttext =="Last Name" ? TextCapitalization.sentences:TextCapitalization.none,
      decoration: InputDecoration(
        labelText: labeltext,
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colours.primarybrown),
        prefixIcon: icon,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colours.primarygreen),
        ),
      ),
      obscureText: select,
    );
  }
}
