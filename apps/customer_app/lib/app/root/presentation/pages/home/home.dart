import 'package:customer_app/app/root/presentation/pages/home/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, _) {
        final provider = context.watch<HomeProvider>();
        return Padding(
          padding: PEdgeInsets.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: PEdgeInsets.horizontal,
                child: const YouText.titleLarge('Your orders'
                    '\n'
                    'knows you well'),
              ),
              Space.vL1,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // provider.fetch();
                  },
                  child: ListView(
                    children: const [],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    required this.path,
    required this.title,
    this.subTitle,
  }) : super(key: key);
  final String path;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            path,
            package: kDesignPackageName,
          ),
          YouText.bodyLarge(title),
          if (subTitle != null) ...[
            Space.vM1,
            YouText.bodySmall(subTitle!),
          ]
        ],
      ),
    );
  }
}
