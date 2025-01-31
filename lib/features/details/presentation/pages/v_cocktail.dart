import 'package:cached_network_image/cached_network_image.dart';
import 'package:drink_up_2/features/cocktail/business/entities/e_cock_tail.dart';
import 'package:drink_up_2/features/details/presentation/controller/c_cocktail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrinkDetailPage extends StatelessWidget {
  final CockTailEntities cockTailEntities;
  const DrinkDetailPage({super.key, required this.cockTailEntities});

  @override
  Widget build(BuildContext context) {
    final DrinkDetailControlller controller = Get.put(DrinkDetailControlller());
    controller.eitherFailureOrDrinkdetail(id: cockTailEntities.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(cockTailEntities.name),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          _buildCocktailImage(),
          Expanded(
            child: SingleChildScrollView(
              child: ValueListenableBuilder(
                valueListenable: controller.drinkDetailEntities,
                builder: (context, value, child) {
                  if (value == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: [
                      _buildIngredientsList(value.cockTaillDetailEntitiesList),
                      _buildInstructions(value.instructions),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCocktailImage() {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Hero(
        tag: cockTailEntities.image,
        child: CachedNetworkImage(
          imageUrl: cockTailEntities.image,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildIngredientsList(List ingredients) {
    return SizedBox(
      width: double.infinity,
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: ingredient.liquorEntities.image,
                  height: 45,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(height: 5),
                Text(
                  ingredient.liquorEntities.name,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                Text(
                  ingredient.measurement.toString().toUpperCase(),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInstructions(String instructions) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.black,
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Instruction",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            instructions,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
