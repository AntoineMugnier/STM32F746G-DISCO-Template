# Lib for all application-specific files
add_library(CORE_LIB INTERFACE)
target_include_directories(CORE_LIB INTERFACE Inc)
file(GLOB SRC_FILES Src/*.c)
target_sources(CORE_LIB INTERFACE ${SRC_FILES})

