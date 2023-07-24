#!/bin/bash

#
# > STATUS code that returned by this script.



# Project Idea: File Organizer
# The goal of this project is to create a Bash script that organizes files in a specified directory based on their file types into separate subdirectories. This can be useful to keep your directories clean and tidy by automatically sorting files into appropriate categories.
#Features:
#The script should take a directory path as an argument and organize the files within that directory.
#It should create subdirectories based on the file extensions (e.g., "txt" for text files, "jpg" for image files).
#Files with unknown or no file extensions should be placed in a "misc" subdirectory.
#If a subdirectory for a particular file type already exists, the script should move the files into that existing directory.
#The script should handle edge cases, such as files with no extensions or hidden files (those starting with a dot).
# please provide status exit code for each case with echo message detect the failure.


################################################################################################
# SUPPORTED file extenstions: .txt, .jpg, .png, .hidden files.                                 #
################################################################################################
SUPPORTED_EXTENSIONS=('txt' 'jpg' 'png' '.')
###############################################################################################
# Helper functions:
# 1. createDirectory.
###############################################################################################
createDirectory(){ 
    local DIR_NAME=$1 # first argument.
    if [ ! -d ${DIR_NAME} ] # check if directory is exists.
    then
        mkdir -p ${DIR_NAME}
        echo "${DIR_NAME} is created".
    fi
}


# read directory.
read DIR

# check if directory is exists or not.
if [ -d ${DIR} ]
then

    # read all files inside this directory.
    for file in `dir -a ${DIR}`;
    do
        # check if its file.
        if [ ! -f ${file} ];
        then
            echo ${file} " is not a file"
            continue # skip directories.
        fi
        # pattern matching, get extension.
        FILE_EXTENSION=${file##*.}

        FILE_EXTENSION=$(echo $FILE_EXTENSION | tr [:upper:] [:lower:])
        DIRECTORY_PATH=${file%/*}
        FILE_NAME=${file##*/}

        if [ ${FILE_EXTENSION} == ${SUPPORTED_EXTENSIONS[0]} ];
        then
            # text folder.
            createDirectory "${DIRECTORY_PATH}/text"
            echo "Move:" ${file} "to --->: " "${DIRECTORY_PATH}/text/${FILE_NAME}"
            mv ${file} "${DIRECTORY_PATH}/text/${FILE_NAME}"
        elif [ ${FILE_EXTENSION} == ${SUPPORTED_EXTENSIONS[1]} ];
        then
            # jpg folder.
            createDirectory "${DIRECTORY_PATH}/jpg"
            echo "Move:" ${file} "to --->: " "${DIRECTORY_PATH}/jpg/${FILE_NAME}"
            mv ${file} "${DIRECTORY_PATH}/jpg/${FILE_NAME}"
        elif [ ${FILE_EXTENSION} == ${SUPPORTED_EXTENSIONS[2]} ];
        then
            # png folder.
            createDirectory "${DIRECTORY_PATH}/png"
            echo "Move:" ${file} "to --->: " "${DIRECTORY_PATH}/png/${FILE_NAME}"
            mv ${file} "${DIRECTORY_PATH}/png/${FILE_NAME}"

        elif [[ "${FILE_NAME}" == ^.* ]];
        then
            # hidden folder.
            #echo hidden
            createDirectory "${DIRECTORY_PATH}/hidden"
            echo "Move:" ${file} "to --->: " "${DIRECTORY_PATH}/hidden/${FILE_NAME}"
            mv ${file} "${DIRECTORY_PATH}/hidden/${FILE_NAME}"
        else
            # miscellaneous folder.
            createDirectory "${DIRECTORY_PATH}/misc"
            echo "Move:" ${file} "to --->: " "${DIRECTORY_PATH}/misc/${FILE_NAME}"
            mv ${file} "${DIRECTORY_PATH}/misc/${FILE_NAME}"
        fi

    done
else
    echo "${DIR}, Directory is not exists"
    exit 1
fi


