import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:radio/config.dart';
import 'package:radio/helpers/constant/app_styles.dart';
import 'package:radio/helpers/url_launcher.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Config.whatsApp.isEmpty
            ? Container(
                width: 0,
              )
            : FloatingActionButton.small(
                heroTag: "WhatsappIncontacpage",
                elevation: 1,
                backgroundColor: kBlack0D,
                onPressed: () {
                  launchWhatApp(
                    Uri.parse(
                        "https://api.whatsapp.com/send/?phone=${Config.whatsApp}"),
                  );
                },
                child: const FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: kGreyB7,
                  size: 24,
                ),
              ),
        const SizedBox(
          width: 5,
        ),
        Config.faceBook.isEmpty
            ? Container(
                width: 0,
              )
            : FloatingActionButton.small(
                heroTag: "Facebook",
                elevation: 1,
                backgroundColor: kBlack0D,
                onPressed: () {
                  launchURL(
                    Uri.parse(Config.faceBook),
                  );
                },
                child: const FaIcon(
                  FontAwesomeIcons.facebookF,
                  color: kGreyB7,
                  size: 24,
                ),
              ),
        const SizedBox(
          width: 5,
        ),
        Config.twitter.isEmpty
            ? Container(
                width: 0,
              )
            : FloatingActionButton.small(
                elevation: 2,
                backgroundColor: kBlack0D,
                onPressed: () {
                  launchURL(
                    Uri.parse(Config.twitter),
                  );
                },
                child: const FaIcon(
                  FontAwesomeIcons.twitter,
                  color: kGreyB7,
                  size: 24,
                ),
              ),
        const SizedBox(
          width: 5,
        ),
        Config.instagram.isEmpty
            ? Container(
                width: 0,
              )
            : FloatingActionButton.small(
                elevation: 1,
                backgroundColor: kBlack0D,
                onPressed: () {
                  launchURL(
                    Uri.parse(Config.instagram),
                  );
                },
                child: const FaIcon(
                  FontAwesomeIcons.instagram,
                  color: kGreyB7,
                  size: 24,
                ),
              ),
      ],
    );
  }
}
