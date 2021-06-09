import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data_store.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double _step;

  @override
  void initState() {
    _step = DataStore.step.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.blue, width: 4))),
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.all(
            20,
          ),
          child: Text('Setting Page', style: TextStyle(fontSize: 18)),
        ),
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.blue.withAlpha(22),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: _buildStepSlider(),
        ),
      ],
    );
  }

  Widget _buildStepSlider() => ListTile(
        title: Text(
          '自加步数:${_step.round()}',
        ),
        isThreeLine: true,
        subtitle: Slider(
          onChanged: (v) {
            DataStore.step = v.round();
            setState(() => _step = v);
          },
          value: _step,
          min: 1,
          max: 10,
          divisions: 11,
        ),
        trailing: SizedBox(width: 0),
      );
}
