import 'package:flutter/material.dart';

class Validator{
  static FormFieldValidator validator=(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (!RegExp(r"(^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,32})")
        .hasMatch(value))
    {
      return 'Min 8 characters with 1 uppercase,1 number';

    }
    if(!RegExp(r"(?=.*[@#$%!\-_?&])").hasMatch(value))
    {
      return 'Password must be contain 1 special character';
    }
  };
}