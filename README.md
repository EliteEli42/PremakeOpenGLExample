# PremakeOpenGLExample

A small C++ OpenGL example project built with Premake. This repository demonstrates how to organize a Visual Studio solution, configure third-party libraries, and manage multiple projects through modular Lua build scripts.

## Overview

The project uses **Premake** to generate Visual Studio project files and provides a simple OpenGL application using GLFW and GLAD.

The repository is designed to demonstrate a clean, extensible project structure where application projects and third-party libraries are configured independently.

### Features

* **Premake build system** – Generate Visual Studio solutions from Lua scripts.
* **Modular project configuration** – Separate Premake scripts for examples and vendor libraries.
* **OpenGL 4.6** – Create an OpenGL core-profile context.
* **GLFW** – Handle window creation, input, and event processing.
* **GLAD** – Load OpenGL functions.
* **GLM** – Provide a header-only mathematics library.
* **Multiple build configurations** – Debug, Release, and Dist.
* **Organized Visual Studio solution** – Group examples and third-party libraries separately.

## Project Structure

```text
PremakeOpenGLExample/
├── Examples/
│   ├── premake5.lua
│   └── HelloWindow/
│       ├── premake5.lua
│       ├── include/
│       └── src/
│           └── main.cpp
├── Vendor/
│   ├── premake/
│   │   └── bin/
│   │       └── premake5.exe
│   ├── glfw/
│   │   └── premake5.lua
│   ├── glad/
│   │   └── premake5.lua
│   ├── glm/
│   │   └── premake5.lua
│   └── premake5.lua
├── DebugDir/
├── build/                 # Generated project files
├── .gitattributes
├── .gitignore
├── README.md
├── RUNpremake.bat
└── premake5.lua
```

*Note: The tree above illustrates the intended project layout. Third-party libraries contain additional source files and headers.*

## Requirements

* Windows
* Visual Studio with the C++ development tools and a compatible Windows SDK
* The Premake executable included in the repository
* A graphics driver supporting OpenGL 4.6 for the `HelloWindow` example

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/EliteEli42/PremakeOpenGLExample.git
cd PremakeOpenGLExample
```

### 2. Generate the Visual Studio solution

Run the provided batch script:

```bat
RUNpremake.bat
```

The script creates `DebugDir` if necessary and invokes the bundled Premake executable to generate the Visual Studio projects.

Alternatively, run Premake manually from the repository root:

```bat
Vendor\premake\bin\premake5.exe vs2026
```

The generated solution is located in:

```text
build/PremakeOpenGLExample.sln
```

Open the solution in a compatible version of Visual Studio.

### 3. Build and run

Select the desired configuration and build the solution.

The `HelloWindow` project is configured as the startup project. Press **F5** to launch it with the Visual Studio debugger, or **Ctrl+F5** to run without debugging.

The application creates an OpenGL window and clears the framebuffer with a background color. Press **Escape** to close the window.

## Build Configurations

The workspace defines three configurations:

| Configuration | Purpose                                                                                   |
| ------------- | ----------------------------------------------------------------------------------------- |
| `Debug`       | Development builds with debug symbols and the debug runtime.                              |
| `Release`     | Optimized builds that retain debug symbols for troubleshooting.                           |
| `Dist`        | Distribution builds with full optimization, link-time optimization, and no debug symbols. |

The `HelloWindow` project uses a console application in Debug mode so that diagnostic output remains visible. Release and Dist use the Windows application subsystem.

## Build Output

Generated project files, intermediate objects, and compiled binaries are kept separate from the source files.

| Directory    | Purpose                                                                     |
| ------------ | --------------------------------------------------------------------------- |
| `build/`     | Generated Visual Studio solution and project files.                         |
| `build/obj/` | Intermediate compiler output, organized by configuration and project.       |
| `build/bin/` | Compiled executables and libraries, organized by configuration and project. |
| `DebugDir/`  | Working directory used when launching applications from Visual Studio.      |

The generated `build/` and `bin/` directories are excluded from version control.

## Premake Architecture

The project uses a root Premake script that defines the workspace and shared build settings. Individual directories provide their own `premake5.lua` files, keeping each project configuration close to its source files.

### Root configuration

The root `premake5.lua` defines:

* Workspace name and build configurations
* Target architecture
* C++20 language standard
* Compiler warnings and conformance settings
* Runtime library settings
* Output directories
* Platform-specific definitions and compiler options

It then includes the vendor libraries and example projects.

### Vendor projects

`Vendor/premake5.lua` includes the individual library configurations.

* **GLFW** – Configured as a static library.
* **GLAD** – Configured as a static library.
* **GLM** – Configured as a header-only utility project.

Each library has its own Premake script, making it possible to manage its source files, include directories, and platform-specific settings independently.

### Example projects

`Examples/premake5.lua` groups application examples under the `Examples` filter in Visual Studio.

Each example has its own directory and Premake configuration. The root workspace settings are inherited automatically, while project-specific settings remain local to the example.

This approach makes it straightforward to add further examples without putting every project configuration into a single Lua file.

## Adding a New Example

To add another application:

1. Create a new directory under `Examples/`.
2. Add the project's source files and headers.
3. Create a `premake5.lua` file that defines the project, its files, include directories, and required libraries.
4. Add an `include` statement for the new project to `Examples/premake5.lua`.
5. Regenerate the Visual Studio solution using `RUNpremake.bat`.

Premake evaluates the file patterns when generating the projects. Regenerate the solution whenever you add or remove source files or change the build configuration.

## License

This repository incorporates third-party libraries, each of which is distributed under its own license. Refer to the respective library's license for its terms and conditions.
