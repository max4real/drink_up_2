import 'package:cached_network_image/cached_network_image.dart';
import 'package:drink_up_2/features/cocktail/presentation/pages/v_cocktail.dart';
import 'package:drink_up_2/features/home/presentation/controller/c_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

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
        valueListenable: controller.liquorList,
        builder: (context, value, child) {
          if (value.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 4 / 5,
              ),
              itemCount: value.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final each = value[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => CockTailPage(name: each.name));
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 223, 225, 230),
                    child: Column(
                      children: [
                        Center(
                          child: CachedNetworkImage(
                            imageUrl: each.image,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 18, 16, 54)
                                  .withOpacity(0.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            child: Text(
                              each.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
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
                  controller.eitherFailureOrLiquor();
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
