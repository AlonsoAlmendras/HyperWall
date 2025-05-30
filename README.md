# Virtual Reality Experience in Godot 4

This project is a virtual reality (VR) experience developed using Godot 4.4 during a research internship at Inria. The experience consists of three immersive environments that showcase different levels of technological interaction:

- **No-Tech Space**: Static information panels.
- **Medium-Tech Space**: Interactive panels and moderate user interaction.
- **High-Tech Space**: A fully immersive and interactive VR environment.

---

## 🧰 Requirements

- [Godot Engine 4.4](https://godotengine.org/download)
- [Blender 3.0+](https://www.blender.org/download/) (only if you want to edit or reimport `.blend` files)
- A VR-ready headset compatible with OpenXR (e.g., Oculus Quest via Link, HTC Vive, Valve Index, etc.)
- [OpenXR Plugin for Godot 4](https://github.com/GodotVR/godot_openxr)

---

## ⚙️ Setup Instructions

### Step 2: Install the OpenXR Plugin

Godot does not support VR out of the box. You need to install the OpenXR plugin to enable VR support:

1. Go to the [OpenXR Plugin GitHub Releases page](https://github.com/GodotVR/godot_openxr/releases).
2. Download the release compatible with **Godot 4.4**.
3. Extract the contents into the `addons/` folder in the root of this project. If the folder doesn't exist, create it.
4. Open the project in Godot.
5. Go to **Project → Project Settings → Plugins**.
6. Find `OpenXR` in the list and click **Enable**.

---

### Step 3: Configure OpenXR in the Project Settings

1. In Godot, go to **Project → Project Settings**.
2. Navigate to **XR → General**.
3. Set the **XR Runtime** to `OpenXR`.
4. Enable the checkbox **XR → Use XR**.
5. (Optional) Enable **XR → Enable VR mode on start** if you want the VR mode to launch automatically when the project starts.

Ensure you have a working OpenXR runtime installed on your system:
- On **Windows**, install and run either **SteamVR** or use **Oculus Link** (if using Quest).
- On **Linux**, you can use **Monado** or **SteamVR** with OpenXR runtime support.

---

### Step 4: Set Blender Path (for `.blend` files)

If your project includes `.blend` files and you want Godot to import them directly, configure the Blender path:

1. In Godot, go to **Editor → Editor Settings**.
2. Scroll to **Filesystem > External**.
3. Click **Browse** and set the path to your Blender executable.

Examples:
- **Windows**: `C:\Program Files\Blender Foundation\Blender 3.6\blender.exe`
- **Linux**: `/usr/bin/blender`
- **macOS**: `/Applications/Blender.app/Contents/MacOS/Blender`

If this step is skipped, you may see an error such as:

> "Se requiere Blender 3.0 o superior para importar archivos '.blend'. Por favor, proporcione una ruta válida a un ejecutable de Blender."

If you prefer, you can export `.blend` files to `.glb` or `.gltf` from Blender and import those instead.

---

### Step 5: Run the Project

1. Ensure your VR headset is connected and the OpenXR runtime is active.
2. Open the project in the Godot editor.
3. Press `F5` or click the **Play** button to launch the project.
4. The main VR scene should load. You will be placed into an initial space where you can navigate between the three environments.

If the VR headset does not respond or display the experience, try:

- Launching your headset software manually (e.g., SteamVR or Oculus Link).
- Rechecking the OpenXR plugin and runtime.
- Ensuring the correct runtime is set as the system default.

---

## 🌐 Environments Overview

Each of the three environments is designed to represent a different technological context:

### 🟢 No-Tech Room
- Static informational boards and panels.
- Users can look around but cannot interact.
- Ideal for passive information display in a VR space.

### 🟡 Medium-Tech Room
- Interactive UI elements like toggles, info panels, or menus.
- Moderate level of user interaction through VR controllers.

### 🔴 High-Tech Room
- Fully immersive environment with advanced interactions.
- Includes spatial audio, dynamic lighting, and reactive elements.
- Designed to explore the potential of high-tech VR experiences.

---

## 🧪 Development Notes

- All scenes are modular and located under the `/scenes/` folder.
- Each environment is self-contained and can be expanded independently.
- This project uses native Godot nodes for input and interaction (no custom C++ modules).
- Raycasting is used for selection and interaction via VR controllers.

---
## ✍️ Author

Developed by Alonso as part of a research internship at **Inria**.
