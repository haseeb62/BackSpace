// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class PostBody extends StatelessWidget {
  final String postSummary;
  const PostBody({required this.postSummary});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        postSummary,
        style: const TextStyle(fontFamily: "Poppins"),
      ),
    );
  }
}
