#Toolchain file contains which tools we use and what options are passed to them to produce the binary.

set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          arm)

# Some default GCC settings
# arm-none-eabi- must be part of path environment
set(DEPENDENCY_INFO_OPTIONS "-MMD   -MP    -MF \"$(@:%.o=%.d)\"") 
set(TOOLCHAIN_PREFIX                arm-none-eabi-)
set(MCU_FLAGS "-mcpu=cortex-m7 -mthumb -mfpu=fpv5-sp-d16 -mfloat-abi=hard" )
set(WARNING_FLAGS "-Wall -Wextra -Wpedantic")

# Parameters varying depending on the build type
if(CMAKE_BUILD_TYPE MATCHES Debug)
    set(OPT "-O0 -g3")
endif()
if(CMAKE_BUILD_TYPE MATCHES Release)
    set(OPT " -Os -g0")
endif()

# Compiler flags
set(CMAKE_C_FLAGS   "${MCU_FLAGS} ${OPT} ${DEPENDENCY_INFO_OPTIONS} ${WARNING_FLAGS}  -fdata-sections -ffunction-sections -DSTM32F746xx")

# Assembly flags
set(CMAKE_ASM_FLAGS  "${CMAKE_C_FLAGS}")

# Linker flags
set(CMAKE_C_LINK_FLAGS "${MCU_FLAGS}")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -T \"${CMAKE_SOURCE_DIR}/STM32F746NGHx_FLASH.ld\"")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} --specs=nano.specs")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -Wl,-Map=${CMAKE_PROJECT_NAME}.map -Wl,--gc-sections")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -Wl,--start-group -lc -lm -Wl,--end-group")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -Wl,--print-memory-usage")

# Define which tools we use
set(CMAKE_C_COMPILER                ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER              ${CMAKE_C_COMPILER})
set(CMAKE_OBJCOPY                   ${TOOLCHAIN_PREFIX}objcopy)
set(CMAKE_SIZE                      ${TOOLCHAIN_PREFIX}size)

# Preven testing this cross-compiler on the host
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
