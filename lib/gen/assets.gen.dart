/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Mulish-Variable.ttf
  String get mulishVariable => 'assets/fonts/Mulish-Variable.ttf';

  /// List of all assets
  List<String> get values => [mulishVariable];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/cart-empty.png
  AssetGenImage get cartEmpty =>
      const AssetGenImage('assets/images/cart-empty.png');

  /// File path: assets/images/demologo.jpg
  AssetGenImage get demologo =>
      const AssetGenImage('assets/images/demologo.jpg');

  /// File path: assets/images/no_image.jpg
  AssetGenImage get noImage =>
      const AssetGenImage('assets/images/no_image.jpg');

  /// File path: assets/images/offerbackground.jpg
  AssetGenImage get offerbackground =>
      const AssetGenImage('assets/images/offerbackground.jpg');

  /// File path: assets/images/offeryellowbackground.jpg
  AssetGenImage get offeryellowbackground =>
      const AssetGenImage('assets/images/offeryellowbackground.jpg');

  /// File path: assets/images/sanaferlogo.png
  AssetGenImage get sanaferlogo =>
      const AssetGenImage('assets/images/sanaferlogo.png');

  /// File path: assets/images/slide_show.png
  AssetGenImage get slideShow =>
      const AssetGenImage('assets/images/slide_show.png');

  /// File path: assets/images/smartsolns.png
  AssetGenImage get smartsolns =>
      const AssetGenImage('assets/images/smartsolns.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        cartEmpty,
        demologo,
        noImage,
        offerbackground,
        offeryellowbackground,
        sanaferlogo,
        slideShow,
        smartsolns
      ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/alaysh-white.svg
  SvgGenImage get alayshWhite =>
      const SvgGenImage('assets/svgs/alaysh-white.svg');

  /// File path: assets/svgs/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/svgs/facebook.svg');

  /// File path: assets/svgs/instagram.svg
  SvgGenImage get instagram => const SvgGenImage('assets/svgs/instagram.svg');

  /// File path: assets/svgs/linkedin.svg
  SvgGenImage get linkedin => const SvgGenImage('assets/svgs/linkedin.svg');

  /// File path: assets/svgs/twitterx.svg
  SvgGenImage get twitterx => const SvgGenImage('assets/svgs/twitterx.svg');

  /// File path: assets/svgs/whatsapp.svg
  SvgGenImage get whatsapp => const SvgGenImage('assets/svgs/whatsapp.svg');

  /// File path: assets/svgs/whatsapp_icon.svg
  SvgGenImage get whatsappIcon =>
      const SvgGenImage('assets/svgs/whatsapp_icon.svg');

  /// File path: assets/svgs/youtube.svg
  SvgGenImage get youtube => const SvgGenImage('assets/svgs/youtube.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        alayshWhite,
        facebook,
        instagram,
        linkedin,
        twitterx,
        whatsapp,
        whatsappIcon,
        youtube
      ];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
