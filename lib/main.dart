import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: "App Bar"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> menuItems = ["Item - 1", "Item - 2", "Item - 3"];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: (context) =>
                menuItems.map((e) => PopupMenuItem(child: Text(e))).toList(),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.lightBlue.withOpacity(0.3),
        width: 350,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        top: 0 + selectedIndex * 66,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticInOut,
                        child: Container(
                          height: 56,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black26.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          NavigatorItem(
                            isSelected: selectedIndex == 0,
                            onClick: () {
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                          ),
                          NavigatorItem(
                            isSelected: selectedIndex == 1,
                            onClick: () {
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                          ),
                          NavigatorItem(
                            isSelected: selectedIndex == 2,
                            onClick: () {
                              setState(() {
                                selectedIndex = 2;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigatorItem extends StatelessWidget {
  final bool isSelected;
  final Function()? onClick;
  const NavigatorItem({
    Key? key,
    this.isSelected = false,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56,
          width: 200,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 100),
                tween: ColorTween(
                  begin: isSelected ? Colors.black : Colors.white12,
                  end: isSelected ? Colors.white : Colors.black,
                ),
                builder: (context, value, _) => Icon(
                  Icons.account_balance_wallet_outlined,
                  color: value as Color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 100),
                  tween: ColorTween(
                    begin: isSelected ? Colors.black : Colors.white12,
                    end: isSelected ? Colors.white : Colors.black,
                  ),
                  builder: (context, value, _) => Text(
                    "Navigator Item",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: value as Color),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
