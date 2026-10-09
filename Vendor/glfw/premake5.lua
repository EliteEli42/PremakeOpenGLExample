-- ============================================================================
-- Project: glfw (static library)
-- Loaded from the root premake5.lua via `include "glfw"`.
-- Paths in this file are relative to this folder (glfw/).
-- Workspace-wide settings are inherited from the root script.
-- ============================================================================

project "glfw"
    kind "StaticLib"
    language "C"
    systemversion "latest"

    -- Public headers.
    files {
        "include/glfw/**.h"
    }

    -- Common internal headers.
    files {
        "src/internal.h",
        "src/platform.h",
        "src/mappings.h"
    }

    -- Common implementation.
    files {
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/platform.c",
        "src/vulkan.c",
        "src/window.c",
        "src/egl_context.c",
        "src/osmesa_context.c"
    }

    -- Null platform backend (headless).
    files {
        "src/null_platform.h",
        "src/null_joystick.h",
        "src/null_init.c",
        "src/null_monitor.c",
        "src/null_window.c",
        "src/null_joystick.c"
    }

    -- Public include directory.
    includedirs {
        "include"
    }

    -- Windows backend.
    filter "system:windows"
        defines {
            "_GLFW_WIN32",
            "_GLFW_WGL"
        }

        files {
            "src/win32_platform.h",
            "src/win32_joystick.h",
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_module.c",
            "src/win32_monitor.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/wgl_context.c"
        }

        links {
            "user32",
            "gdi32",
            "shell32"
        }

    -- Linux backend (X11).
    filter "system:linux"
        defines {
            "_GLFW_X11",
            "_GLFW_GLX"
        }

        files {
            "src/x11_platform.h",
            "src/xkb_unicode.h",
            "src/x11_init.c",
            "src/x11_monitor.c",
            "src/x11_window.c",
            "src/xkb_unicode.c",
            "src/posix_module.c",
            "src/posix_time.c",
            "src/posix_thread.c",
            "src/glx_context.c",
            "src/linux_joystick.c"
        }

        links {
            "X11",
            "dl",
            "pthread"
        }

    -- macOS backend.
    filter "system:macosx"
        defines {
            "_GLFW_COCOA",
            "_GLFW_NSGL"
        }

        files {
            "src/cocoa_platform.h",
            "src/cocoa_joystick.h",
            "src/cocoa_init.m",
            "src/cocoa_joystick.m",
            "src/cocoa_monitor.m",
            "src/cocoa_window.m",
            "src/cocoa_time.c",
            "src/posix_module.c",
            "src/posix_thread.c",
            "src/nsgl_context.m"
        }

        links {
            "Cocoa.framework",
            "IOKit.framework",
            "CoreFoundation.framework",
            "QuartzCore.framework"
        }

    -- Visual Studio filters.
    filter {}

    vpaths {
        ["Header Files/*"] = {
            "include/glfw/**"
        },
        ["Source Files/*"] = {
            "src/**"
        }
    }
