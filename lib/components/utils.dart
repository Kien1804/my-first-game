bool checkCollision(player, block) {
  final playerX = player.position.x;
  final playerY = player.position.y;
  final playerWidth = player.width;
  final playerHeight = player.height;

  final blockX = block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  final fixeX = player.scale.x < 0 ? playerX - playerWidth : playerX;

  return (playerY < block.y + blockHeight &&
      playerY + playerHeight > blockY &&
      fixeX < blockX + blockWidth &&
      fixeX + playerWidth > blockX);
}