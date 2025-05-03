import 'package:raylib/raylib.dart';

class Pipe {
  Vector2 pos;
  bool passed = false;

  Texture2D texture;
  
  Pipe(this.pos, this.texture);

  void render(int gap) {
    drawTextureV(
      this.texture, 
      Vector2(this.pos.x, this.pos.y + gap.toDouble()), 
      Color.white
    );

    // top pipe (flip vertically using negative height)
    drawTextureRec(
      this.texture,
      Rectangle(0.0, 0.0, this.texture.width.toDouble(), -this.texture.height.toDouble()),
      Vector2(this.pos.x, (this.pos.y - this.texture.height).toDouble()),
      Color.white,
    );
  }
 
}
