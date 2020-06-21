import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_theme/theme_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    Provider<ThemeStore>(
      create: (_) => ThemeStore(),
    )
  ], child: MobxThemeApp()));
}

class MobxThemeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MaterialApp(
        title: 'Mobx Theme',
        theme: context.watch<ThemeStore>().currentThemeData,
        home: HomePage(),
      );
    });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobx Theme'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.brightness_medium),
            onPressed: () {
              showDialog(
                  context: context,
                  child: Observer(builder: (_) {
                    final themeStore = context.read<ThemeStore>();
                    return SimpleDialog(
                      title: Text('Select theme'),
                      children: <Widget>[
                        ListTile(
                          title: const Text('Light Theme'),
                          leading: Radio(
                            value: ThemeType.light,
                            groupValue: themeStore.currentThemeType,
                            onChanged: (ThemeType value) {
                              themeStore.changeCurrentTheme(value);
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Dark Theme'),
                          leading: Radio(
                            value: ThemeType.dark,
                            groupValue: themeStore.currentThemeType,
                            onChanged: (ThemeType value) {
                              themeStore.changeCurrentTheme(value);
                            },
                          ),
                        ),
                      ],
                    );
                  }));
            },
          )
        ],
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Card(
            child: Observer(builder: (context) {
              return ListTile(
                title: Text(
                    'The current theme is : ${context.watch<ThemeStore>().themeString}'),
              );
            }),
          ),
          MaterialButton(
            color: Colors.deepPurple,
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage()));
            },
            child: Text('Go to Setting Page'),
          )
        ],
      )),
    );
  }
}

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeStore = context.watch<ThemeStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: () {
            ThemeType changeTo = themeStore.currentThemeType == ThemeType.light
                ? ThemeType.dark
                : ThemeType.light;
            themeStore.changeCurrentTheme(changeTo);
          },
          child: Text('Change Theme'),
        ),
      ),
    );
  }
}
