import 'package:flutter/material.dart';

class SummaryIconWithBuble extends StatelessWidget {
  const SummaryIconWithBuble(
      {required this.icon, required this.matches, super.key});
  final Icon icon;
  final int matches;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // El icono principal
        icon,
        // La burbuja con el número
        Positioned(
          right: 0, // Posiciona la burbuja a la derecha del ícono
          bottom: -10, // Posiciona la burbuja en la parte superior del ícono
          child: Container(
            padding: const EdgeInsets.all(
                5), // Ajusta el espacio dentro de la burbuja
            decoration: const BoxDecoration(
              color: Color.fromARGB(
                  255, 96, 143, 187), // Color de fondo de la burbuja
              shape: BoxShape.circle, // Hace que el contenedor sea circular
            ),
            child: Text(
              matches.toString(), // Número que se mostrará en la burbuja
              style: const TextStyle(
                color: Colors.white, // Color del texto
                fontSize: 12, // Tamaño de la fuente
              ),
            ),
          ),
        ),
      ],
    );
  }
}
