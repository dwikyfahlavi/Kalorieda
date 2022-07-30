import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalorieda/models/provider/authentication_provider.dart';
import 'package:kalorieda/screens/dashboard/calculate_screen.dart';
import 'package:provider/provider.dart';

class MyCard extends StatelessWidget {
  MyCard(
      {required this.icon, required this.teks, required this.warnaIcon, required this.subtitle, required this.content});

  final IconData icon;
  final String teks;
  final Color warnaIcon;
  final String subtitle;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: FaIcon(
              icon,
              size: 40,
              color: warnaIcon,
            ),
            title: Text(
              teks,
              style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
            trailing: GestureDetector(
              child: const FaIcon(FontAwesomeIcons.plus),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalculateScreen()),
                );
              },
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 10),
            child: Text(
              content,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
