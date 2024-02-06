import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/bank_list/bank_list_viewmodel.dart';

import '../../helpers/app_colors.dart';
import '../../widgets/circular_progress_bar.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_checkbox.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader_view.dart';
import '../add_bank/add_bank_view.dart';

class BankListView extends StatelessWidget {
  BankListView({super.key});

  final BankListViewModel viewModel = Get.put(BankListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const CustomAppBar2(title: 'Bank Details'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                searchTxtField(),
                listView(),
                addNewBankBtn(),
              ],
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget searchTxtField() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomTextField1(
        controller: viewModel.searchController,
        filled: false,
        prefixIcon: CupertinoIcons.search,
        hintText: 'Filter by name',
        onChanged: (value) {
          // CommonFunction.debouncer.call(() {
          //   viewModel.onChangeSearching(value);
          // });
        },
        suffixIconButton: IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {
            // if (viewModel.searchController.text.isEmpty) return;
            // viewModel.searchController.clear();
            // viewModel.onChangeSearching('');
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.grey2,
          ),
        ),
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.dataList.isNotEmpty
          ? ListView.separated(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.dataList.length,
              itemBuilder: (context, int index) {
                return listViewItem(index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16);
              },
            )
          : viewModel.showListLoader.value
              ? const SizedBox(
                  height: 200,
                  child: CustomCircularLoader(),
                )
              : const SizedBox(
                  height: 200,
                  child: Center(
                    child: Text('No Data Found'),
                  ),
                ),
    );
  }

  Widget listViewItem(int index) {
    return Column(
      children: [
        SwipeActionCell(
          backgroundColor: Colors.grey.shade50,
          key: UniqueKey(),
          // confirmDismiss: (confirmDismiss) {
          //   return deleteConfirmationDialog(index);
          // },
          leadingActions: [
            SwipeAction(
              content: Container(
                height: double.infinity,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SvgPicture.asset('assets/images/edit_square.svg'),
                ),
              ),
              color: Colors.transparent,
              onTap: (CompletionHandler handler) async {},
            ),
          ],
          trailingActions: [
            SwipeAction(
              content: Container(
                height: double.infinity,
                width: 55,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              color: Colors.transparent,
              onTap: (CompletionHandler handler) async {
                deleteConfirmationDialog(index);
              },
            ),
          ],
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF9FAFB),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Text(
                      viewModel.getFirstTwoChar(
                          viewModel.dataList[index].name ?? ''),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.dataList[index].name ?? 'N/A',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        viewModel.dataList[index].title ?? 'N/A',
                        style: const TextStyle(
                          color: AppColors.grey2,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CustomCheckBox(
          title: 'Use as default bank',
          value: false.obs,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget addNewBankBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
      child: CustomTextBtn(
        height: 56,
        radius: 16,
        // backgroundColor: ThemeHelper.grey3,
        // foregroundColor: ThemeHelper.blue1,
        onPressed: () {
          // Get.to(() => AddBankView(), arguments: {'editData': false});
          Get.to(() => AddBankView());
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Add new bank',
              style: TextStyle(
                // color: ThemeHelper.blue1,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              // color: ThemeHelper.blue1,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> deleteConfirmationDialog(int index) async {
    final value = await showDialog<bool>(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: const Text('Are you sure you want to delete?'),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      // viewModel.deleteRecord(index);
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    return value ?? false;
  }
}
