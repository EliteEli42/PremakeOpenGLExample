local name = "HelloTriangle"

project(name)
    -- Application type per configuration.
    filter "configurations:Debug"
        kind "ConsoleApp"                   -- console window (see std::cout output)

    filter "configurations:not Debug"       -- Release and Dist
        kind "WindowedApp"                  -- Windows subsystem (no console window)
        entrypoint "mainCRTStartup"         -- keep plain main() as entry point
                                            -- (otherwise the linker wants WinMain)

    filter {}                               -- reset filter

    -- Source files. Globs are evaluated when premake runs, so re-run
    -- `premake5 vs2026` after adding or removing files.
    files {
        "include/**",
        "src/**"
    }

    -- Include search paths (used for #include "..." and #include <...>).
    -- Without "include" here, the project cannot find its own headers in
    -- include/<name>/, e.g. #include "HelloWorld/HelloWorld.h".
    includedirs {
        "include",                          -- own headers
    }

    externalincludedirs {
        path.join(SolutionRoot, "Vendor/glad/include"),
        path.join(SolutionRoot, "Vendor/glfw/include"),
        path.join(SolutionRoot, "Vendor/glm/include")
    }
    
    links { 
        "glad",                             -- link against the glad library
        "glfw"                              -- link against the glfw library
    }                       

    -- How files are grouped in Visual Studio's Solution Explorer.
    -- Only the part after the fixed prefix of the pattern is kept as folders,
    -- so subfolders automatically become filters.
    --   include/HelloWorld/utils/x.h -> Header Files/utils/x.h
    --   src/utils/x.cpp              -> Source Files/utils/x.cpp
    vpaths {
        ["Header Files/*"] = "include/" .. name .. "/**",
        ["Source Files/*"] = "src/**"
    }