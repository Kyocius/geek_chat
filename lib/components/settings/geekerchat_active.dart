import 'package:flutter/material.dart';
import 'package:geek_chat/controller/settings.dart';
import 'package:geek_chat/util/functions.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class GeekerChatSettingsComponent extends StatelessWidget {
  GeekerChatSettingsComponent({super.key});

  TextEditingController textEditingController = TextEditingController();

  Icon getTextInputIcon(bool isActive) {
    if (isActive) {
      return const Icon(
        Icons.check,
        color: Colors.green,
      );
    }
    return const Icon(Icons.send_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder: (controller) {
      textEditingController.text = controller.settings.license;
      return Wrap(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          ListTile(
            dense: true,
            title: Text(
              "GeekerChat Configuration".tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 0, bottom: 20, right: 10),
            child: TextField(
              // initialValue: controller.settings.license,
              controller: textEditingController,
              decoration: InputDecoration(
                  labelText: 'License',
                  filled: false,
                  suffixIcon: IconButton(
                      onPressed: () {
                        //TODO: call active
                        controller
                            .activeLicense(controller.settings.license)
                            .then((value) {
                          if (value) {
                            showCustomToast(
                                title: "Active Success".tr, context: context);
                          }
                        });
                      },
                      icon: getTextInputIcon(controller.settings.isActived))),
              onChanged: (value) {
                controller.settings.license = value;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    controller.saveSettings();
                    Get.back();
                  },
                  child: Text("Save".tr)),
              const SizedBox(width: 10),
              OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancel".tr)),
            ],
          ),
        ],
      );
    });
  }
}
