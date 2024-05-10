# Lib containing HAL drivers developed by STMicroelectronics
# HAL drivers provide an abstraction layer for accessing hardware

add_library(STM32_HAL_LIB INTERFACE)
target_include_directories(STM32_HAL_LIB INTERFACE Inc Inc/Legacy)
file(GLOB SRC_FILES Src/*.c)
target_sources(STM32_HAL_LIB INTERFACE ${SRC_FILES})
target_compile_definitions(STM32_HAL_LIB INTERFACE "USE_HAL_DRIVER") 

