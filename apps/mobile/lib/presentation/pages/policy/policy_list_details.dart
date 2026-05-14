import 'package:flutter/material.dart';

class PolicyListDetails extends StatefulWidget {
  const PolicyListDetails({super.key});

  @override
  State<PolicyListDetails> createState() => _PolicyListDetailsState();
}

class _PolicyListDetailsState extends State<PolicyListDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policy Details'),
      ),
      body: const Center(
        child: Text('Policy List Details Page'),
      ),
    );
  }
}

