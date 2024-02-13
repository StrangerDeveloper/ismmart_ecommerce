import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';

class CustomProfileNameAndRating extends StatelessWidget {
  const CustomProfileNameAndRating(
      {super.key,
      this.imageUrl,
      this.name,
      this.rating,
      this.ratingItemSize = 15,
      this.description});
  final String? imageUrl;
  final String? name;
  final double? rating;
  final double? ratingItemSize;
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: AppColors.white,
      //   borderRadius: BorderRadius.circular(10),
      //   // boxShadow: const [
      //   //   BoxShadow(
      //   //     color: AppColors.blackShadow,
      //   //     blurRadius: 3,
      //   //     offset: Offset(0, 1),
      //   //     spreadRadius: 0,
      //   //   )
      //   // ],
      // ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl: imageUrl!,
              boxFit: BoxFit.cover,
              radius: 20,
              height: 40,
              width: 40,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ratingBar(),
                    if (description != null)
                      Text(
                        description!,
                        // maxLines: description?.length,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ratingBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: RatingBar.builder(
        itemSize: ratingItemSize!,
        initialRating: rating!,
        //minRating: 0.5,
        direction: Axis.horizontal,
        ignoreGestures: true,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star_rounded,
          color: AppColors.yellow,
        ),
        onRatingUpdate: (rating) {
          CommonFunction.debugPrint(rating);
        },
      ),
    );
  }
}
