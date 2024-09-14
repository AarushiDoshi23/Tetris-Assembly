# Tetris Game in Assembly

This is a simple implementation of the classic Tetris game, written in assembly for my CSCB58 course at the University of Toronto. The game is designed to run on a bitmap display with specific configurations, and it uses basic assembly instructions to handle gameplay mechanics like piece movement, rotation, and collision detection.

## How to Play

- Use the WASD keys to move and rotate the falling Tetris pieces.
- The goal is to complete as many horizontal lines as possible without letting the pieces stack up to the top of the screen.
- The game speeds up as you progress, increasing the difficulty.

## Bitmap Display Configuration

The game uses a bitmap display with the following configuration:

- **Unit width in pixels:** 16
- **Unit height in pixels:** 16
- **Display width in pixels:** 256
- **Display height in pixels:** 512
- **Base Address for Display:** `0x10008000 ($gp)`

## Features

- Basic Tetris mechanics: move, rotate, and clear lines.
- Bitmap-based rendering for pieces and the game board.
- Optimized for performance on assembly-level hardware interaction.

## Requirements

- An assembly language development environment or simulator compatible with your system.
- Bitmap display setup according to the configuration specified above.

## Credits

This project was developed as part of the CSCB58 course at the University of Toronto.

## Contributors

- Aarushi Doshi
- Kshitij Kapoor

