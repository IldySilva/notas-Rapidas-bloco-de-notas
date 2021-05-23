import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';

class TelaNova extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Sobre o app",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/images/notepad.png"),
              AutoSizeText(
                "Notas Rápidas",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: Get.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "O Mais Simples Bloco de Notas Rápidas",
                        maxFontSize: 14,
                        minFontSize: 12,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                      AutoSizeText(
                        "Faça os Seus Apontamentos  ",
                        minFontSize: 12,
                        textAlign: TextAlign.left,
                        maxFontSize: 14,
                        maxLines: 2,
                      ),
                      AutoSizeText(
                        "Não esqueça de nada",
                        minFontSize: 12,
                        textAlign: TextAlign.left,
                        maxFontSize: 14,
                        maxLines: 2,
                      ),
                      AutoSizeText("2020,Versão 1.0.0",
                          minFontSize: 12,
                          maxFontSize: 14,
                          maxLines: 2,
                          textAlign: TextAlign.justify),
                      AutoSizeText(
                        "Desenvolvido por Ildeberto Vasconcelos",
                        minFontSize: 12,
                        maxFontSize: 14,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
