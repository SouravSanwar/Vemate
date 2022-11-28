import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ketemaa/features/vault/NewDesignCard/vault_collectible_card.dart';
import 'package:ketemaa/core/models/ValutGraphs/VaultStatusModel.dart';
import 'package:ketemaa/features/vault/NewDesignCard/vault_comics_card.dart';
import '../../../../core/utilities/app_colors/app_colors.dart';

class SeparateVaultCard extends StatefulWidget {
  final Collectible? data;
  final Comic? data1;

  const SeparateVaultCard({Key? key, this.data, this.data1}) : super(key: key);

  @override
  State<SeparateVaultCard> createState() => _SeparateVaultCardState();
}

class _SeparateVaultCardState extends State<SeparateVaultCard> {
  int? stepSelected = 0;
  List<String> graphType = [
    'Comics',
    'Collectibles',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.height * .013),
      height: Get.height * .214,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: AppColors.separateVaultCardGradient,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(graphType.length, (index) {
                return Container(
                  height: Get.height * .05,
                  width: Get.width * .4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(index == 0 ? 6 : 0),
                      topRight: Radius.circular(index == 0 ? 0 : 6),
                      bottomLeft: Radius.circular(index == 0 ? 6 : 0),
                      bottomRight: Radius.circular(index == 0 ? 0 : 6),
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffAC86E7),
                        Color(0xffA57EE7),
                        Color(0xff906AEB),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        stepSelected = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(1),
                      width: Get.width * .4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(index == 0 ? 6 : 0),
                          topRight: Radius.circular(index == 0 ? 0 : 6),
                          bottomLeft: Radius.circular(index == 0 ? 6 : 0),
                          bottomRight: Radius.circular(index == 0 ? 0 : 6),
                        ),
                        gradient: stepSelected == index
                            ? AppColors.separateVaultCardGradientBtn
                            : AppColors.separateVaultCardGradient,
                      ),
                      child: Text(
                        graphType[index].toString(),
                        style: Get.textTheme.titleSmall!
                            .copyWith(color: stepSelected == index ? Colors.white : Colors.grey),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          stepSelected == 0 ? VaultComicsCard(data: widget.data1!) : VaultCollectiblesCard(data: widget.data!)
        ],
      ),
    );
  }
}
