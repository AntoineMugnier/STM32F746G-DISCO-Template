cmake_minimum_required(VERSION 3.22)
project(F746) # project name
enable_language(C ASM)

# Add every directory containing children CMakeLists
add_subdirectory(Drivers/CMSIS)
add_subdirectory(Drivers/STM32F7xx_HAL_Driver)
add_subdirectory(Core)

# Include toolchain file
include("${PROJECT_SOURCE_DIR}/gcc-arm-none-eabi.cmake")

set(EXECUTABLE                      ${CMAKE_PROJECT_NAME}.elf)
add_executable(${EXECUTABLE})

# Link project libraries to the executable
target_link_libraries(${EXECUTABLE} PRIVATE STM32_HAL_LIB)
target_link_libraries(${EXECUTABLE} PRIVATE STM32_CMSIS_LIB)
target_link_libraries(${EXECUTABLE} PRIVATE CORE_LIB)

# Add startup ASM file to executable
target_sources(${EXECUTABLE} PRIVATE  "startup_stm32f746xx.s")

# Define the default build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

# Generate .hex and .bin executables in addition to the .elf one
set(HEX_FILE ${PROJECT_SOURCE_DIR}/build/${CMAKE_PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_SOURCE_DIR}/build/${CMAKE_PROJECT_NAME}.bin)

add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${EXECUTABLE}> ${HEX_FILE}
  COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${EXECUTABLE}> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE} \nBuilding ${BIN_FILE}")

