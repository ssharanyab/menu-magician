import 'package:flutter/material.dart';

OutlineInputBorder buildFocusedBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightGreen,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
}

OutlineInputBorder buildErrorBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
}

OutlineInputBorder buildEnabledBorder() {
  return const OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
}
