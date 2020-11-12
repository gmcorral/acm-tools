#/bin/bash
# $1: domain name
# $2: private CA ARN
# $3: passphrase
#######################
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <domain_name> <private_CA_ARN> <passphrase>"
    exit 1
fi

CERT_ARN=$(aws acm  request-certificate --domain-name $1 --certificate-authority-arn $2 | jq '.CertificateArn' --raw-output)

echo "Created certificate $CERT_ARN"
echo "Exporting..."

EXPORT_OUT=$(aws acm export-certificate --certificate-arn $CERT_ARN --passphrase $3)

echo $EXPORT_OUT | jq '.Certificate' --raw-output > certificate.pem
echo $EXPORT_OUT | jq '.CertificateChain' --raw-output > certificate_chain.pem
echo $EXPORT_OUT | jq '.PrivateKey' --raw-output > private_key.pem

echo "Done"
