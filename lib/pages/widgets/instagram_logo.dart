import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/constants.dart';

class InstagramLogo extends StatelessWidget {
  const InstagramLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      instagramImage,
      height: 64,
    );
  }
}
