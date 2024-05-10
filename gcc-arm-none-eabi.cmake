#Toolchain file contains which tools we use and what options are passed to them to produce the binary.

set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          arm)

# Some default GCC settings
# arm-none-eabi- must be part of path environment
set(DEPENDENCY_INFO_OPTIONS "-MMD   -MP    -MF \"$(@:%.o=%.d)\"") #unused
set(TOOLCHAIN_PREFIX                arm-none-eabi-)
set(MCU_FLAGS "-mcpu=cortex-m7 -mthumb -mfpu=fpv5-sp-d16 -mfloat-abi=hard" )
set(OPT "-Og")
set(CMAKE_C_FLAGS                         "${MCU_FLAGS} ${OPT} ${DEPENDENCY_INFO_OPTIONS} -DSTM32F746xx -Wall -std=gnu99 -fdata-sections -ffunction-sections")
set(CMAKE_ASM_FLAGS                       "${MCU_FLAGS} ${OPT}  -Wall -fdata-sections -ffunction-sections")
set(LINKER_SCRIPT                 "${PROJECT_SOURCE_DIR}/STM32F746NGHx_FLASH.ld")
set(CMAKE_EXE_LINKER_FLAGS "${MCU_FLAGS} -specs=nano.specs -T${LINKER_SCRIPT} -lc -lm -lnosys -Wl,-Map=${PROJECT_NAME}.map,--cref -Wl,--gc-sections ")

if(CMAKE_BUILD_TYPE MATCHES Debug)
    set(OPT "-O0 -g3")
endif()
if(CMAKE_BUILD_TYPE MATCHES Release)
    set(OPT " -Os -g0")
endif()
# Define which tools we use
set(CMAKE_C_COMPILER                ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER              ${CMAKE_C_COMPILER})
set(CMAKE_OBJCOPY                   ${TOOLCHAIN_PREFIX}objcopy)
set(CMAKE_SIZE                      ${TOOLCHAIN_PREFIX}size)

# Preven testing this cross-compiler on the host
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
