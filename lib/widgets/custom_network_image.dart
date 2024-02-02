import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? boxFit;
  final double? height;
  final double? width;
  final BoxShape shape;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            shape: shape,
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
            shape: shape,
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
