import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calculator_app/controllers/calculator_controller.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1d2630),
        body: GetBuilder<CalculatorController>(
          init: CalculatorController(),
          builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          controller.userInput,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        child: Text(
                          controller.result,
                          style: const TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: controller.buttonList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return CustomButton(controller.buttonList[index], controller);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CustomButton(String text, CalculatorController controller){
    return InkWell(
      splashColor: const Color(0xFF1d2630),
      onTap: () {
        controller.handleButtons(text);
      },
      child: Ink(
        decoration: BoxDecoration(
          color: controller.getBgColor(text),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: const Offset(-3, -3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: controller.getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
