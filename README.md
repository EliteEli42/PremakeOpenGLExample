# PremakeOpenGLExample

A collection of small C++ and OpenGL examples built with Premake. This repository demonstrates how to organize a Visual Studio solution and configure multiple projects and third-party libraries using modular Lua build scripts.

## Overview

The project uses Premake to generate Visual Studio project files. It provides two example applications and keeps third-party dependencies in separate projects.

### Features

* **Premake** – Generate Visual Studio solutions from Lua scripts.
* **Modular configuration** – Separate scripts for examples and third-party libraries.
* **OpenGL** – Create windows and render graphics using OpenGL.
* **GLFW** – Window creation, input, and event processing.
* **GLAD** – OpenGL function loading.
* **GLM** – Mathematics library for graphics programming.
* **C++20** – Use modern C++ language features.
* **Multiple configurations** – Debug, Release, and Dist.

## Project Structure

```text
PremakeOpenGLExample/
├── Examples/
│   ├── HelloWindow/
│   └── HelloTriangle/
├── Vendor/
│   ├── premake/
│   ├── glfw/
│   ├── glad/
│   └── glm/
├── .gitattributes
├── .gitignore
├── README.md
├── RUNpremake.bat
└── premake5.lua
```

## Requirements

* Windows
* Visual Studio with the C++ development tools and a compatible Windows SDK
* The Premake executable included in the repository
* A graphics driver compatible with the OpenGL version requested by the example

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/EliteEli42/PremakeOpenGLExample.git
cd PremakeOpenGLExample
```

### 2. Generate the Visual Studio solution

Run the batch script from the repository root:

```bat
RUNpremake.bat
```

This creates the working directory if necessary and runs Premake to generate the Visual Studio solution.

Alternatively, invoke Premake directly:

```bat
Vendor\premake\bin\premake5.exe vs2026
```

The generated solution is located in the `build/` directory.

### 3. Build and run

Open the generated solution in Visual Studio.

Select a project, choose the desired configuration, and build the solution. Run the selected application using **F5** to start it with the debugger.

## Examples

### HelloWindow

A minimal application demonstrating how to create and manage a window using GLFW and initialize OpenGL.

### HelloTriangle

An OpenGL example focused on rendering a triangle. It serves as a starting point for experimenting with shaders, buffers, and the graphics pipeline.

## Build Configurations

The workspace defines three configurations:

| Configuration | Purpose                                                                    |
| ------------- | -------------------------------------------------------------------------- |
| `Debug`       | Development builds with debug symbols and a console for diagnostic output. |
| `Release`     | Optimized builds that retain debug symbols for troubleshooting.            |
| `Dist`        | Distribution builds with stronger optimization and no debug symbols.       |

## Build Output

Generated project files and compiled output are kept separate from the source code.

| Directory    | Purpose                                                                |
| ------------ | ---------------------------------------------------------------------- |
| `build/`     | Generated Visual Studio solution and project files.                    |
| `build/bin/` | Compiled executables and libraries.                                    |
| `build/obj/` | Intermediate compiler output.                                          |
| `DebugDir/`  | Working directory used when launching applications from Visual Studio. |

Generated build artifacts are excluded from version control.

## Premake Architecture

The build configuration is split into multiple Lua scripts to keep the repository easy to extend.

### Root configuration

The root `premake5.lua` defines the workspace, common compiler settings, build configurations, and output directories. It then includes the vendor projects and examples.

### Vendor projects

Each third-party library has its own Premake configuration.

* **GLFW** is built as a static library.
* **GLAD** is built as a static library.
* **GLM** is configured as a header-only utility project.

This keeps dependency configuration separate from the example applications.

### Example projects

The `Examples/` directory contains independent applications. Each example has its own Premake script and inherits common settings from the root workspace.

The `Examples/premake5.lua` script groups the examples in Visual Studio, while `Vendor/premake5.lua` groups the third-party libraries.

## Adding a New Example

1. Create a new directory under `Examples/`.
2. Add the source files and headers for the application.
3. Create a `premake5.lua` file for the new project.
4. Add an `include` statement to `Examples/premake5.lua`.
5. Regenerate the solution by running `RUNpremake.bat`.

Premake evaluates file patterns when generating project files, so regenerate the solution whenever files are added or removed.

## License

This repository incorporates third-party libraries that may be distributed under different licenses. Refer to the respective library's license files for their terms and conditions.
