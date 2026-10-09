-- ============================================================================
-- Project: glm (header-only library)
-- Loaded from the root premake5.lua via `include "glm"`.
-- Paths in this file are relative to this folder (glm/).
-- Workspace-wide settings are inherited from the root script.
-- ============================================================================

project "glm"
    kind "Utility"
    language "C++"

    -- GLM is a header-only library.
    files {
        "include/**"
    }

    -- GLM headers.
    -- This assumes the downloaded GLM repository contains the glm/ folder
    -- directly next to this premake5.lua.
    includedirs { 
        "include"
    }

    -- Visual Studio filters.
    vpaths {
        ["Header Files/*"] = {
            "include/glm/**.h"
        },
        ["Source Files/*"] = {
            "include/glm/**"
        }
    }
