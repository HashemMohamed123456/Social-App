import 'dart:core';
import 'package:flutter/material.dart';
class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final IconData? prefix;
  final IconData? suffix;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onSuffixPressed;
  final void Function(String)? onFieldSubmitted;
  final bool? obscureText;
  const TextFormFieldCustom({super.key,
    this.controller,
    this.label,
    this.prefix,
    this.suffix,
    this.validator,
    this.keyboardType,
    this.onChanged,
    this.onTap,
    this.onSuffixPressed,
    this.onFieldSubmitted,
    this.obscureText
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged:onChanged ,
      keyboardType:keyboardType ,
      validator: validator,
      controller: controller,
      onFieldSubmitted:onFieldSubmitted ,
      obscureText: obscureText??false,
      decoration: InputDecoration(
          labelStyle:const TextStyle(
              fontSize: 20,
              color:Colors.grey,
              fontWeight: FontWeight.bold
          ),
          suffixIcon: InkWell(
              onTap:onSuffixPressed,
              child: Icon(suffix)),
          suffixIconColor: Colors.grey,
          prefixIconColor: Colors.grey,
          labelText:label??'',
          prefixIcon: Icon(prefix),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                width: 3,
                color: Colors.blueGrey
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
                width: 2,
                color: Colors.grey
            ),
          ),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  width: 3,
                  color: Colors.red
              )
          )
      ),
    );
  }
}
