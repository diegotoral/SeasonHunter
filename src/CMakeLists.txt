find_package(Vala REQUIRED)

# Ensure we have a compatible version.
include(ValaVersion)
ensure_vala_version("0.11.3" MINIMUM)

# Include the precompile modules to set things up.
include(ValaPrecompile)

# Declaring our dependancies.
find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED gobject-2.0 glib-2.0 gio-2.0 gtk+-3.0 gee-1.0 granite)

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
    settings.vala
PACKAGES
    gtk+-3.0
    gee-1.0
    granite)

# Define the executable name.
add_executable(seasonhunter
    ${VALA_C} )

add_definitions (${DEPS_CFLAGS} -DWNCK_I_KNOW_THIS_IS_UNSTABLE)

# Link the libraries with our Executable.
target_link_libraries(seasonhunter ${DEPS_LIBRARIES})

install (TARGETS seasonhunter RUNTIME DESTINATION bin)
