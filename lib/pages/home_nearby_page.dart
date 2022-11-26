import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hotelio/config/app_assets.dart';
import 'package:hotelio/config/app_colors.dart';
import 'package:hotelio/config/app_format.dart';
import 'package:hotelio/config/app_route.dart';
import 'package:hotelio/config/session.dart';
import 'package:hotelio/controller/nearby_controller.dart';
import 'package:hotelio/controller/user_controller.dart';
import 'package:hotelio/models/hotel_model.dart';

class HomeNearbyPage extends StatelessWidget {
  HomeNearbyPage({Key? key}) : super(key: key);
  final cNearby = Get.put(NearbyController());
  final cUser = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 24),
        children: [
          header(context),
          searchField(),
          categories(),
          hotels(),
        ],
      ),
    );
  }

  Widget hotels() {
    return GetBuilder<NearbyController>(builder: (_) {
      List<HotelModel> list = _.category == 'All Place'
          ? _.listHotel
          : _.listHotel.where((e) => e.category == cNearby.category).toList();

      if (list.isEmpty) {
        return Column(
          children: const [
            SizedBox(
              height: 200,
            ),
            Text(
              'Tidak Ada Data',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          HotelModel hotel = list[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.detail, arguments: hotel);
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                16,
                index == 0 ? 20 : 8,
                16,
                index == list.length - 1 ? 16 : 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        hotel.cover,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Start from ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                  Text(
                                    AppFormat.currency(hotel.price.toDouble()),
                                    style: const TextStyle(
                                      color: AppColor.secondary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    '/night',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        RatingBar.builder(
                            initialRating: hotel.rate,
                            maxRating: 0,
                            direction: Axis.horizontal,
                            ignoreGestures: true,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 18,
                            unratedColor: AppColor.starInActive,
                            itemBuilder: (context, _) {
                              return const Icon(
                                Icons.star_rate_rounded,
                                color: AppColor.starActive,
                              );
                            },
                            onRatingUpdate: (rating) {})
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget categories() {
    return SizedBox(
      height: 60,
      child: GetBuilder<NearbyController>(builder: (_) {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _.categories.length,
            itemBuilder: (context, index) {
              String category = _.categories[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  index == 0 ? 16 : 20,
                  0,
                  index == cNearby.categories.length - 1 ? 16 : 0,
                  20,
                ),
                child: InkWell(
                  onTap: () {
                    _.category = category;
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: category == _.category
                            ? AppColor.primary
                            : Colors.white),
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }

  Widget searchField() {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(top: 20, bottom: 30),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: TextField(
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search by name or city',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(45),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColor.secondary,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: const Center(
                  child: ImageIcon(
                    AssetImage(AppAsset.iconSearch),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showMenu(
                    context: context,
                    position: const RelativeRect.fromLTRB(16, 16, 0, 0),
                    items: [
                      const PopupMenuItem(
                        value: 'logout',
                        child: Text(
                          'Logout',
                        ),
                      ),
                    ],
                  ).then((value) {
                    if (value == 'logout') {
                      Session.clearUser();
                      Navigator.pushReplacementNamed(context, AppRoute.signin);
                    }
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    AppAsset.profile,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo,',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    cUser.data.name!,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Near Me',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              Obx(() {
                return Text(
                  '${cNearby.listHotel.length} hotels',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
