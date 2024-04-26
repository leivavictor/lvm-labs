# Tips for Apache Security

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

## Hide Server headers

File located at /etc/apache2/conf-enabled/security.conf (Ubuntu)

Modify the following values:

```
ServerTokens Prod
```

```
ServerSignature Off
```

Then restart apache.

## Configure Headers

1. Enable module headers:

    ```bash
    sudo a2enmod headers
    ```

2. Restart Apache
    ```
    sudo systemctl restart apache2
    ```

3.  Check if the module is enabled

    ```
    apachectl -M
    ```

4. Configure your headers

    The configuration file is located in /etc/apache2/conf-enabled/security.conf 

    1. Add header:
        
        It can be done by adding the following lines

        a. Cross-Site Scripting
        ```
        Header set X-XSS-Protection "1; mode=block"
        ```

        b. Content-Security-Policy (CSP)
        ```
        Header set Content-Security-Policy "default-src 'self';"
        ```

        c. X-Frame-Options (Avoid ClickJacking)
        ```
        Header always append X-Frame-Options SAMEORIGIN
        ```

        This are just examples: More information at https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers