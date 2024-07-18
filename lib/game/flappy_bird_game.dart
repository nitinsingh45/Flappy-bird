import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/src/text/renderers/text_renderer.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird_game/game/assets.dart';
import 'package:flappy_bird_game/game/configuration.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird_game/components/background.dart';
import 'package:flappy_bird_game/components/bird.dart';
import 'package:flappy_bird_game/components/ground.dart';
import 'package:flappy_bird_game/components/pipe_group.dart';
import 'package:flappy_bird_game/game/shared-prefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class FlappyBirdGame extends FlameGame with TapDetector,HasCollisionDetection{
  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;
  late TextComponent high_Score;
  int highScore = 0;
  HighScoreManager highScoreManager = HighScoreManager();
  @override
  Future<void> onLoad() async{
    super.onLoad();
    highScore = await highScoreManager.getHighScore();
    high_Score = buildHighScore();
    high_Score.text = 'Highest Score: ${highScore}';
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore(),
      high_Score,
    ]);
    interval.onTick = () => add(PipeGroup());
    playBackGroundSong();
  }
@override
  void onTap() {
    super.onTap();
    bird.fly();
  }
  void playBackGroundSong(){
    FlameAudio.bgm.play(Assets.background); // Adjust the volume as needed
  }
  @override
  void onRemove() {
    FlameAudio.bgm.stop();
    super.onRemove();
  }
  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
    if (bird.score > highScore) {
      highScore = bird.score;
      highScoreManager.setHighScore(highScore);
      high_Score.text = 'Highest Score: ${highScore}';
    }
  }

  TextComponent<TextRenderer> buildScore() {
    return TextComponent(
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 40, fontFamily: 'Game', fontWeight: FontWeight.bold),
        ));
  }
  TextComponent<TextRenderer> buildHighScore() {
    return TextComponent(
        position: Vector2(10, 10),
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 24, fontFamily: 'Game', fontWeight: FontWeight.bold),
        ));
  }
}

class ScoreTextComponent extends TextComponent {
  ScoreTextComponent({required Vector2 position, required int highScore})
      : super(
    text: 'High Score: $highScore',
    position: position,
    textRenderer: TextPaint(
      style: const TextStyle(
          fontSize: 40, fontFamily: 'Game', fontWeight: FontWeight.bold),
    ),
  );
}