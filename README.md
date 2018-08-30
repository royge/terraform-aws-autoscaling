# AWS Autoscaling Template

[![Build Status](https://travis-ci.org/royge/terraform-aws-autoscaling.svg?branch=master)](https://travis-ci.org/royge/terraform-aws-autoscaling)

**WARNING:** You are fully aware that AWS resources created by this template
are not always free even during tests.

## Getting Started

1. Clone the repo

    ```
    $ git clone git@github.com:royge/terraform-aws-autoscaling.git
    ```

1. Install [terraform](https://www.terraform.io/downloads.html)

    ```
    $ wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
    $ sudo unzip -o -d /usr/local/bin terraform_0.11.8_linux_amd64.zip
    $ terraform version
    ```

1. Initialize and validate

    ```
    $ ENV=test make init
    $ ENV=test make validate
    ```

1. Execute plan

    ```
    $ ENV=test make plan
    ```

1. Execute apply

    ```
    $ ENV=test make apply
    ```

1. Execute destroy

    ```
    $ ENV=test make destroy
    ```

## TODO

1. Unit testing docs.
1. Make `userdata.sh` location configurable
