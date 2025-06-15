import 'package:flutter/material.dart';

/// Helper para navegação com substituição da página atual.
void changePage(BuildContext context, String page) {
  Navigator.of(context).pushReplacementNamed('/$page');
}
