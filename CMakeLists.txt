# Define the minimum cmake. This is my installed version.
cmake_minimum_required (VERSION 2.8)

# Define the minimum policy version.
cmake_policy(VERSION 2.8)

# Define the project name.
project(SeasonHunter)

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")
set (PKGDATADIR "${DATADIR}/seasonhunter")
set (GETTEXT_PACKAGE "seasonhunter")
set (RELEASE_NAME "O-One")
set (VERSION "0.1")
set (CMAKE_C_FLAGS "-ggdb")

configure_file (${CMAKE_SOURCE_DIR}/src/config.vala.cmake ${CMAKE_SOURCE_DIR}/src/config.vala)
add_definitions(-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")

# Load the modules placed into the ./cmake directory.
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# Vala
find_package (Vala REQUIRED)
include (ValaVersion)
ensure_vala_version ("0.18.0" MINIMUM)
include (ValaPrecompile)

# Add the src directory. CMake will look for the CMakeLists.txt in this folder
# and work from there.
add_subdirectory (src)

include(GSettings)
add_schema ("data/org.diegotoral.seasonhunter.gschema.xml")
