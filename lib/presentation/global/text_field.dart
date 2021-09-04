import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String _hintText;
  final TextEditingController _controller;
  final String? _errorText;
  final Function(String)? _onChangeCallback;
  final bool obscureText;

  const CustomInputField(
      {Key? key,
      required controller,
      required hintText,
      errorText,
      this.obscureText = false,
      required onChange})
      : _controller = controller,
        _hintText = hintText,
        _errorText = errorText,
        _onChangeCallback = onChange,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: new TextField(
        obscureText: obscureText,
        onChanged: _onChangeCallback,
        controller: _controller,
        decoration: new InputDecoration(
          errorText: _errorText,
          hintText: _hintText,
          border: new OutlineInputBorder(),
        ),
      ),
    );
  }
}
