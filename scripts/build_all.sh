#!/bin/bash

##############################################################################################
# CONFIGURATION                                                                              #
##############################################################################################

BUILD_PIXYMON=1
BUILD_GET_BLOCKS_CPP_DEMO=1
BUILD_GET_LINES_CPP_DEMO=1
BUILD_CHIRP_COMMAND_CPP_DEMO=1
BUILD_LIBPIXYUSB2=1

##############################################################################################
# SCRIPT START                                                                               #
##############################################################################################

rm -rdf ../build

function WHITE_TEXT {
  printf "\033[1;37m"
}
function NORMAL_TEXT {
  printf "\033[0m"
}
function GREEN_TEXT {
  printf "\033[1;32m"
}
function RED_TEXT {
  printf "\033[1;31m"
}

function TIME_DELTA () {
  # TIME_DELTA <START> <END>
  printf "($((($2 - $1) / 60)) m $((($2 - $1) % 60)) s)"
}

##############################################################################################
# PIXYMON                                                                                    #
##############################################################################################

if [ $BUILD_PIXYMON == 1 ]; then
  SECONDS=0
  PIXYMON_START=$SECONDS
  ./build_pixymon_src.sh
  PIXYMON_END=$SECONDS
fi

##############################################################################################
# LIBPIXYUSB2                                                                                #
##############################################################################################

if [ $BUILD_LIBPIXYUSB2 == 1 ]; then
  ./build_libpixyusb2.sh
fi

##############################################################################################
# CHIRP COMMAND CPP DEMO                                                                     #
##############################################################################################

if [ $BUILD_CHIRP_COMMAND_CPP_DEMO == 1 ]; then
  ./build_chirp_command_cpp_demo.sh
fi

##############################################################################################
# GET BLOCKS CPP DEMO                                                                        #
##############################################################################################

if [ $BUILD_GET_BLOCKS_CPP_DEMO == 1 ]; then
  ./build_get_blocks_cpp_demo.sh
fi

##############################################################################################
# GET LINES CPP DEMO                                                                         #
##############################################################################################

if [ $BUILD_GET_LINES_CPP_DEMO == 1 ]; then
  ./build_get_lines_cpp_demo.sh
fi

##############################################################################################
# BUILD RESULTS                                                                              #
##############################################################################################

WHITE_TEXT
echo "########################################################################################"
echo "# BUILD RESULTS"

echo "#"

if [ $BUILD_PIXYMON == 1 ]; then
  WHITE_TEXT
  printf "# PixyMon ......................................................... "
  if [ -f ../build/pixymon/PixyMon ]; then
    GREEN_TEXT
    printf "SUCCESS "
  else
    RED_TEXT
    printf "FAILURE "
  fi
  WHITE_TEXT
  TIME_DELTA $PIXYMON_START $PIXYMON_END
  echo ""
fi

if [ $BUILD_LIBPIXYUSB2 == 1 ]; then
  WHITE_TEXT
  printf "# libpixyusb2 ..................................................... "
  if [ -f ../build/libpixyusb2/libpixy2.a ]; then
    GREEN_TEXT
    printf "SUCCESS "
  else
    RED_TEXT
    printf "FAILURE "
  fi
  echo ""
fi

if [ $BUILD_CHIRP_COMMAND_CPP_DEMO == 1 ]; then
  WHITE_TEXT
  printf "# chirp_command_cpp_demo .......................................... "
  if [ -f ../build/chirp_command_cpp_demo/chirp_command_cpp_demo ]; then
    GREEN_TEXT
    printf "SUCCESS "
  else
    RED_TEXT
    printf "FAILURE "
  fi
  echo ""
fi

if [ $BUILD_GET_BLOCKS_CPP_DEMO == 1 ]; then
  WHITE_TEXT
  printf "# get_blocks_cpp_demo ............................................. "
  if [ -f ../build/get_blocks_cpp_demo/get_blocks_cpp_demo ]; then
    GREEN_TEXT
    printf "SUCCESS "
  else
    RED_TEXT
    printf "FAILURE "
  fi
  echo ""
fi

if [ $BUILD_GET_LINES_CPP_DEMO == 1 ]; then
  WHITE_TEXT
  printf "# get_lines_cpp_demo .............................................. "
  if [ -f ../build/get_lines_cpp_demo/get_lines_cpp_demo ]; then
    GREEN_TEXT
    printf "SUCCESS "
  else
    RED_TEXT
    printf "FAILURE "
  fi
  echo ""
fi

WHITE_TEXT
echo "########################################################################################"
NORMAL_TEXT
