import 'package:flutter/material.dart';
import 'package:login_page_bloc/constants/app_text_styles.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Page'),
      ),
      body: Center(
        child: Container(
          child: Text('SUCCESS !', style: AppTextStyles.boldSize25),
        ),
      ),
    );
  }
}
