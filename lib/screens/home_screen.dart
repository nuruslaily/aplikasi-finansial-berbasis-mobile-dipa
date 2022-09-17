import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kas/screens/component/chart.dart';
import 'package:kas/screens/detail_cashflow.dart';
import 'package:kas/screens/expenses_screen.dart';
import 'package:kas/screens/income_screen.dart';
import 'package:kas/screens/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(color: Colors.purple[50], child: BodyHomeScreen()));
  }
}

class Menu {
  //Menu class
  final String route;
  final String menuName;
  final String menuImage;
  Menu({required this.route, required this.menuName, required this.menuImage});
}

class GridMoney extends StatelessWidget {
  GridMoney({Key? key}) : super(key: key);

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 16),
  );
  List<String> imgbutton = [
    'assets/img/income.png',
    'assets/img/expenses.png',
    'assets/img/cash-flow.png',
    'assets/img/settings.png'
  ];
  List<String> textbutton = [
    'Tambah Pemasukan',
    'Tambah Pengeluaran',
    'Detail Cash Flow',
    'Pengaturan'
  ];

  List menus = [
    IncomeScreen(),
    ExpensesScreen(),
    DetailCashFlow(),
    SettingScreen()
  ]; //List of categories

  final Menu income = Menu(
    route: '/income',
    menuName: 'Tambah Pemasukan',
    menuImage: 'assets/img/income.png',
  );
  final Menu expenses = Menu(
    route: '/expenses',
    menuName: 'Tambah Pengeluaran',
    menuImage: 'assets/img/expenses.png',
  );
  final Menu cashflow = Menu(
    route: '/cashflow',
    menuName: 'Detail Cash Flow',
    menuImage: 'assets/img/cash-flow.png',
  );
  final Menu settings = Menu(
    route: '/settings',
    menuName: 'Pengaturan',
    menuImage: 'assets/img/settings.png',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[50],
      padding: EdgeInsets.only(left: 8, right: 8),
      child: GridView.builder(
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 2),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => menus[index]
                  // here I call the new screens according with screens in the List
                  ),
            ),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(imgbutton[index], height: 50, width: 50),
                  Text(textbutton[index], style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BodyHomeScreen extends StatefulWidget {
  const BodyHomeScreen({Key? key}) : super(key: key);

  @override
  State<BodyHomeScreen> createState() => _BodyHomeScreenState();
}

class _BodyHomeScreenState extends State<BodyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        color: Colors.purple[50],
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            HeaderHomeScreen(size: size),
            SizedBox(height: 40),
            Container(
              color: Colors.purple[50],
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Center(
                      child: Text("Pengeluaran Rp. 500.000",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                  const SizedBox(height: 6),
                  Center(
                      child: Text("Pemasukan Rp. 1500.000",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                ],
              ),
            ),
                  Container(padding: EdgeInsets.only(left: 10, right: 10), child: ChartScreen()),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    color: Colors.purple[50],
                    child: Expanded(child: GridMoney())),
          ],
        ),
      ),
    );
  }
}

class HeaderHomeScreen extends StatelessWidget {
  Size size;
  HeaderHomeScreen({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[300],
      margin: const EdgeInsets.only(bottom: 0),
      height: size.height * 0.2 - 50,
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.deepPurple[300],
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 20.0,
              right: 20.0,
            ),
            height: size.height * 0.2 - 35,
            child: Center(
              child: Text(
                'Rangkuman Bulan Ini',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
