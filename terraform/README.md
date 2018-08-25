# Terraform Templates

## Getting Started

1. Install terraform

1. Set credentials

    ```
    $ export AWS_ACCESS_KEY_ID=YOUR-AWS-ACCESS-KEY
    $ export AWS_SECRET_ACCESS_KEY=YOUR-AWS-SECRET-ACCESS-KEY
    ```

1. Go to environment directory

    **Staging**

    ```
    $ cd env/stg
    ```

    **Production**

    ```
    $ cd env/prod
    ```

1. Get the modules

    ```
    $ terraform get
    ```

1. Execute `plan`

    ```
    $ terraform plan
    ```

1. Apply

    ```
    $ terraform apply
    ```
