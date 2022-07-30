import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/theme.dart';
import '../../models/food_model.dart';
import '../../models/provider/food_provider.dart';
import 'detail_food_screen.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({Key? key}) : super(key: key);

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 229, 233, 240),
      appBar: AppBar(
        title: const Text('Search Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Discover the',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'nutrition information.',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: createMaterialColor(const Color(0xff27A52F)), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: createMaterialColor(const Color.fromARGB(101, 39, 165, 47)),
                        borderRadius: const BorderRadius.all(Radius.circular(5))),
                    child: const Text(
                        'You can search by entering "1 cup of milk and 2 eggs" to find out the nutritional value of some foods'),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    child: TextFormField(
                      controller: _searchController,
                      maxLines: 100 ~/ 20,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        hintText: "What did you eat today ?",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _searchBtn(),
                  const SizedBox(height: 50),
                  const Image(image: AssetImage('assets/images/eating_illustration.png'), fit: BoxFit.cover)
                ],
              ),
            ),
          ),
        ),
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
            await context.read<FoodProvider>().getFoodBySearch(_searchController.text);
            List<Foods>? foods = context.read<FoodProvider>().foods;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailFoodScreen(foods: foods)),
            );
          },
        ),
      );
    });
  }

  Widget _btnTextWidget() {
    return Text(
      "Calculate Foods",
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
