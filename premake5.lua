-- ============================================================================
-- Root Premake script. Run `premake5 vs2026` in this folder to generate the
-- Visual Studio solution in ./build (open build/PremakeOpenGLExample.sln afterwards).
-- Re-run it whenever files are added/removed or any .lua file is changed.
-- ============================================================================

SolutionRoot = _SCRIPT_DIR

workspace "PremakeOpenGLExample"
    -- Build configurations that show up in Visual Studio's dropdown.
    --   Debug   = development, no optimization, full debug info
    --   Release = optimized, but still with symbols/logging for testing
    --   Dist    = final build for shipping (see its filter below)
    configurations { "Debug", "Release", "Dist" }
    architecture "x86_64"                 -- 64-bit only
    location "build"                      -- generated solution/project files go here
    startproject "HelloWindow"            -- project that starts with F5

    -- Working directory used when debugging from Visual Studio.
    -- %{wks.basedir} = folder of this script. The folder must exist
    -- (keep it in git with a .gitkeep file).
    debugdir "%{wks.basedir}/DebugDir"

    -- Silence warnings coming from "external" headers. Headers only count as
    -- external if their folder is listed in `externalincludedirs` (set per
    -- project, e.g. for third-party libraries). Your own code keeps all warnings.
    externalwarnings "Off"

    -- ---- Language and compiler settings (apply to ALL projects) ----------
    language "C++"
    cppdialect "C++20"
    staticruntime "On"              -- link the C/C++ runtime statically (/MT):
                                    -- no VC++ Redistributable needed on the
                                    -- target PC. Must be the same in ALL
                                    -- projects, otherwise you get linker errors.
    warnings "Extra"                -- high warning level (/W4)
    conformancemode "On"            -- strict standard conformance (/permissive-)
    multiprocessorcompile "On"      -- compile files in parallel (/MP)

    -- Output folders. Tokens are resolved per configuration and project:
    --   %{cfg.buildcfg} = Debug / Release / Dist
    --   %{prj.name}     = name of the project being built
    targetdir "build/bin/%{cfg.buildcfg}/%{prj.name}" -- final .exe / .lib
    objdir    "build/obj/%{cfg.buildcfg}/%{prj.name}" -- intermediate .obj files

    -- ---- Conditional settings --------------------------------------------
    -- A `filter` applies to everything below it until the next filter.
    -- `filter {}` at the end resets it.

    filter "system:windows"
        systemversion "latest"      -- use the newest installed Windows SDK
        -- Stops windows.h from defining min/max macros (clash with std::min)
        -- and excludes rarely used parts of the Windows API (faster builds).
        defines { "NOMINMAX", "WIN32_LEAN_AND_MEAN" }

    filter "toolset:msc*"           -- Microsoft compiler (MSVC) only
        buildoptions { "/utf-8" }   -- source and execution charset = UTF-8
                                    -- (avoids trouble with umlauts in strings)

    filter "configurations:Debug"
        defines { "DEBUG" }
        runtime "Debug"             -- debug runtime (/MTd), checks heap etc.
        symbols "On"                -- generate debug info (PDB)

    filter "configurations:Release"
        defines { "NDEBUG" }        -- disables assert()
        runtime "Release"           -- release runtime (/MT)
        optimize "On"               -- optimize for speed
        symbols "On"                -- keep PDB so crashes can be analyzed

    filter "configurations:Dist"
        defines { "NDEBUG", "DIST" } -- check `#ifdef DIST` to strip logging etc.
        runtime "Release"
        optimize "Full"             -- maximum optimization
        symbols "Off"               -- no debug info in the shipped build
        linktimeoptimization "On"   -- whole-program optimization (/GL, /LTCG);
                                    -- slower build, faster/smaller result

    filter {}                       -- reset: following settings apply to all again

    -- ---- Projects --------------------------------------------------------------
    -- Each line loads <folder>/premake5.lua. Paths inside those files are
    -- relative to their own folder. Must come AFTER the workspace block above
    -- so the projects belong to it and inherit its settings.

    -- Automatically mirror project script directories inside build/.
    -- Example: Examples/HelloWindow -> build/Examples/HelloWindow

    local originalProject = project

    function project(name)
        -- Create the project normally.
        originalProject(name)

        -- Determine the directory of the currently executing project script.
        local projectDir = path.getrelative(SolutionRoot, _SCRIPT_DIR)

        -- Keep projects defined directly in the repository root in build/.
        if projectDir == "." then
            location(path.join(SolutionRoot, "build"))
        else
            location(path.join(SolutionRoot, "build/Projects", projectDir))
        end
    end

    include "Vendor"

    include "Examples"