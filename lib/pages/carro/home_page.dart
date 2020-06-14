import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTabs();
//    _tabController = TabController(length: 3, vsync: this);
//
//    Future<int> future = Prefs.getInt('tabIdx');
//
//    future.then((int tabIdx){
//      _tabController.index = tabIdx;
//    });
//
//    _tabController.addListener(() {
//      Prefs.setInt('tabIdx', _tabController.index);
//    });
  }

  void _initTabs() async {
    _tabController = TabController(length: 3, vsync: this);

    int tabIdx = await Prefs.getInt('tabIdx');
    _tabController.index = tabIdx;

    _tabController.addListener(() {
      Prefs.setInt('tabIdx', _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('>> HomePage Build');

    return Scaffold(
      appBar: AppBar(
        title: Text('Carros'),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: [
                  Tab(
                    text: 'clássicos',
                  ),
                  Tab(
                    text: 'esportivos',
                  ),
                  Tab(
                    text: 'luxo',
                  ),
                ],
              ),
      ),
      body: _tabController == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                CarrosListView(
                  tipo: TiposCarro.classicos,
                ),
                CarrosListView(
                  tipo: TiposCarro.esportivos,
                ),
                CarrosListView(
                  tipo: TiposCarro.luxo,
                ),
              ],
            ),
      drawer: DrawerList(),
    );
  }
}
