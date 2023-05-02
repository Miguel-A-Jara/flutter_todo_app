import 'package:flutter/material.dart';

SnackBar errorSnackbar({String errorMessage = 'Error', Color? color}) {
  return SnackBar(
    content: Text(errorMessage),
    backgroundColor: color,
  );
}
