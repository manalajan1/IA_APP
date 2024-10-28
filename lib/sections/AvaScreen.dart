import 'package:flutter/material.dart';

class AvaScreen extends StatelessWidget {
  const AvaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          
          // Texte "Ava" et Emoji
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Ava",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "👩‍🦰", // Emoji
                style: TextStyle(fontSize: 32),
              ),
            ],
          ),
          const SizedBox(height: 50),
          
          // Icône centrale avec effet de lueur
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.redAccent.withOpacity(0.5),
                  Colors.redAccent.withOpacity(0.1),
                ],
                stops: const [0.3, 1.0],
              ),
            ),
            child: const Icon(
              Icons.mic,
              size: 80,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 50),
          
          // Texte de présentation
          Text(
            "Salut [Nom]! Je suis Ava, une IA\nspécialisée dans la reconversion sportive.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Mon but est de t’assister.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          
          // Texte "Comment vas-tu ?"
          Text(
            "Comment vas-tu ?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Zone d'entrée avec micro
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.mic, color: Colors.white),
                    onPressed: () {
                      // Action à définir
                    },
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '...',
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // Action à définir
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const Spacer(),
          
          // Indicateur de pages
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, size: 8, color: Colors.redAccent),
              const SizedBox(width: 5),
              Icon(Icons.circle, size: 8, color: Colors.white24),
              const SizedBox(width: 5),
              Icon(Icons.circle, size: 8, color: Colors.white24),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
