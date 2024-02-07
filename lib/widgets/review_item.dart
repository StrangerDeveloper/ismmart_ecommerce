import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';

class ReviewItem extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String profileImage;
  final String? duration;
  final String name;
  final double? rating;
  final String reviews;
  final List<dynamic> images;

  const ReviewItem({
    super.key,
    this.onTap,
    required this.profileImage,
    this.duration,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.blackShadow,
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          children: [
            CustomNetworkImage(
              //height: 130,
              imageUrl: profileImage,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ratingBar(),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      reviews,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF929AAB),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ratingBar() {
    return Padding(
      padding:  const EdgeInsets.only(top: 5, bottom: 5),
      child: RatingBar.builder(
        initialRating: rating!,
        //minRating: 0.5,
        direction: Axis.horizontal,
        ignoreGestures: true,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: AppColors.yellow,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      ),
    );
  }
}
