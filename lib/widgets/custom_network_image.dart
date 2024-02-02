import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.imageUrl, this.boxFit = BoxFit.cover});
  final String? imageUrl;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration:  BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/no_image_found.jpg'),
              fit: boxFit,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 0.5),
        );
      },
    );
  }
}
