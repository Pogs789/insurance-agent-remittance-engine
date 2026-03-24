import 'package:flutter/material.dart';

class RemittanceFormPage extends StatefulWidget {
  const RemittanceFormPage({super.key});

  @override
  State<RemittanceFormPage> createState() => _RemittanceFormPage();
}

class _RemittanceFormPage extends State<RemittanceFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Remittance Form'),
      )
    );
  }
}