import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage(
      {super.key,
      required this.imageUrl,
      this.boxShape = BoxShape.circle,
      this.height = 80.0,
      this.width = 80.0,
      this.fit = BoxFit.cover,
      this.assetsImage});
  final String? imageUrl;
  final BoxShape? boxShape;
  final double? height, width;
  final BoxFit? fit;
  final ImageProvider? assetsImage;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            shape: boxShape!,
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
            shape: boxShape!,
            image: DecorationImage(
              image:
                  assetsImage ?? const AssetImage('assets/images/logo_new.png'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 2.0),
        );
      },
    );
  }
}
