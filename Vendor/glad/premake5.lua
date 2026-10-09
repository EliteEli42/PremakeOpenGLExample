-- ============================================================================
-- Project: glad (static library)
-- Loaded from the root premake5.lua via `include "glad"`.
-- Paths in this file are relative to this folder (glad/).
-- Workspace-wide settings are inherited from the root script.
-- ============================================================================

project "glad"
    kind "StaticLib"
    language "C"

    -- Public headers and implementation.
    files {
        "include/**",
        "src/**"
    }

    -- Public headers.
    includedirs {
        "include"
    }

    -- Visual Studio filters.
    vpaths {
        ["Header Files/*"] = { 
            "include/glad/**",
            "include/KHR/**" 
        },
        ["Source Files/*"] = {
            "src/**"
        }
    }
