import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p_bootstrap/p_bootstrap.dart';

import 'app.dart';
import 'generated/codegen_loader.g.dart';

void main() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  bootstrap(() => const App(),
      localizationConfig: LocalizationConfig(
        assetLoader: const CodegenLoader(),
      ));
}
