import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final VoidCallback handler;

  AdaptiveButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(child: Text(text), onPressed: handler)
        : TextButton(
            onPressed: handler,
            child: Text(text),
            style: TextButton.styleFrom(
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
          );
  }
}
