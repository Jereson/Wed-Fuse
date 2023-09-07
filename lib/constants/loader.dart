import 'package:flutter/material.dart';

class loader extends StatelessWidget {
  const loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Center( child: CircularProgressIndicator(),);
  }
}
