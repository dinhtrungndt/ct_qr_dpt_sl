import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/empty_icon.png'),
            width: 200,
            height: 200,
          ),
          Text(
            AppLocalizations.of(context)!.noData,
            style: const TextStyle(fontSize: 17, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
