import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/faq/faq_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';

class FaqView extends StatelessWidget {
  FaqView({super.key});
  final FaqViewModel viewModel = Get.put(FaqViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar2(title: "FAQs",),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(),
                listView(),
              ],
            ),
            const LoaderView(),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 16, top: 6),
      child: FittedBox(
        child: Text(
          'Frequetly Asked Questions',
          style: ThemeHelper.textTheme.headlineSmall
        ),
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.faqsList.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: viewModel.faqsList.length,
                itemBuilder: (context, index) {
                  return listViewItem(index);
                },
              ),
            )
          : Center(
              child: Text(
                'No data found',
                style: ThemeHelper.textTheme.bodyMedium
              ),
            ),
    );
  }

  Widget listViewItem(int index) {
    return ExpansionTile(
      backgroundColor: AppColors.black.withOpacity(0.03),
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10, right: 24),
      expandedAlignment: Alignment.centerLeft,
      title: Text(
        viewModel.faqsList[index].questions ?? 'N/A',
        textAlign: TextAlign.start,
        style: ThemeHelper.textTheme.labelLarge!.copyWith(
          height: 1.3,
        ),
      ),
      children: [
        Text(
          viewModel.faqsList[index].answer ?? 'N/A',
          textAlign: TextAlign.start,
          style: ThemeHelper.textTheme.bodySmall!.copyWith(
            height: 1.45,
            fontWeight: FontWeight.w200,
          ),
        ),
      ],
    );
  }
}