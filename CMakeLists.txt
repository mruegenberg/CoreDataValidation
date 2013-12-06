cmake_minimum_required(VERSION 2.8.5)
project(CoreDataValidation)

set(CMAKE_OSX_SYSROOT iphoneos5.0)
set(CMAKE_OSX_ARCHITECTURES "armv6;armv7;i386")
set(CMAKE_XCODE_EFFECTIVE_PLATFORMS "-iphoneos;-iphonesimulator")

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/Classes
)

set(M_SRCS NSEntityDescription+DLValidation.m)
set(HEADERS NSEntityDescription+DLValidation.h)

add_library(CoreDataValidation ${M_SRCS} ${HEADERS})

target_link_libraries(CoreDataValidation
  "-framework CoreFoundation"
  "-framework CoreData"
  )

set_target_properties(CoreDataValidation PROPERTIES
   MACOSX_BUNDLE_GUI_IDENTIFIER "com.yourcompany.CoreDataValidation"
   MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist.in
   RESOURCE "${RESOURCES}"
   XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
   XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT "dwarf-with-dsym"
   XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET 5.0
   )
