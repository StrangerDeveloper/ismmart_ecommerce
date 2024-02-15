import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/search/search_viewmodel.dart';

import '../../widgets/custom_text_field.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final SearchViewModel viewModel = Get.put(SearchViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: const CustomAppBar2(title: 'Search '),
        body: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 12, top: 12, bottom: 12, right: 12),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                searchTxtField(),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => viewModel.recentSearchesList.isNotEmpty
                          ? titleItem('Recent Searches')
                          : const SizedBox(),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: viewModel.recentSearchesList.map(
                            (e) {
                              return recentSearchItem(e);
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    titleItem('Trending Searches'),
                    trendingSearchesListView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchTxtField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
        child: CustomTextField1(
          // controller: viewModel.searchController,
          filled: false,
          prefixIcon: CupertinoIcons.search,
          hintText: 'Search ...',
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
              color: Color(0xFF949494),
            ),
          ),
          onFieldSubmitted: (value) {
            viewModel.onFieldSubmitted(value);
          },
        ),
      ),
    );
  }

  Widget titleItem(String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, top: 20),
      child: Text(
        value,
        style: const TextStyle(
          color: Color(0xFF24272C),
          fontSize: 15,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget recentSearchItem(String value) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 7, 5, 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 3,
            offset: Offset(1.5, 1.5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {},
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF949494),
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 3),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.close,
              color: Color(0xff6B7280),
              size: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget trendingSearchesListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) {
        return listViewItem(index);
      },
    );
  }

  Widget listViewItem(int index) {
    return InkWell(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Stanley Cup',
              style: TextStyle(
                color: Color(0xFF949494),
                fontSize: 12,
              ),
            ),
            Icon(
              Icons.trending_up_outlined,
              color: Color(0xFF949494),
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
