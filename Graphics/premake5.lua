-- ============================================================================
-- Project: hello (static library)
-- Loaded from the root premake5.lua via `include "hello"`.
-- Paths in this file are relative to this folder (hello/).
-- Workspace-wide settings (C++ standard, warnings, output dirs, ...) are
-- inherited from the root script.
-- ============================================================================

local name = "hello"

project(name)
    kind "StaticLib"                        -- builds a .lib, no executable

    -- Source files. Globs are evaluated when premake runs, so re-run
    -- `premake5 vs2026` after adding or removing files.
    files {
        "include/**",
        "src/**"
    }

    -- Public headers live in include/<name>/, so users of this library write
    -- #include "hello/hello.h". Projects that link against hello must add
    -- "../hello/include" to their own includedirs (premake does not inherit it).
    includedirs { 
        "include"
    }

    -- How files are grouped in Visual Studio's Solution Explorer.
    -- Only the part after the fixed prefix of the pattern is kept as folders,
    -- so subfolders automatically become filters.
    --   include/hello/utils/x.h -> Header Files/utils/x.h
    --   src/hello/utils/x.cpp   -> Source Files/utils/x.cpp
    vpaths {
        ["Header Files/*"] = "include/" .. name .. "/**",
        ["Source Files/*"] = "src/**"
    }