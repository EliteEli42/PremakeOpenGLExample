
-- ============================================================================
-- Root Premake script
-- Generates project files for Visual Studio and GNU Make 2.
-- ============================================================================

SolutionRoot = _SCRIPT_DIR

-- Build output directory.
-- Example:
--   --build-dir=VS2022  -> build/VS2022
--   --build-dir=gmake2  -> build/gmake2
--   no option           -> build/

newoption {
    trigger = "build-dir",
    value = "DIR",
    description = "Name of the build output subdirectory"
}

local BuildRoot = path.join(SolutionRoot, "build")
local BuildDirName = _OPTIONS["build-dir"]

if BuildDirName and BuildDirName ~= "" then
    BuildRoot = path.join(BuildRoot, BuildDirName)
end

workspace "PremakeOpenGLExample"
    configurations { "Debug", "Release", "Dist" }
    architecture "x86_64"

    location(BuildRoot)
    startproject "HelloWindow"

    -- Working directory for launched applications.
    debugdir(path.join(SolutionRoot, "DebugDir"))

    language "C++"
    cppdialect "C++20"
    warnings "Extra"

    -- Output directories for all projects.
    targetdir(path.join(
        BuildRoot, "bin", "%{cfg.buildcfg}", "%{prj.name}"
    ))

    objdir(path.join(
        BuildRoot, "obj", "%{cfg.buildcfg}", "%{prj.name}"
    ))

    -- Common Windows settings.
    filter "system:windows"
        systemversion "latest"
        defines {
            "NOMINMAX",
            "WIN32_LEAN_AND_MEAN"
        }

    -- MSVC-specific settings.
    filter "toolset:msc*"
        conformancemode "On"
        multiprocessorcompile "On"
        buildoptions { "/utf-8" }
        externalwarnings "Off"

        -- Static MSVC runtime.
        staticruntime "On"

    filter "configurations:Debug"
        defines { "DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"
        symbols "On"

    filter "configurations:Dist"
        defines { "NDEBUG", "DIST" }
        optimize "Full"
        symbols "Off"

    -- Link-time optimization is enabled for MSVC distribution builds.
    filter { "configurations:Dist", "toolset:msc*" }
        linktimeoptimization "On"

    filter {}

-- ============================================================================
-- Automatically place each project's generated files below:
-- build/<build-dir>/Projects/<source-script-directory>
--
-- Examples:
--   Examples/HelloWindow -> build/.../Projects/Examples/HelloWindow
--   Vendor/glfw          -> build/.../Projects/Vendor/glfw
-- ============================================================================

local originalProject = project

function project(name)
    originalProject(name)

    local projectDir = path.getrelative(
        SolutionRoot,
        _SCRIPT_DIR
    )

    if projectDir == "." then
        location(BuildRoot)
    else
        location(path.join(BuildRoot, "Projects", projectDir))
    end
end

-- ============================================================================
-- Projects
-- ============================================================================

include "Vendor"
include "Examples"
