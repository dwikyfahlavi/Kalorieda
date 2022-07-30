import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalorieda/components/myCard.dart';
import 'package:kalorieda/models/provider/home_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';
import 'package:intl/intl.dart';
import '../../components/theme.dart';
import '../../components/waveClipper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: FlexibleHeaderDelegate(
              statusBarHeight: MediaQuery.of(context).padding.top,
              leading: const SizedBox(),
              expandedHeight: 360,
              collapsedHeight: 50,
              background: MutableBackground(
                expandedWidget: const Image(image: AssetImage('assets/images/bg_homeScreen.png'), fit: BoxFit.fill),
                collapsedColor: createMaterialColor(const Color(0xff27A52F)),
              ),
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Classic Dieting',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Consumer<HomeProvider>(builder: (context, value, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      value.totalCalorie.toInt().toString(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'EATEN',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline6?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                                Consumer<HomeProvider>(builder: (context, value, child) {
                                  return CircularPercentIndicator(
                                    animation: true,
                                    animationDuration: 1000,
                                    radius: 90.0,
                                    lineWidth: 6.0,
                                    percent: value.totalCalorie / 2623,
                                    center: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          value.calorieLeft.toString(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'KCAL LEFTS',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                        ),
                                      ],
                                    ),
                                    progressColor: Colors.white,
                                    backgroundColor: const Color.fromARGB(50, 255, 255, 255),
                                  );
                                }),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '150',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'BURNED',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.headline6?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                          const SizedBox(height: 20),
                          Consumer<HomeProvider>(builder: (context, value, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'CARBS',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(height: 5),
                                    LinearPercentIndicator(
                                      animation: true,
                                      animationDuration: 1000,
                                      width: 100,
                                      lineHeight: 4,
                                      percent: value.totalCalorie / 3280,
                                      progressColor: Colors.white,
                                      backgroundColor: const Color.fromARGB(50, 255, 255, 255),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${value.totalCarbo.toInt().toString()} / 328g',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'PROTEIN',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(height: 5),
                                    LinearPercentIndicator(
                                      animation: true,
                                      animationDuration: 1000,
                                      width: 100,
                                      lineHeight: 4,
                                      percent: value.totalProtein / 131,
                                      progressColor: Colors.white,
                                      backgroundColor: const Color.fromARGB(50, 255, 255, 255),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${value.totalProtein.toInt().toString()} / 131g',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'FAT',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
                                    ),
                                    const SizedBox(height: 5),
                                    LinearPercentIndicator(
                                      animation: true,
                                      animationDuration: 1000,
                                      width: 100,
                                      lineHeight: 4,
                                      percent: value.totalFat / 328,
                                      progressColor: Colors.white,
                                      backgroundColor: const Color.fromARGB(50, 255, 255, 255),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${value.totalFat.toInt().toString()} / 87g',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(color: Colors.white, fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FlutterDatePickerTimeline(
                  startDate: DateTime(2022, 05, 01),
                  endDate: DateTime(2022, 06, 01),
                  initialSelectedDate: DateTime.now(),
                  onSelectedDateChange: (dateTime) async {
                    var dateFormat = DateFormat('yyy-MM-dd').format(dateTime!);
                    await context.read<HomeProvider>().getDietByDate(dateFormat);
                    context.read<HomeProvider>().setDateTime(dateTime);

                    final List? breakfast = await context.read<HomeProvider>().diet?.meal!['BreakFast'];
                    final List? lunch = await context.read<HomeProvider>().diet?.meal!['Lunch'];
                    final List? dinner = await context.read<HomeProvider>().diet?.meal!['Dinner'];
                    if (breakfast != null) {
                      context.read<HomeProvider>().setTotalCalorie(breakfast[0]);
                      context.read<HomeProvider>().setTotalCarbo(breakfast[1]);
                      context.read<HomeProvider>().setTotalFat(breakfast[2]);
                      context.read<HomeProvider>().setTotalProtein(breakfast[3]);
                    }
                    if (lunch != null) {
                      context.read<HomeProvider>().setTotalCalorie(lunch[0]);
                      context.read<HomeProvider>().setTotalCarbo(lunch[1]);
                      context.read<HomeProvider>().setTotalFat(lunch[2]);
                      context.read<HomeProvider>().setTotalProtein(lunch[3]);
                    }
                    if (dinner != null) {
                      context.read<HomeProvider>().setTotalCalorie(dinner[0]);
                      context.read<HomeProvider>().setTotalCarbo(dinner[1]);
                      context.read<HomeProvider>().setTotalFat(dinner[2]);
                      context.read<HomeProvider>().setTotalProtein(dinner[3]);
                    }
                  },
                ),
                SizedBox(height: 10),
                Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Consumer<HomeProvider>(
                        builder: (context, value, child) {
                          int waterTotal = value.waterTotal;
                          return ListTile(
                            trailing: const Icon(Icons.more_vert),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [const Text('Water'), Text('$waterTotal')],
                            ),
                          );
                        },
                      ),
                      Consumer<HomeProvider>(
                        builder: ((context, value, child) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            height: 90,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.waterData.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onLongPress: () {
                                    value.setWaterFill(index);
                                  },
                                  onTap: () {
                                    value.setWaterEmpty(index);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      Center(child: Image.asset('assets/images/drop.png', height: 50, width: 50)),
                                      Center(
                                        child: AnimatedBuilder(
                                          animation:
                                              CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
                                          builder: (context, child) => ClipPath(
                                            child: Image.asset('assets/images/drop-blue.png', height: 50, width: 50),
                                            clipper: WaveClipper(
                                                value.waterData[index],
                                                (value.waterData[index] > 0.0 && value.waterData[index] < 1.0)
                                                    ? animationController.value
                                                    : 0.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    Consumer<HomeProvider>(builder: (context, value, child) {
                      List<String> foodName = [];
                      final List? makanan = value.diet?.meal!['BreakFast'];
                      if (makanan != null) {
                        for (int i = 4; i < makanan.length; i++) {
                          foodName.add(makanan[i]);
                        }
                      }

                      return MyCard(
                          icon: FontAwesomeIcons.cookieBite,
                          teks: 'add Breakfast',
                          warnaIcon: Colors.brown,
                          subtitle:
                              value.diet?.meal != null ? foodName.map((e) => "$e ").toString() : 'Recommended 525 kcal',
                          content: makanan != null ? "${makanan[0]} kcal" : '');
                    }),
                    const SizedBox(height: 15),
                    Consumer<HomeProvider>(builder: (context, value, child) {
                      List<String> foodName = [];
                      final List? makanan = value.diet?.meal!['Lunch'];
                      if (makanan != null) {
                        for (int i = 4; i < makanan.length; i++) {
                          foodName.add(makanan[i]);
                        }
                      }

                      return MyCard(
                        icon: FontAwesomeIcons.burger,
                        teks: 'add Lunch',
                        warnaIcon: const Color.fromARGB(255, 235, 152, 0),
                        subtitle: makanan != null ? foodName.map((e) => "$e ").toString() : 'Recommended 525 kcal',
                        content: makanan != null ? "${makanan[0]} kcal" : '',
                      );
                    }),
                    const SizedBox(height: 15),
                    Consumer<HomeProvider>(builder: (context, value, child) {
                      List<String> foodName = [];
                      final List? makanan = value.diet?.meal!['Dinner'];
                      if (makanan != null) {
                        for (int i = 4; i < makanan.length; i++) {
                          foodName.add(makanan[i]);
                        }
                      }

                      return MyCard(
                        icon: FontAwesomeIcons.bowlFood,
                        teks: 'add Dinner',
                        warnaIcon: const Color.fromARGB(255, 11, 128, 224),
                        subtitle: makanan != null ? foodName.map((e) => "$e ").toString() : 'Recommended 525 kcal',
                        content: makanan != null ? "${makanan[0]} kcal" : '',
                      );
                    }),
                    const SizedBox(height: 15),
                    MyCard(
                        icon: FontAwesomeIcons.football,
                        teks: 'Exercise',
                        warnaIcon: const Color.fromARGB(255, 185, 36, 25),
                        subtitle: 'Recommended 30 min',
                        content: '440 burned'),
                  ],
                ),
                const SizedBox(height: 100)
              ],
            ),
          )
        ],
      ),
    );
  }
}
