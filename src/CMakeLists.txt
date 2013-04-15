find_package(Vala REQUIRED)

# Ensure we have a compatible version.
include(ValaVersion)
ensure_vala_version("0.11.3" MINIMUM)

# Include the precompile modules to set things up.
include(ValaPrecompile)

find_package(PkgConfig)

# Declaring our dependancies.
pkg_check_modules(DEPS REQUIRED gtk+-3.0)

set(CFLAGS
    ${DEPS_CFLAGS} ${DEPS_CFLAGS_OTHER}
)
set(LIB_PATHS
    ${DEPS_LIBRARY_DIRS}
)
link_directories(${LIB_PATHS})

add_definitions(${CFLAGS} "-DGETTEXT_PACKAGE=\"seasonhunter\"")
vala_precompile(VALA_C
    main.vala
    config.vala
    season-hunter.vala
PACKAGES
    gtk+-3.0)

# Define the executable name.
add_executable(seasonhunter
    ${VALA_C} )

add_definitions (${DEPS_CFLAGS} -DWNCK_I_KNOW_THIS_IS_UNSTABLE)

# Link the libraries with our Executable.
target_link_libraries(seasonhunter ${DEPS_LIBRARIES})

install (TARGETS seasonhunter RUNTIME DESTINATION bin)