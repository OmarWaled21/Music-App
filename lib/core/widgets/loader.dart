import 'package:client/core/extentions/media_query_extention.dart';
import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppPallete.gradient1,
        size: context.devicePixelRatio * 20,
      ),
    );
  }
}
