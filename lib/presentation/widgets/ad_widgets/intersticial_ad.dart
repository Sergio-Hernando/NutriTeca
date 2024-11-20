import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdWidget extends StatefulWidget {
  const InterstitialAdWidget({super.key});

  @override
  InterstitialAdWidgetState createState() => InterstitialAdWidgetState();
}

class InterstitialAdWidgetState extends State<InterstitialAdWidget> {
  InterstitialAd? _interstitialAd;
  final String _adUnitId = 'ca-app-pub-1482269879456524/5137640634';

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
          debugPrint('Anuncio intersticial cargado.');
          _interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('Anuncio mostrado.');
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Anuncio cerrado.');
              ad.dispose();
              _handleAdDismissal();
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              debugPrint('El anuncio falló al mostrarse: $err');
              ad.dispose();
              _handleAdDismissal();
            },
          );

          _interstitialAd!.show();
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('El anuncio falló al cargar: $error');
          _handleAdDismissal();
        },
      ),
    );
  }

  void _handleAdDismissal() {
    Navigator.pop(context);
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
