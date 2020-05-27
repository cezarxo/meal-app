import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  final Function saveFilters;
  final Map <String,bool> currentFilters ;
  SettingsScreen(this.currentFilters,this.saveFilters);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactosFree = false;

  initState(){
    _glutenFree = widget.currentFilters['gluten'] ;
    _lactosFree = widget.currentFilters['lactose'] ;
    _vegan = widget.currentFilters['vegan'] ;
    _vegetarian = widget.currentFilters['vegetarian'] ;
    super.initState();
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool currentValue, Function updatedValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updatedValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  final selectedFilters = {
                    'gluten': _glutenFree,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                    'lactose': _lactosFree
                  };
                  widget.saveFilters(selectedFilters);
                }),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Adjust your Meal selection',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _buildSwitchTile(
                  'Gluten-Free', 'Only include Gluten-Free meals', _glutenFree,
                  (newValue) {
                setState(() {
                  _glutenFree = newValue;
                });
              }),
              _buildSwitchTile(
                  'Vegetarian',
                  'Only include Vegetarian-Free meals',
                  _vegetarian, (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchTile('Vegan', 'Only include Vegan-Free meals', _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildSwitchTile(
                  'Lactos-Free', 'Only include Loctos-Free meals', _lactosFree,
                  (newValue) {
                setState(() {
                  _lactosFree = newValue;
                });
              }),
            ],
          ))
        ]));
  }
}
