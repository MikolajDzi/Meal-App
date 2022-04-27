import 'package:flutter/material.dart';

import '../dummy_data.dart';

Widget buildSectionTitle(BuildContext ctx, String title) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    child: Text(
      title,
      style: Theme.of(ctx).textTheme.titleLarge,
    ),
  );
}

Widget buildContainer(Widget child) {
  return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 200,
      width: 350,
      child: child);
}

class MealDetailsScreen extends StatelessWidget {
  static const routeName = "/meals-details";
  final Function toggleFavourites;
  final Function isFavourite;
  MealDetailsScreen(this.toggleFavourites, this.isFavourite);
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(" ${selectedMeal.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    child: Text(selectedMeal.ingredients[index]),
                    padding: const EdgeInsets.all(2),
                  ),
                ),
              ),
            ),
            buildSectionTitle(context, "Recipie"),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (context, index) => Column(children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text("#${index + 1}"),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  const Divider(
                    thickness: 2,
                    //indent: 2,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavourite(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavourites(mealId),
      ),
    );
  }
}
