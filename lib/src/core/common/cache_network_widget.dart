import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CacheNetworkWidget extends StatelessWidget {
  final String imageUrl;
  const CacheNetworkWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: SpinKitCircle(
        color: Theme.of(context).primaryColor,
      )),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
  }
}
