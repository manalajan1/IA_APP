import 'package:flutter/material.dart';

class ChatInputBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSend, onClickCamera, onClickMicrophone;

  const ChatInputBox({
    super.key,
    this.controller,
    this.onSend,
    this.onClickCamera,
    this.onClickMicrophone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color:  const Color.fromARGB(255, 176, 179, 110),
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Bouton pour le microphone
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFd9de20), // Couleur de départ
                    Color(0xFFa8c22d), // Couleur de fin pour le dégradé
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30), // Arrondir les bords
              ),
              child: IconButton(
                onPressed: onClickMicrophone,
                icon: const Icon(Icons.mic), // Icône du microphone
                color: Colors.black, // Couleur de l'icône
              ),
            ),
          ),

          // Champ de texte
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 6,
              cursorColor: const Color(0xFFd9de20), // Couleur du curseur
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                hintText: 'Message',
                hintStyle: TextStyle(color: Color.fromARGB(255, 16, 16, 16)), // Couleur de l'indice
                border: InputBorder.none,
              ),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
          ),

          // Bouton pour la pièce jointe à droite
          if (onClickCamera != null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFd9de20), // Couleur de départ
                      Color(0xFFa8c22d), // Couleur de fin pour le dégradé
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30), // Arrondir les bords
                ),
                child: IconButton(
                  onPressed: onClickCamera,
                  icon: const Icon(Icons.attach_file), // Icône de pièce jointe
                  color: Colors.black, // Couleur de l'icône
                ),
              ),
            ),

          // Bouton d'envoi
          Padding(
            padding: const EdgeInsets.all(4),
            child: FloatingActionButton.small(
              onPressed: onSend,
              backgroundColor: const Color(0xFFd9de20), // Couleur du bouton d'envoi
              child: const Icon(Icons.send_rounded, color: Colors.black), // Icône d'envoi
            ),
          ),
        ],
      ),
    );
  }
}
