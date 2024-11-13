import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({super.key});

  @override
  AdBannerState createState() => AdBannerState();
}

class AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3193440126606963/3675874402',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.foreground,
      height: MediaQuery.of(context).size.height * 0.065,
      child: _bannerAd != null
          ? AdWidget(ad: _bannerAd!)
          : const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
