import 'package:flutter/material.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';

import '../../widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ISMMART eCommerce'),
      ),
      body: Center(
        child: CustomIconTextBtn(
          title: 'CustomIconTextBtn',
          onPressed: () {
            CommonFunction.showBottomSheet(context: context);
          },
          icon: Icons.add,
        ),
      ),
    );
  }
}
