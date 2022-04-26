import 'package:flutter/material.dart';
import 'package:ketemaa/core/utilities/app_colors/app_colors.dart';
import 'package:ketemaa/core/utilities/app_spaces/app_spaces.dart';
import 'package:ketemaa/features/profile/_controller/shader.dart';

import '../presentation/edit_profile_page.dart';

class ProfileDetailsDivider extends StatelessWidget {
  const ProfileDetailsDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpaces.spaces_height_5,
        Divider(
          color: AppColors.greyWhite,
          thickness: 1.0,
        ),
        AppSpaces.spaces_height_5,
      ],
    );
  }
}

class ProfileItem extends StatelessWidget {
  final Icon? icon;
  final Image? image;
  final Text? text;

  const ProfileItem({Key? key,
    this.icon,
    this.image,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Image.asset(
            'assets/media/image/edit.png',
            height: 25,
            width: 25,
            color: Colors.white,
          ),
          AppSpaces.spaces_width_10,
          const Text(
            'Profile Edit',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          const Spacer(),
          const Icon(Icons.navigate_next)
        ],
      ),
    );
  }
}

class CustomProfileElements extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final VoidCallback onTap;

  const CustomProfileElements(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
          onTap: onTap,
          splashColor: Colors.orangeAccent,
          child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff454F70),
                    Color(0xff3F496A),
                    Color(0xff374162),
                    Color(0xff303B5B),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 10,
                      ),
                      Shader(
                        icon: Icon(icon, color: Colors.white),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Text(
                        text.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  const Shader(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ))),
    );
  }
}
