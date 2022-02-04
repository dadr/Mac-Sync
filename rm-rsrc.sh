# /bin/sh
Directory="."
verbose="false"
removed=0
   case ${1} in
       "pix" )
          Directory="/Volumes/PhotoDisk/Photos Library.photoslibrary/Masters"
          ;;
       -h | --help | "")
          echo "usage: $0 [-hv --help  --verbose] pix | directory-to-remove-forks"
          exit
          ;;
       -v | --verbose )
          verbose="true"
          ;;
       * )
          Directory="${1}"
          ;;
    esac
    if [ $verbose = "true" ]; then
        shift
        Directory="${1}"
        if [${Directory} = ""]; then
            echo "usage: $0 [-hv --help  --verbose] pix | directory-to-remove-forks"
            exit 1
        fi
    fi
echo "Removing Resource Forks from: "$Directory
sleep 3
OIFS="$IFS"
IFS=$'\n'

for file in `find "${Directory}" -type f -xattrname 'com.apple.ResourceFork'`
do
    if [ $verbose = "true" ]; then
        echo "${file}"
    else
        echo -n "."
    fi

    # Don't use xattr b/c of poor performance
    # xattr -d "com.apple.ResourceFork" "${file}"
    cat /dev/null > "${file}/..namedfork/rsrc"
    removed=`expr $removed + 1`
done
IFS="$OIFS"
echo
echo $removed forks removed.
