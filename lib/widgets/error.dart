import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';

class ConnectionErrorWidget extends StatelessWidget {
  final String errorText;
  final bool isItTryAgain;
  final VoidCallback? tryAgain;
  const ConnectionErrorWidget(
      {this.errorText = 'An unexpected error occurred while loading data.',
      required this.tryAgain,
      Key? key,
      this.isItTryAgain = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
              child: InkWell(
                  onTap: tryAgain,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          errorText,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 12.5, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        if (isItTryAgain)
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Try again',
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600),
                                ),
                                Icon(
                                  Icons.refresh,
                                  size: 15,
                                )
                              ])
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
