cmake_minimum_required(VERSION 3.2)

project(dbtest)

set(CMAKE_CXX_STANDARD 20)
set(CMALE_CXX_STANDARD_REQUIERED ON)


add_executable(dbtest main.cpp)


set_target_properties(dbtest PROPERTIES
	WIN32_EXECUTABLE ON
	MACOSX_BUNDLE ON
)
