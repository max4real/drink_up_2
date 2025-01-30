import 'package:drink_up_2/features/cocktail/presentation/controller/c_cocktail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CockTailPage extends StatelessWidget {
  final String name;
  const CockTailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    CockTailController controller = Get.put(CockTailController());
    controller.eitherFailureOrCockTail(name: name);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Let's Drink",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.cocktailList,
        builder: (context, value, child) {
          if (value.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 4 / 5),
              itemCount: value.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final each = value[index];
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    color:
                        const Color.fromARGB(255, 108, 118, 228).withOpacity(1),
                    // const Color.fromARGB(255, 148, 135, 246) .withOpacity(1),
                    child: Column(
                      children: [
                        Expanded(
                          child: Hero(
                            tag: each.image,
                            child: Image.network(
                              each.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              // borderRadius: BorderRadius.circular(5)
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.5, vertical: 4),
                            child: Text(
                              each.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (controller.failure.value != null) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  controller.eitherFailureOrCockTail(name: name);
                },
                child: Text(
                  controller.failure.value!.errorMessage,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
