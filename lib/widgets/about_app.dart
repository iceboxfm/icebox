import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  // FIXME: should I have a direct email link? - need to add query to manifest if so

  @override
  Widget build(final BuildContext context) {
    return AboutListTile(
      icon: const Icon(Icons.info),
      child: const Text('About Icebox'),
      applicationIcon: const Image(
        image: AssetImage('assets/images/ice-cubes.png'),
        width: 64,
      ),
      applicationName: 'Icebox Freezer Manager',
      applicationVersion: '1.0.1',
      applicationLegalese: '© 2021',
      aboutBoxChildren: [
        const SectionHeaderText('More Information'),
        Container(
          margin: const EdgeInsets.only(top: 12),
          child: Linkify(
            text:
                'Visit https://iceboxfm.github.io for user guides, app information, or to submit'
                ' feedback or bug reports.',
            onOpen: (link) => _open(link.url),
          ),
        ),
        const SectionHeaderText('Usage Disclaimer'),
        Container(
          margin: const EdgeInsets.only(top: 6),
          child: Text(
            'The information provided by Icebox Freezer Manager, this app, is for '
            'general informational purposes only. All information is provided in '
            'good faith, however we make no representation or warranty of any kind, '
            'express or implied, regarding the accuracy, adequacy, validity, '
            'reliability, availability or completeness of any information on our '
            'application.\n'
            'Under no circumstance shall we have any liability to you for any '
            'loss or damage of any kind incurred as a result of the use of the app '
            'or reliance on any information provided by it. Your use of the app and '
            'your reliance on any information on these platforms is solely at your '
            'own risk.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        const SectionHeaderText('Attribution'),
        Container(
          margin: const EdgeInsets.only(top: 6),
          // FIXME: make sure all of these are correct and present
          child: Linkify(
            text:
                'This application contains icons from the https://www.flaticon.com'
                ' icon repository. The following creators icons were used: '
                'justicon, iconixar, surang, pixelmeetup, mynamepong',
            onOpen: (link) => _open(link.url),
          ),
        ),
      ],
    );
  }

  Future<bool> _open(final String url) async {
    if (await canLaunch(url)) {
      return await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SectionHeaderText extends StatelessWidget {
  final String _text;

  const SectionHeaderText(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Text(
        _text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
