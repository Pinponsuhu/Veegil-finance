import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veegil/providers.dart';

class SettingsWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: ListView(
        children: [
          ListTile(
            onTap: (){
              ref.read(logoutProvider({
                'ctx': context, 
                'ref' : ref
              }));
            },
            title: Text("Logout"),
            leading: Icon(
              Icons.logout_outlined
            ),
          )
        ],
      ),
    );
  }
}