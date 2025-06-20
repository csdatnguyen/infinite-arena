# infinite-arena
Top-down rogue-lite game

## How to Run the Game

1. Open the project in **Godot 4**
2. In the **Script** tab, open and run (Ctrl+Shift+X) the script at: res://tools/save_all_scenes.gd
(This ensures all scenes are saved cleanly and prevents UID-related warnings on new machines.)
3. In the **Project** menu, go to **Project Settings → Application → Run**.
4. Set the **Main Scene** to: res://scenes/survivors_game/survivors_game.tscn
5. Press **F5** or click **Play** to run the game.

This will launch Infinite Arena starting from the core game controller scene.


## Controls

- **W / A / S / D** – Move
- **Space** – Dash
- **U** – Increase attack speed (Power-up simulation)
- **I** – Increase bullet size (Power-up simulation)
- **O** – Switch shooting mode (Nearest enemy ↔ Mouse direction)
