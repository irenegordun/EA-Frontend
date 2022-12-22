import 'package:flutter/material.dart';

import 'package:flutter_front/models/language.dart';
import 'package:flutter_front/models/language_constants.dart';
import 'package:flutter_front/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Accessibility extends StatefulWidget {
  const Accessibility({super.key});
  @override
  State<Accessibility> createState() => _AccessibilitytState();
}

double sliderFont = 0.0;

class _AccessibilitytState extends State<Accessibility> {
  bool _darkmode = false;
  bool _help = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          AppLocalizations.of(context)!.homePage,
        ),
      
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: const SizedBox(),
              icon: const Icon(
                Icons.language,
                color: Colors.white,
              ),
              onChanged: (Language? language) async {
                if (language != null) {
                  Locale _locale = await setLocale(language.languageCode);
                  MyApp.setLocale(context, _locale);
                }
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                      value: e,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            e.flag,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(e.name)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
            //dark mode
              SwitchListTile(
                secondary: const Icon(Icons.shield_moon_outlined),
                title: Text(
                  translation(context).darkMode
                ),
                value: _darkmode,
                activeColor: Colors.blueGrey,
                inactiveTrackColor: Colors.grey,
                onChanged: (bool value) {
                  setState(() {
                    _darkmode = value;
                  });
                },
                subtitle: Text(
                  translation(context).changeTheColourPalette,
                  style: TextStyle(
                  color: Colors.blueGrey[600],
                ),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
            ),
                        
            //panic button
            SwitchListTile(
              title: Text(
                translation(context).panicButton,
                style: TextStyle(
                    color: Color.fromARGB(255, 239, 16, 16),
                    fontWeight: FontWeight.w800,
                    fontSize: 25
                ),
              ),
              value: _help,
                activeColor: Color.fromARGB(255, 250, 10, 10),
                inactiveTrackColor: Color.fromARGB(255, 221, 107, 107),
                onChanged: (bool value) {
                  setState(() {
                    _help = value;
                  });
                },
                subtitle: Text(
                translation(context).pressInCaseOfDanger,
                style: TextStyle(
                  color: Colors.blueGrey[600],
                ),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
            ),

            const Divider(),
            
            //large fonts
            ListTile(
              title: Text("hola",
                style: TextStyle (
                  fontSize: MediaQuery.of(context).size.width * sliderFont,
                ),
              ),

            ),
            Slider(
              
                value: sliderFont,
                onChanged: (newFont) {
                  setState(() {
                    sliderFont = newFont;
                  });
                },
                min: 0.0,
                max: 0.5,
                divisions: 2,
                activeColor: Colors.blueGrey,
                inactiveColor: Colors.blueGrey.shade100,
                thumbColor: Colors.blueGrey,
                label: "$sliderFont",
              ),
          ],
          ),
        ),

      ),
    );
  }
}
  
