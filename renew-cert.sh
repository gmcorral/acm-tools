#/bin/bash
# $1: certificate ARN
# $2: passphrase
#######################
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <certificate_arn> <passphrase>"
    exit 1
fi

aws acm renew-certificate --certificate-arn $1

echo "Renewed certificate $1"
echo "Exporting..."

# wait 5 secs to allow cert renewal to finish
sleep 5

aws acm export-certificate --certificate-arn $1 --passphrase $2
exit 0
EXPORT_OUT=$(aws acm export-certificate --certificate-arn $1 --passphrase $2)

echo $EXPORT_OUT | jq '.Certificate' --raw-output > certificate.pem
echo $EXPORT_OUT | jq '.CertificateChain' --raw-output > certificate_chain.pem
echo $EXPORT_OUT | jq '.PrivateKey' --raw-output > private_key.pem

echo "Done"
