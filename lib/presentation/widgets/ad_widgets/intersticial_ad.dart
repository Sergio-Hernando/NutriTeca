import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdWidget extends StatefulWidget {
  const InterstitialAdWidget({Key? key}) : super(key: key);

  @override
  InterstitialAdWidgetState createState() => InterstitialAdWidgetState();
}

class InterstitialAdWidgetState extends State<InterstitialAdWidget> {
  InterstitialAd? _interstitialAd;

  final String _adUnitId = 'ca-app-pub-3193440126606963/4094546928';

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void loadAd() {
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              Navigator.pop(context);
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              ad.dispose();
              Navigator.pop(context);
            },
          );

          if (_shouldShowAd()) {
            _interstitialAd!.show();
          } else {
            Navigator.pop(context);
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          Navigator.pop(context);
        },
      ),
    );
  }

  bool _shouldShowAd() {
    Random random = Random();
    return random.nextDouble() < 0.7;
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
