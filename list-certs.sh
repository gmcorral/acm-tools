#/bin/bash
#######################
if [ "$#" -ne 0 ]; then
    echo "Usage: $0"
    exit 1
fi

aws acm list-certificates

echo "Done"
