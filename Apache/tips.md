# Tips

## Sites Configuration File

${apache_installation_folder}/sites-available

Example: /etc/apache2/sites-available/

### Enable HTTPS:

- Open Site configuration File

- Add the following configuration

    ```
    <VirtualHost *:443>
        ServerName example.com
        DocumentRoot $projectLocation

        SSLEngine on
        SSLCertificateFile $CertLocation/certificate.crt
        SSLCertificateKeyFile $CertLocation/key.pem

        # Optional: Intermedia Certificates
        SSLCertificateChainFile $CertLocation/intermediate.crt

    </VirtualHost>

    ```


