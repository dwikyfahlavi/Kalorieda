import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalorieda/components/RoundedButton.dart';
import 'package:kalorieda/models/provider/detail_food_provider.dart';
import 'package:kalorieda/models/diet_model.dart';
import 'package:kalorieda/models/food_model.dart';
import 'package:kalorieda/screens/dashboard/main_screen.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'dart:math' as math;

import 'package:provider/provider.dart';

class DetailFoodScreen extends StatefulWidget {
  final List<Foods>? foods;

  const DetailFoodScreen({Key? key, this.foods}) : super(key: key);

  @override
  State<DetailFoodScreen> createState() => _DetailFoodScreenState();
  
}

class _DetailFoodScreenState extends State<DetailFoodScreen> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _totalCalories = context.read<DetailFoodProvider>().getTotalMap(widget.foods)['Calories'];
    final _totalCarbohydrates = context.read<DetailFoodProvider>().getTotalMap(widget.foods)['Carbohydrates'];
    final _totalFats = context.read<DetailFoodProvider>().getTotalMap(widget.foods)['Fat'];
    final _totalProtein = context.read<DetailFoodProvider>().getTotalMap(widget.foods)['Protein'];
    final _dataMap = context.read<DetailFoodProvider>().getDataMap(widget.foods);
    final _mealDetail = context.read<DetailFoodProvider>().getMealMap(widget.foods);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Food'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.foods?.length,
                itemBuilder: (context, index) {
                  String? photo = widget.foods?[index].photo?.thumb;
                  photo ??=
                      "https://thumbs.dreamstime.com/b/hamburger-crossed-out-circle-junk-food-fast-ban-flat-vector-illustration-173479242.jpg";
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.network(
                              '${widget.foods?[index].photo?.thumb}',
                              height: 60,
                              width: 60,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.foods?[index].foodName}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${widget.foods?[index].nfCalories}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.foods?[index].servingUnit}(${widget.foods?[index].servingWeightGrams}g)",
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                                Text(
                                  'Calories',
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            ),
                            trailing: const FaIcon(FontAwesomeIcons.angleRight),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 490,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20),
                    child: const Divider(thickness: 2),
                  ),
                  Text(
                    "Source of Calories",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Total calories : $_totalCalories KCAL",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 25),
                  PieChart(
                    dataMap: _dataMap,
                    chartType: ChartType.disc,
                    animationDuration: const Duration(milliseconds: 800),
                    chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 300),
                    initialAngleInDegree: 0,
                    chartLegendSpacing: 32,
                    chartValuesOptions:
                        const ChartValuesOptions(showChartValuesInPercentage: true, showChartValuesOutside: true),
                    legendOptions: const LegendOptions(legendPosition: LegendPosition.bottom, showLegendsInRow: true),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 100),
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Consumer<DetailFoodProvider>(builder: (_, value, child) {
                      return RoundedButtonWidget(
                          buttonText: 'Add Food',
                          width: double.infinity,
                          onpressed: () {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.custom,
                              barrierDismissible: true,
                              confirmBtnText: 'Save',
                              widget: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      isExpanded: true,
                                      hint: const Text(
                                        'Select Meal...',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                      buttonHeight: 60,
                                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      items: value.dropdownItems,
                                      validator: (text) {
                                        if (text == null) {
                                          return 'Required Select Meal';
                                        }
                                        return null;
                                      },
                                      onChanged: (text) {
                                        value.changeItems(text.toString());
                                      },
                                    ),
                                    SfDateRangePicker(
                                      view: DateRangePickerView.month,
                                      monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                                      initialSelectedDate: DateTime.now(),
                                      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                                        value.changeDate(args.value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              onConfirmBtnTap: () async {
                                List foodName = [];
                                for (int i = 0; i < widget.foods!.length; i++) {
                                  foodName.add(widget.foods![i].foodName);
                                }
                                if (!_formKey.currentState!.validate()) return;
                                Navigator.pop(context);

                                String? cek = await value.addDiet(
                                  Diet(
                                    date: value.date,
                                    
                                    meal: {
                                      value.items: [
                                        _totalCalories.toString(),
                                        _totalCarbohydrates.toString(),
                                        _totalFats.toString(),
                                        _totalProtein.toString(),
                                        ...foodName,
                                      ]
                                    },
                                  ),
                                );

                                if (cek == 'Success') {
                                  await CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    text: "Your food data has been saved!.",
                                  );
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) => const MainScreen()), (route) => false);
                                } else {
                                  await CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: "Your food data failed to saved!.",
                                  );
                                }
                              },
                            );
                          });
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
