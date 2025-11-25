# 🎮 Terminal Raycasting

A mini raycasting game engine that runs entirely in the terminal, featuring ASCII-based 3D rendering with dynamic lighting and shadows.

<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/a40e43d2-d54e-42cb-bac2-995aa920456d" />

[![Video Demo](https://img.shields.io/badge/▶️-Watch%20Demo-red?style=for-the-badge&logo=youtube)](https://youtu.be/Y5R43J6mi88)

## 🌟 Overview

This project implements a 3D raycasting engine in the terminal, where each pixel's color and brightness is determined by ASCII character density. The rendering creates the illusion of depth using:

- **Character density** for brightness gradients
- **Distance-based scaling** for perspective
- **Dynamic shadows** that intensify with distance

## 🏗️ Architecture

The project is structured into three core systems:

### 1. 2D Map System
A bidimensional matrix where:
- `0` = Empty space (walkable)
- `1` = Wall (solid)

The player navigates this 2D grid, which serves as the foundation for 3D projection.

### 2. Raycasting Engine
The player emits rays that calculate distances to the nearest wall in each direction. Each ray traverses the map until it hits a wall, recording the distance traveled.

### 3. 3D Projection
Transforms 2D ray distances into 3D visuals using perspective mathematics:
- **Closer objects** → Rendered larger and brighter
- **Distant objects** → Rendered smaller and darker

## 📁 Project Structure

### **`map.c`**
Handles map creation and management.

**Key Functions:**
- Map matrix creation and initialization
- 2D map rendering in terminal
- File-based map import (validates uniform line lengths)

**Map Properties:**
- `width`, `height` - Map dimensions
- `data` - Integer matrix
- `tilesize` - Grid cell dimensions

> **Memory Management:** Always call `freeMap()` after use to prevent leaks.

### **`camera.c`**
Manages camera positioning, field of view, and raycasting logic.

**Raycasting Algorithm:**
1. Get current camera position and direction
2. Find next grid boundary in the viewing direction
3. Check if current block contains a wall
4. If wall detected, calculate distance using Pythagorean theorem:
   ```
   distance = √(cathetus1² + cathetus2²)
   ```
5. Store distance in camera's ray array
6. Repeat for all rays in FOV

### **`screen.c`**
Renders the 3D projection from ray data.

**Perspective Formula:**
```
WallHeight = (WallSize × RayLength) / PlaneDistance
```

Where:
- `WallSize` - Base wall height
- `PlaneDistance` - Camera-to-screen distance
- `RayLength` - Distance to wall from camera

### **`move.c`**
Implements player movement and collision detection.

**Controls:**
- `UP/DOWN` - Move forward/backward
- `LEFT/RIGHT` - Rotate camera

**Features:**
- Boundary collision detection
- Wall collision prevention
- Smooth rotation mechanics

### **`pixel.c`**
ASCII rendering system with dynamic lighting.

**Components:**
- Character density scale for brightness gradients
- ANSI escape sequences for terminal colors
- Brightness vision system for ambient lighting control

Example density scale (dark → light):
```
" .:-=+*#%@"
```

### **`split.c`**
String tokenization utility for map file parsing.

Splits strings by delimiter and returns an array of substrings for map import operations.

### **`point.c`**
Foundation geometry module used across the entire project.

**Provides:**
- Point structure definition
- Vector arithmetic operations
- Line calculations
- Distance and angle computations

## 🎯 How It Works

1. **Map Loading:** Import or create a 2D grid map
2. **Ray Emission:** Camera shoots rays across its field of view
3. **Distance Calculation:** Each ray measures distance to nearest wall
4. **3D Rendering:** Distances are converted to wall heights with perspective
5. **Lighting:** ASCII characters create depth through density-based shading
6. **Movement:** Player navigates with collision detection

## 🚀 Getting Started

### Prerequisites
- C compiler (GCC/Clang)
- Terminal with ANSI color support
- Make (optional)

### Building
```bash
make
```

### Running
```bash
./raycaster [map_file]
```

## 🎨 Technical Highlights

- **Pure Terminal Rendering** - No graphics libraries required
- **Real-time Raycasting** - Efficient distance calculations
- **Dynamic Lighting** - Distance-based shadow gradients
- **Collision System** - Prevents clipping through walls
- **Modular Design** - Clean separation of concerns

## 📖 Map Format

Create custom maps using text files:
```
1 1 1 1 1
1 0 0 0 1
1 0 1 0 1
1 0 0 0 1
1 1 1 1 1
```

**Requirements:**
- Uniform line lengths (same number of elements per row)
- `0` for empty space, `1` for walls

---

*Bringing retro 3D graphics to your terminal.*
