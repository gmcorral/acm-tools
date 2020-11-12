# acm-tools

Tools for AWS ACM private CA cert management

https://docs.aws.amazon.com/cli/latest/reference/acm/

## Private CA

https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-acmpca-certificateauthority.html

1. Create Private CA: https://docs.aws.amazon.com/acm-pca/latest/userguide/PcaCreateCa.html
2. Install autosigned CA certificate: https://docs.aws.amazon.com/acm-pca/latest/userguide/PCACertInstall.html
3. (optional) Create subordinate CA / CA hierarchy
4. (optional) Share Private CA in RAM with certificate issuing accounts: https://docs.aws.amazon.com/acm-pca/latest/userguide/pca-ram.html

### Params

```
KeyAlgorithm: EC_prime256v1 | EC_secp384r1 | RSA_2048 | RSA_4096
SigningAlgorithm:  SHA256WITHECDSA | SHA256WITHRSA | SHA384WITHECDSA | SHA384WITHRSA | SHA512WITHECDSA | SHA512WITHRSA

Country: string
Organization: string
OrganizationalUnit: string
DistinguishedNameQualifier: string
State: string
CommonName: string
SerialNumber: string
Locality: string

_Title: string_
_Surname: string_
_GivenName: string_
_Initials: DG_
_Pseudonym: string_
_GenerationQualifier: DBG_
```

## Certificates

https://docs.aws.amazon.com/acm-pca/latest/userguide/PcaUsing.html

1. Issue certificates: https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-private.html
2. Export certificates: https://docs.aws.amazon.com/acm/latest/userguide/export-private.html
3. Renew certificates: https://docs.aws.amazon.com/acm/latest/userguide/sdk-renew.html

### Params

```
CertificateAuthorityArn: string
CertificateSigningRequest: string

SigningAlgorithm: SHA256WITHECDSA | SHA256WITHRSA | SHA384WITHECDSA | SHA384WITHRSA | SHA512WITHECDSA | SHA512WITHRSA
Validity:
    Type: DAYS
    Value: number
```

### Certificate Signin Request (only for CloudFormation certificate creation)

The certificate signing request (CSR) for the certificate you want to issue. You can use the following OpenSSL command to create the CSR and a 2048 bit RSA private key.

```
openssl req -new -newkey rsa:2048 -days 365 -keyout private/test_cert_priv_key.pem -out csr/test_cert_.csr
```

If you have a configuration file, you can use the following OpenSSL command. The usr_cert block in the configuration file contains your X509 version 3 extensions.

```
openssl req -new -config openssl_rsa.cnf -extensions usr_cert -newkey rsa:2048 -days -365 -keyout private/test_cert_priv_key.pem -out csr/test_cert_.csr
```
