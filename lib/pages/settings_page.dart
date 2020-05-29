import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {

  final List<SettingsMenuItem> settings = [
    SettingsMenuItem(Icon(Icons.settings), 'Item 1', 'Item 1 Description'),
    SettingsMenuItem(Icon(Icons.settings), 'Item 2', 'Item 2 Description'),
    SettingsMenuItem(Icon(Icons.settings), 'Item 3', 'Item 3 Description'),
    SettingsMenuItem(Icon(Icons.settings), 'Item 4', 'Item 4 Description'),
    SettingsMenuItem(Icon(Icons.settings), 'Item 5', 'Item 5 Description'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: settings[index].icon,
                  ),
                ),
              ),
              title: Text(
                settings[index].title,
              ),
              subtitle: Text(
                settings[index].description,
              ),
            ),
          );
        },
        itemCount: settings.length,
      ),
    );
  }
}

class SettingsMenuItem {
  Icon icon;
  String title;
  String description;

  SettingsMenuItem(this.icon, this.title, this.description);
}
