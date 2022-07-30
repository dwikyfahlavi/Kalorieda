import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalorieda/models/provider/food_provider.dart';
import 'package:kalorieda/screens/dashboard/detail_food_screen.dart';
import 'package:provider/provider.dart';

import '../../components/theme.dart';
import '../../models/food_model.dart';

class SearchFoodScreen extends StatefulWidget {
  const SearchFoodScreen({Key? key}) : super(key: key);

  @override
  _SearchFoodScreenState createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  final _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context
          .read<FoodProvider>()
          .getFoodBySearch('milk egg bacon nasi goreng meat kfc hamburger coca cola coffee');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        padding: const EdgeInsets.all(16),
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [_searchBox(), _sizeBox(15), _cardFood()]),
        ),
      ),
    );
  }

  Widget _sizeBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _cardFood() {
    List<Foods> detailFoods = [Foods()];
    return Consumer<FoodProvider>(
      builder: ((context, value, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.84,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: value.foods?.length,
            itemBuilder: (context, index) {
              String? photo = value.foods?[index].photo?.thumb;
              photo ??=
                  "https://thumbs.dreamstime.com/b/hamburger-crossed-out-circle-junk-food-fast-ban-flat-vector-illustration-173479242.jpg";
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: (() {
                    detailFoods[0] = value.foods![index];

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailFoodScreen(foods: detailFoods)),
                    );
                  }),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.network(
                            '${value.foods?[index].photo?.thumb}',
                            height: 60,
                            width: 60,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${value.foods?[index].foodName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${value.foods?[index].nfCalories}",
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
                                "${value.foods?[index].servingUnit}(${value.foods?[index].servingWeightGrams}g)",
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
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _searchBox() {
    return Container(
        width: kIsWeb ? 450 : double.infinity,
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(80)),
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            createMaterialColor(const Color.fromARGB(136, 73, 202, 81)),
            createMaterialColor(const Color(0xff27A52F))
          ]),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            _searchField(),
            _searchBtn(),
          ],
        ));
  }

  Widget _searchField() {
    return Expanded(
      child: TextField(
        controller: _queryController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 20,
          color: Colors.white,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          hintText: "Search...",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 32,
            color: Colors.white,
          ),
        ),
        enabled: true,
        onChanged: (text) {},
      ),
    );
  }

  Widget _searchBtn() {
    return Consumer<FoodProvider>(builder: (context, value, child) {
      return AnimatedContainer(
        width: value.state == FoodProviderState.loading ? 36 : 100,
        height: 36,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
              primary: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
          child: value.state == FoodProviderState.loading ? _loadingBox() : _btnTextWidget(),
          onPressed: () async {
            await context.read<FoodProvider>().getFoodBySearch(_queryController.text);
          },
        ),
      );
    });
  }

  Widget _btnTextWidget() {
    return Text(
      "GO",
      style: TextStyle(
        color: createMaterialColor(const Color(0xff27A52F)),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _loadingBox() {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(0),
        child: SizedBox(
            height: 16,
            width: 16,
            child: CircularProgressIndicator(
              backgroundColor: createMaterialColor(const Color.fromARGB(255, 73, 235, 84)),
              valueColor: AlwaysStoppedAnimation<Color>(createMaterialColor(const Color(0xff27A52F))),
            )));
  }
}
