import 'package:p_bootstrap/p_bootstrap.dart';

import 'app.dart';
import 'generated/codegen_loader.g.dart';

void main() {
  bootstrap(() => const App(),
      localizationConfig: LocalizationConfig(
        assetLoader: const CodegenLoader(),
      ));
}
